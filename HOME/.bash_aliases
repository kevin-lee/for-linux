export JAVA_HOME=/usr/lib/jvm/java-7-openjdk

alias ls='ls -G'

alias sshnp='ssh -o PubkeyAuthentication=no'
alias scpnp='scp -o PubkeyAuthentication=no'

alias update='sudo apt-get update'
alias upgrade='sudo apt-get upgrade'
alias download4upgrade='sudo apt-get -d upgrade'
alias install='sudo apt-get install'
alias remove='sudo apt-get remove'
alias purge='sudo apt-get purge'

alias psflash='ps aux | grep flash | grep -v grep | awk "{ print \$2; }"'
alias killflash='kill -9 `ps aux | grep flash | grep -v grep | awk "{ print \\$2; }"`'
# alias killflash="kill -9 \`ps aux | grep flash | grep -v grep | awk '{ print \$2; }'\`"

alias psaux='ps aux | grep -v "grep --color=auto" | grep'
alias psjava='ps aux |  grep -v grep | grep java'

alias gitlog='git log --decorate=full --graph'
alias gitlogfull='git log --decorate=full --graph --pretty=fuller'
alias gittotallines='git ls-files | xargs file | grep ".*: .* text" | sed "s;\(.*\): .* text.*;\1;" | xargs wc -l'

alias git-push-remote-add='git remote set-url origin --add'
alias git-pull-remote-add='git remote add'

alias git-checkout-from-multiple-remote-repos='echo -e "\ngit checkout -b <localBranch> <remote>/<remoteBranch>\n  e.g.)\n  git checkout -b some-branch origin/some-branch\n"'
alias git-pull-branch-without-checkout='echo -e "\n\e[0;31mWARNING: only for fast-forward\e[m\n\ngit fetch <remote> <sourceBranch>:<destinationBranch>\n  e.g.)\n  git fetch origin master:master\n"'

alias ngx='sudo /etc/init.d/nginx'

alias tomcatlog='tail -f -n 200 /path/to/TOMCAT_HOME/logs/catalina.out'
alias tomcat='sudo /etc/init.d/tomcat'
alias ap2='sudo /etc/init.d/apache2'

alias setup-scala='sudo ~/Documents/my-scripts/setup-scala.sh'

gitpullall()
{
  repos_to_ignore="origin"
  should_ignore=-1

  echo "running: git pull"
  git pull
  echo ""

  for remote in `git remote`
    do
    echo "=================================="
    echo "Remote: $remote"
    echo "----------------------------------"
    for ignore in $repos_to_ignore
      do
      [ "$remote" == "$ignore" ] && { should_ignore=1; break; } || :
    done

    if [ "$should_ignore" == "-1" ]
      then
      THIS_BRANCH_NAME=`git rev-parse --abbrev-ref HEAD`
      git branch -r | grep -s "^[[:space:]]\+$remote/$THIS_BRANCH_NAME$" 2>&1 > /dev/null || git branch -r | grep -s "^[[:space:]]\+$remote/$THIS_BRANCH_NAME""[[:space:]]\+" 2>&1 > /dev/null || {
        echo "No info of the remote repo named '$remote' is found."
        echo "So $remote will be fetched."
        echo "running: git fetch $remote"
        git fetch "$remote"
        echo ""
      }
      if git branch -r | grep -sw "$remote/$THIS_BRANCH_NAME" 2>&1 > /dev/null ; then
        echo "running: git pull $remote $THIS_BRANCH_NAME"
        git pull "$remote" "$THIS_BRANCH_NAME"
      else
        echo "$THIS_BRANCH_NAME branch does not exist on the remote called '$remote'."
        echo "So $remote will not be pulled from $remote."
      fi
    else
      echo "$remote is on the ignored list so ignore it."
      echo "Ignored: $remote"
    fi
    should_ignore=-1
    echo "=================================="
    echo ""
  done
}

search_file() {
  if [ ! -n "$1" ]
    then
    echo "Please enter a word to search"
    exit
  fi
  for file in `find . -type f`; do grep -H "$1" $file; done
}


PS1="\n\[\e[30;1m\]\[\016\]-\[\017\](\[\e[34;1m\]\u@\h\[\e[30;1m\])-(\[\e[34;1m\]\j\[\e[30;1m\])-(\[\e[34;1m\]\@ \d\[\e[30;1m\])->\[\e[30;1m\]\n-(\[\e[32;1m\]\w\[\e[30;1m\])-(\[\e[32;1m\]\$(/bin/ls -1 | /usr/bin/wc -l | /bin/sed 's: ::g') files, \$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b\[\e[30;1m\])\n\[\e[0m\]$ "

PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD}\007"'
