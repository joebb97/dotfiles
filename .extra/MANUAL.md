# Installing autojump

```bash
cd autojump
./install.py
```

# Installing universal ctags

```bash
cd ctags
./autogen.sh
./configure --prefix=/where/you/want # defaults to /usr/local
make
make install
```

# Installing vim

```bash
cd vim
./configure --with-features=huge \
            --enable-pythoninterp \
            --enable-python3interp \
            --enable-multibyte \
            --enable-terminal \
            --prefix=<whereyouwant> \
```

# Installing pip

```bash
python $HOME/.tools/get-pip.py
```
