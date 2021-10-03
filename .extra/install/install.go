package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"os/exec"
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

func getDistroGroup() *distroGroup {
	distro := ""
	if _, err := os.Stat(distroFilename); err == nil {
		fileBytes, _ := ioutil.ReadFile(distroFilename)
		contents := strings.Split(string(fileBytes), "\n")
		for _, line := range contents {
			parts := strings.Split(line, "=")
			if len(parts) != 2 {
				continue
			}
			if parts[0] == "DISTRIB_ID" {
				distro = parts[1]
			}
		}
	}
	for _, dg := range distroGroups {
		for _, name := range dg.names {
			if name == distro {
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

func main() {
	d := getDistroGroup()
	if d != nil {
		fmt.Println("Distro family:", d.names[0])
		fmt.Println("Distro package manager:", d.manager)
	} else {
		fmt.Println("no distro info available")
		return
	}
	checkErr(d.runUpdate())
	toInstall := []string{"git", "vim"}
	checkErr(d.runInstall(toInstall...))
}
