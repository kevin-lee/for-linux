export JAVA_HOME=/usr/lib/jvm/java-7-openjdk

alias update='apt-get update'
alias upgrade='apt-get upgrade'
alias sshnp='ssh -o PubkeyAuthentication=no'
alias scpnp='scp -o PubkeyAuthentication=no'

alias psflash='ps aux | grep flash | grep -v grep | awk "{ print \$2; }"'
alias killflash='kill -9 `ps aux | grep flash | grep -v grep | awk "{ print \\$2; }"`'
# alias killflash="kill -9 \`ps aux | grep flash | grep -v grep | awk '{ print \$2; }'\`"

alias psjava='ps aux |  grep -v grep | grep java'
alias tomcatlog='tail -f -n 200 /path/to/TOMCAT_HOME/logs/catalina.out'
alias tomcat='/etc/init.d/tomcat'
alias ngx='/etc/init.d/nginx'
alias ap2='/etc/init.d/apache2'

gitpullall()
{
  repos_to_ignore="origin github"
  should_ignore=-1

  echo "running: git pull"
  git pull
  echo ""

  for remote in `git remote`
    do

    for ignore in $repos_to_ignore
      do
        [ "$remote" == "$ignore" ] && should_ignore=1 || :
    done

    if [ "$should_ignore" == "-1" ]
      then
      echo "running: git pull $remote master"
      git pull $remote master
      echo ""
    fi
  done
}



PS1="\n\[\e[30;1m\]\[\016\]-\[\017\](\[\e[34;1m\]\u@\h\[\e[30;1m\])-(\[\e[34;1m\]\j\[\e[30;1m\])-(\[\e[34;1m\]\@ \d\[\e[30;1m\])->\[\e[30;1m\]\n-(\[\e[32;1m\]\w\[\e[30;1m\])-(\[\e[32;1m\]\$(/bin/ls -1 | /usr/bin/wc -l | /bin/sed 's: ::g') files, \$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b\[\e[30;1m\])\n\[\e[0m\]$ "

PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD}\007"'
