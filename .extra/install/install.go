package main

import (
	"bufio"
	"fmt"
	"io/ioutil"
	"os"
	"os/exec"
	"os/user"
	"strings"
)

type distroGroup struct {
	names      []string
	manager    string
	installCmd []string
	updateCmd  string
}

func (d *distroGroup) run(args ...string) error {
	asStr := fmt.Sprint(args)
	fmt.Println("Running", d.manager, asStr[1:len(asStr)-1])
	err := exec.Command(d.manager, args...).Run()
	return err
}

func (d *distroGroup) runUpdate() error {
	return d.run(d.updateCmd)
}

func (d *distroGroup) runInstall(packs ...string) error {
	args := append(d.installCmd, packs...)
	return d.run(args...)
}

var distroGroups = []distroGroup{
	{
		names:      []string{"Debian", "Pop", "Ubuntu", "Mint"},
		manager:    "apt-get",
		installCmd: []string{"install", "-y"},
		updateCmd:  "update",
	},
	{
		names:      []string{"Arch", "ManjaroLinux", "ArchLinux"},
		manager:    "pacman",
		installCmd: []string{"-S"},
		updateCmd:  "-Syu",
	},
}

const distroFilename = "/etc/lsb-release"
const osInfoFilename = "/etc/os-release"

func parseInfoFile(fname string, key string) string {
	if _, err := os.Stat(fname); err == nil {
		fileBytes, _ := ioutil.ReadFile(fname)
		contents := strings.Split(string(fileBytes), "\n")
		for _, line := range contents {
			parts := strings.Split(line, "=")
			if len(parts) != 2 {
				continue
			}
			if parts[0] == key {
				return parts[1]
			}
		}
	}
	return ""
}

func getDistroGroup() *distroGroup {
	lsbInfo := parseInfoFile(distroFilename, "DISTRIB_ID")
	osInfo := parseInfoFile(osInfoFilename, "ID")
	for _, dg := range distroGroups {
		for _, name := range dg.names {
			lowerName := strings.ToLower(name)
			lowerLsbInfo := strings.ToLower(lsbInfo)
			lowerOsInfo := strings.ToLower(osInfo)
			if lowerName == lowerLsbInfo || lowerName == lowerOsInfo {
				return &dg
			}
		}
	}
	return nil
}

func checkErr(err error) {
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}

func asUser(user string, cmd string, args ...string) *exec.Cmd {
	fullArgs := []string{"-u", user, cmd}
	fullArgs = append(fullArgs, args...)
	asStr := fmt.Sprint(fullArgs)
	fmt.Println("Running sudo", asStr[1:len(asStr)-1])
	return exec.Command("sudo", fullArgs...)
}

func parseEnvStr(env string) func(string) string {
	theMap := make(map[string]string)
	lines := strings.Split(env, "\n")
	for _, line := range lines {
		asSplit := strings.Split(line, "=")
		if len(asSplit) != 2 {
			continue
		}
		theMap[asSplit[0]] = asSplit[1]
	}
	return func(envVar string) string {
		if val, ok := theMap[envVar]; ok {
			return val
		}
		return ""
	}
}

func main() {
	d := getDistroGroup()
	argc := len(os.Args)
	if d != nil {
		fmt.Println("Distro family:", d.names[0])
		fmt.Println("Distro package manager:", d.manager)
	} else {
		fmt.Println("no distro info available")
		return
	}
	if argc >= 2 && os.Args[1] == "--skip-packages" {
		fmt.Println("Skipping installing packages")
	} else {
		checkErr(d.runUpdate())
		toInstall := []string{"git", "vim", "sudo"}
		// toInstall := []string{"git", "sudo"}
		checkErr(d.runInstall(toInstall...))
	}
	instUser, err := user.Current()
	if argc >= 2 {
		newUserName := os.Args[argc-1]
		instUser, err = user.Lookup(newUserName)
		if err == nil {
			if instUser.HomeDir != "" {
				fmt.Println("home dir already exists for", instUser.Username)
			}
		} else {
			fmt.Println("Adding new user", newUserName)
			checkErr(exec.Command("adduser", newUserName).Run())
			instUser, err = user.Lookup(newUserName)
			checkErr(err)
		}
	} else if err == nil && instUser.HomeDir != "" {
		fmt.Println("home dir already exists for", instUser.Username,
			"who is running this script")
	}
	if instUser.Username == "root" {
		stdin := bufio.NewReader(os.Stdin)
		fmt.Print("Are you sure you want to setup dotfiles for root ? [n/Y]: ")
		textb, err := stdin.ReadString('\n')
		text := string(textb)
		if err != nil || (text != "y" && text != "Y") {
			return
		}
	}
	cfgDir := fmt.Sprintf("%s/.cfg", instUser.HomeDir)
	if _, err = os.Stat(cfgDir); err != nil {
		gitArgs := []string{"clone", "--depth", "1", "--bare",
			"https://github.com/joebb97/dotfiles", cfgDir}

		checkErr(asUser(instUser.Username, "git", gitArgs...).Run())
		cfgCommandArgs := []string{
			fmt.Sprintf("--git-dir=%s/.cfg/", instUser.HomeDir),
			fmt.Sprintf("--work-tree=%s", instUser.HomeDir),
		}
		fullArgs := append(cfgCommandArgs, "checkout", "-f")
		checkErr(asUser(instUser.Username, "git", fullArgs...).Run())
		fullArgs = append(cfgCommandArgs, "submodule", "update", "--init")
		submodCmd := asUser(instUser.Username, "git", fullArgs...)
		submodCmd.Dir = instUser.HomeDir
		checkErr(submodCmd.Run())
	} else {
		fmt.Println(cfgDir, "already exists, skipping")
	}
	mkdirArgs := []string{"-p", fmt.Sprintf("%s/src", instUser.HomeDir)}
	checkErr(asUser(instUser.Username, "mkdir", mkdirArgs...).Run())

	sandDir := fmt.Sprintf("%s/src/sandbox", instUser.HomeDir)
	if _, err = os.Stat(sandDir); err != nil {
		gitArgs := []string{"clone", "--depth", "1",
			"https://github.com/joebb97/sandbox", sandDir}
		checkErr(asUser(instUser.Username, "git", gitArgs...).Run())
	} else {
		fmt.Println(sandDir, "already exists, skipping")
	}
	checkErr(asUser(instUser.Username, "vim", "+PlugInstall", "+qall").Run())
}
