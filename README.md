# Joey's Dotfiles Repo

## Disclaimer

This repository hosts my dotfiles setup and hooks in tools I really like. It is only meant for my personal use for now and likely forever.

I firmly believe it's a bad idea to just copy somebody else's setup entirely, so I'd encourage you to explore the tools and projects you come across here on your own.

## Notes

The structure follows this [guide](https://www.atlassian.com/git/tutorials/dotfiles) but adds the use of git submodules for the tools I use.

* `.tools` contains utilities that need to be installed locally, mostly via the typical GNU autotools pipeline

```bash
./configure --prefix=<install path, normally /usr/local/ or ~/.local>
make install
```
  * There's a script, `.extra/install/compile.sh` that can take care of this kind of thing too.

* `.ssh/ssh_config` contains some boilerplate. Note that `.ssh` doesn't contain any `id_*` files, as that'd be really really really really bad if it did. Much care was taken with the `.gitignore` so that didn't happen. It also doesn't do anything client side since that normally goes in `.ssh/config`
* `.extra` contains some well, extra things, including a Dockerfile that recreates this whole shin-dig. Vagrantfile is in progress still. I will also likely explore Ansible as an alternative to some of this craziness.
* `.config/fish` contains my fish related aliases, functions and path mangling. It's what I currently use
* `.custom-bash` contains my own bash aliases, functions, and path mangling. All of these files are sourced by [bash-it](https://github.com/Bash-it/bash-it)
* I don't believe any of this stuff is POSIX compliant, it's all assumed to be run under a `bash` login shell, as that seems to be the lowest common denominator of the places I'm allowed to log into (lookin' at you, `zsh` people).

## Roadmap

* Streamline and document the process of using `.extra/install/*` which can be used to bootstrap a new system.
This can be verified using the content of `.extra/docker` or `.extra/vagrant`
