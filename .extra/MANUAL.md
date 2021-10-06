# Installing autojump

```bash
cd autojump
./install.py
```
or  `apt install autojump`

# Installing universal ctags

```bash
cd ctags
./autogen.sh
./configure --prefix=/where/you/want # defaults to /usr/local
make
make install
```
or `apt install universal-ctags`

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

# Install silver searcher

```bash
cd .tools/the_silver_searcher
./build.sh
<configure if you want to>
make install
```
or `apt install silversearcher-ag`
