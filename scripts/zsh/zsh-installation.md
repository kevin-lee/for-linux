
```shell
sudo apt-get update && sudo apt-get install zsh 
```

Install oh-my-zsh from https://github.com/robbyrussell/oh-my-zsh 

* Using curl

```shell
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
```
OR

* Using wget

```shell
wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh
```

Change the default shell to z-shell

```shell
chsh -s /bin/zsh 
```
## Install Powerline Fonts for `agnoster` theme
**It is not necessary for Server**

```shell
git clone https://github.com/powerline/fonts powerline-fonts 
cd powerline-fonts 
./install.sh 
```

* Open `~/.zshrc` and change (** Do only this on Server**)

```shell
ZSH_THEME="robbyrussell"
```
to

```shell
ZSH_THEME="agnoster"
```

## Install `zsh-syntax-highlighting` plugin

```shell
cd ~/.oh-my-zsh/custom/plugins 
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git 
```

* Open `~/.zshrc` and change

```shell
plugins=(git)
```
to

```shell
plugins=(git zsh-syntax-highlighting)
```
