## Linux bootstrap

On a fresh Debian-like Linux machine, run the bootstrap once as root:

```sh
./bootstrap.sh
```

The root branch installs the apt packages needed to run Ansible and then runs
`create-user.yml`.

Then run the same script as `joey`:

```sh
./bootstrap.sh
```

The `joey` branch installs uv in `/home/joey/.local/bin`, syncs the Python
environment, and runs `dotfiles-linux.yml`.

## Linux VM testing

The Vagrant test VM uses QEMU and a local Debian trixie box built from Debian's
cloud image.

```sh
brew install qemu
vagrant plugin install vagrant-qemu
./scripts/build-trixie-qemu-box.sh
vagrant up --provider=qemu
```

Then bootstrap inside the VM:

```sh
vagrant ssh
cd /opt/ansible-dotfiles
sudo ./bootstrap.sh
su - joey
cd /opt/ansible-dotfiles
./bootstrap.sh
```

To run everything that doesn't require sudo, do

`uv run ansible-playbook dotfiles-mac.yml --skip-tags
 become`

To run everything, including sudo tasks, use

`uv run ansible-playbook dotfiles-mac.yml`

The macOS playbook prompts for `ansible_become_password` directly so it can be
shared by regular `become: true` tasks and Homebrew casks that need
`sudo_password`. The prompt is tagged `become`, so it is skipped by
`--skip-tags become`.
