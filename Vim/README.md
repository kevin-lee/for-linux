# Vim

## Change Color Theme
### Solarized
* Get [vim-colors-solarized](https://github.com/altercation/vim-colors-solarized "vim-colors-solarized").
* Install (Create the folder, `~/.vim/colors/`, if doesn't exist).

```shell
$ cp colors/solarized.vim ~/.vim/colors/ 
```
* Edit `/etc/vim/vimrc` or `/etc/vim/vimrc.local` or `~/.vimrc`

```shell
" if has('gui_running')
"     set background=light
" else
"     set background=dark
" endif
set t_Co=16
let g:solarized_termcolors=16
colorscheme solarized
```

### Monokai
* Get [vim-monokai](https://github.com/sickill/vim-monokai "vim-monokai").
* Install

```shell
$ cp colors/Monokai.vim ~/.vim/colors/ 
```
* Edit `/etc/vim/vimrc` or `/etc/vim/vimrc.local` or `~/.vimrc`

```shell
set t_Co=256
colorscheme Monokai
```

### Molokai
* Get [molokai](https://github.com/tomasr/molokai "molokai").
* Install

```shell
$ cp colors/molokai.vim ~/.vim/colors/ 
```
* Edit `/etc/vim/vimrc` or `/etc/vim/vimrc.local` or `~/.vimrc`

```shell
set t_Co=256
colorscheme molokai
```

# GVim
## Intall GVim

```shell
$ apt-get install vim-gnome 
```

## Change Color Theme
### Solarized
* Install it (Check out [Solarized for Vim](#solarized))
* Edit `/etc/vim/gvimrc` or `/etc/vim/gvimrc.local` or `~/.gvimrc`

```
colorscheme solarized
```

### Monokai
* Install it (Check out [Monokai for Monokai](#monokai))
* Edit `/etc/vim/gvimrc` or `/etc/vim/gvimrc.local` or `~/.gvimrc`

```
colorscheme Monokai
```

### Molokai
* Install it (Check out [Molokai for Vim](#molokai))
* Edit `/etc/vim/gvimrc` or `/etc/vim/gvimrc.local` or `~/.gvimrc`

```
colorscheme molokai
```