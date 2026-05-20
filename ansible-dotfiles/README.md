To run everything that doesn't require sudo, do

`uv run ansible-playbook dotfiles.yml --skip-tags
 become`

To run everything, including sudo tasks, use

`uv run ansible-playbook dotfiles.yml -K`

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

I suppose ansible_become_password is not available when you use connection: local
Thanks ansible
