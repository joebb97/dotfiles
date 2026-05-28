To run everything that doesn't require sudo, do

`uv run ansible-playbook dotfiles-mac.yml --skip-tags
 become`

To run everything, including sudo tasks, use

`uv run ansible-playbook dotfiles-mac.yml`

```
joey@nocloud:~/ansible-dotfiles$ ./install-uv.sh
downloading uv 0.11.14 x86_64-unknown-linux-gnu
installing to /home/joey/.local/bin
  uv
  uvx
everything's installed!

To add $HOME/.local/bin to your PATH, either restart your shell or run:

    source $HOME/.local/bin/env (sh, bash, zsh)
    source $HOME/.local/bin/env.fish (fish)
joey@nocloud:~/ansible-dotfiles$ source $HOME/.local/bin/env
joey@nocloud:~/ansible-dotfiles$ uv sync
```

The macOS playbook prompts for `ansible_become_password` directly so it can be
shared by regular `become: true` tasks and Homebrew casks that need
`sudo_password`. The prompt is tagged `become`, so it is skipped by
`--skip-tags become`.
