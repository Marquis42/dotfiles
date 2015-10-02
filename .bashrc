# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

if [ "$TERM" = "rxvt" ]; then
 TERM=ansi
 COLORTERM=ansi
else
 TERM=xterm-256color
fi

command -v powerline-daemon &>/dev/null
if [ $? -eq 0 ]; then
    powerline-daemon -q
    POWERLINE_BASH_CONTINUATION=1
    POWERLINE_BASH_SELECT=1
    PL1=/usr/share/powerline/bash/powerline.sh
    PL2=/usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh
    if [ -f $PL1 ] ; then
        . $PL1
    elif [ -f $PL2 ] ; then
        . $PL2
    fi
fi

if [ -f ~/.agent.env ] ; then
    . ~/.agent.env > /dev/null
    if ! kill -0 $SSH_AGENT_PID > /dev/null 2>&1; then
        echo "Stale agent file found. Spawning new agent… "
        eval `ssh-agent | tee ~/.agent.env`
        ssh-add ~/.ssh/marquis42
    fi
else
    echo "Starting ssh-agent"
    eval `ssh-agent | tee ~/.agent.env`
    ssh-add ~/.ssh/marquis42
fi

export GOPATH=$HOME/src/gocode/:$HOME
PATH=$PATH:/usr/local/go/bin:/home/mrbmw/src/gocode/bin
alias vi=vimx
alias mosh='mosh -p 10000:20000'
