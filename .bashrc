# .bashrc

CURRENT_VIRTUALENV="env1"
export EDITOR=vim

unalias ll 2>/dev/null

alias 1='fg %1'
alias 2='fg %2'
alias 3='fg %3'
alias 4='fg %4'
alias quit='exit'
alias bye='exit'
alias adios='exit'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ls='ls -A'
alias ll='ls -lhA'
alias lf='ls -AF'
alias lt='ls -lArth'
alias ld='ls -dA'
alias h='history 100'
alias shit='git'
alias Cat='echo;cat'
alias env='env|sort'

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

#export CHROMEDRIVER_HOME=$HOME/sel/chromedrivers
#export SELENIUM_HOME=$HOME/sel
#export PATH=$CHROMEDRIVER_HOME:/usr/local/share/npm/bin:$PATH
#export CLASSPATH=$SELENIUM_HOME:$CLASSPATH
#export PYTHONPATH=$HOME/git:$HOME/git/reach:$HOME/git/reach/qetest:$HOME/Selenium:./:../:$PYTHONPATH
#export PYTHONPATH=$PYTHONPATH:$HOME/git:$HOME/git/reach:$HOME/git/reach/cloudkick:$HOME/git/reach/cloudkick/extern:./:../:../../:../../../

# Lots of PATH malarky
unset PATH
PATH=/usr/local/bin:/usr/local/git/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/X11/bin:./:../:../../:../../../
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"

export PATH

export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
export WORKON_HOME=$HOME/.python_virtualenvs
source /Library/Frameworks/Python.framework/Versions/2.7/bin/virtualenvwrapper.sh
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true

stty erase '^?'

# Set up a nifty prompt

function pwdPath {
    # How many characters of the $PWD should be kept
    local pwdmaxlen=40
    # Indicator that there has been directory truncation:
    local trunc_symbol="..."
    if [ ${#PWD} -gt $pwdmaxlen ]; then
        local pwdoffset=$(( ${#PWD} - $pwdmaxlen ))
        newPWD="${trunc_symbol}${PWD:$pwdoffset:$pwdmaxlen}"
    else
        newPWD=${PWD}
    fi
    echo $newPWD
}

parse_git_branch () {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/\* \(.*\)/ (\1)/'
}

if [ "$PS1" ];then
    #export PS1="\n\[\e[0;93m\][\u@$HOSTNAME]\[\e[0m\] \$(pwdPath)\n\[\033[0;92m\]\$(parse_git_branch)\[\033[0m\] \[\033[0;96m\]\t\[\033[0m\] \[\e[0;93m\]\\$\[\e[0m\] "
    export PS1="\n[\u@macbook] \$(pwdPath)\n\[\e[0;92m\]\$(parse_git_branch)\[\e[0m\] \t \\$ "
    export INTERACTIVE_SHELL=1
else
    export INTERACTIVE_SHELL=0
fi


#export LS_OPTIONS='--color=auto'
#export TERM="xterm-color"
#export CLICOLOR=1
#export LSCOLORS="Gxagexbxcxegedabacafad"

# zsh
# alias vim="stty stop '' -ixoff ; vim"
# `Frozing' tty, so after any command terminal settings will be restored
# ttyctl -f

# bash
# No ttyctl, so we need to save and then restore terminal settings
vim()
{
#    local STTYOPTS="$(stty --save)"
    stty stop '' -ixoff
    command vim "$@"
#    stty "$STTYOPTS"
}
vi()
{
#    local STTYOPTS="$(stty --save)"
    stty stop '' -ixoff
    command vim "$@"
#    stty "$STTYOPTS"
}

has_virtualenv() {
    if [ -e .venv ]; then
        workon `cat .venv`
    fi
}
venv_cd () {
    cd "$@" && has_virtualenv
}

alias cd="venv_cd"

function snova {
    supernova inova-dfw "$@"
}
function snova-quota {
    supernova inova-dfw absolute-limits
}
function update-selenium {
    gem update selenium-webdriver
    sudo pip install --upgrade selenium
}
function ffusion {
    for session in $(screen -ls | grep -o '[0-9]*\.fusionportforwards'); do screen -S "${session}" -X quit; done
    screen -dmS fusionportforwards
    sleep 1
    screen -S fusionportforwards -p 0 -X exec ssh -A -L 2525:localhost:2525 -L 3306:localhost:3306 -L 4187:localhost:4187 -L 7070:localhost:7070 -L 8000:localhost:8000 -L 8001:localhost:8001 -L 8410:localhost:8410 -L 8983:localhost:8983 -L 11211:localhost:11211 vagrant@192.168.123.129
    screen -ls
    ssh vagrant@192.168.123.129
}
function gotovm {
    ssh vagrant@192.168.123.129
}
function goback {
    cd $OLDPWD
}
function vt {
    mvim --remote-tab $@ > /dev/null 2>&1
}
function slow {
    top -o cpu
}
function chars {
    count=`echo $@ | wc -c`
    echo $(( $count-1 ))
}
# function rm {
#    /usr/bin/srm -mziv $@
#}
function selenium-upgrade {
    sudo pip install --upgrade selenium
}
function msftkill {
    echo -e "Killing off any Microsoft Database Daemon"
    sudo /usr/bin/killall "Microsoft Database Daemon"
    echo -e "Killing off any Microsoft Office Reminders"
    sudo /usr/bin/killall "Microsoft Office Reminders"
}
function r {
   fc -e - $@
}
function pu {
    pushd $@
}
function po {
    popd $@
}
function psg {
    /bin/ps -ea | egrep -i $1 | grep -v grep
}
function Find {
    /usr/bin/find . -name "*$1***" -a -print 2>/dev/null
}
function pur {
    /bin/rm -f *~ .*~ #* >& /dev/null
}
function purgeall {
    /usr/bin/find . -name "*.~*" -a -print | xargs -i rm {}
}
function mancat {
    tbl $1:1 | neqn | nroff -man | col -b
}
function dfk {
    df -k $1
}
function dfk. {
    dfk .
}

# Automatically load the current Python virtualenv

python_autoenv () {
  workon $CURRENT_VIRTUALENV
}

python_autoenv
