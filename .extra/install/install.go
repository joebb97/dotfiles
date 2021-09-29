package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"strings"
)

type distroGroup struct {
	names   []string
	manager string
}

var distroGroups = []distroGroup{
	{names: []string{"Pop", "Ubuntu", "Mint"}, manager: "apt"},
	{names: []string{"ManjaroLinux", "ArchLinux"}, manager: "pacman"},
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

func main() {
	distro := getDistroGroup()
	fmt.Println(distro.names, distro.manager)
}
