# User-specific z-shell shell configuration.


# Path to oh-my-zsh.
export ZSH="$ZDOTDIR/.oh-my-zsh"
if [[ -z $ZSH_THEME ]]; then
    ZSH_THEME="af-magic" #"theunraveler"
fi

plugins=(
    'colored-man-pages'
    'colorize'
    'git'
    'osx'
    'z'
    'zsh-navigation-tools'
)


source "$ZSH/oh-my-zsh.sh"
source "$ZDOTDIR/.zload"


# GNU Privacy Guard.
GPG_TTY=$(tty)
export GPG_TTY


# Preferred editor for local and remote sessions.
export EDITOR="/usr/bin/nano"


# iTerm 2 shell integration.
if [[ -e "$ZDOTDIR/.iterm2_shell_integration.zsh" ]]; then
    source "${ZDOTDIR}/.iterm2_shell_integration.zsh"
fi


# Python
export PYTHONSTARTUP="/Users/admin/Developer/Terminal/Python/.pyenv"
export PYTHONPATH="$DEV/Terminal/Python:$PYTHONPATH"


precmd_functions+=( ref )


#plugins=(
#    adb
#    alias-finder
#    ansible
#    ant
#    apache2-macports
#    arcanist
#    archlinux
#    asdf
#    #autoenv
#    #autojump
#    autopep8
#    aws
#    battery
#    bbedit
#    bgnotify
#    boot2docker
#    bower
#    branch
#    #brew
#    bundler
#    cabal
#    cake
#    cakephp3
#    capistrano
#    #cargo
#    #cask
#    catimg
#    celery
#    chruby
#    #chucknorris
#    cloudapp
#    cloudfoundry
#    codeclimate
#    coffee
#    #colemak
#    colored-man-pages
#    colorize
#    command-not-found
#    common-aliases
#    compleat
#    composer
#    copybuffer
#    copydir
#    copyfile
#    cp
#    cpanm
#    dash
#    debian
#    dircycle
#    #direnv
#    dirhistory
#    dirpersist
#    django
#    dnf
#    dnote
#    docker
#    docker-compose
#    docker-machine
#    doctl
#    dotenv
#    dotnet
#    droplr
#    drush
#    eecms
#    emacs
#    ember-cli
#    emoji
#    emoji-clock
#    emotty
#    encode64
#    extract
#    fabric
#    fancy-ctrl-z
#    fasd
#    fastfile
#    fbterm
#    fd
#    fedora
#    firewalld
#    flutter
#    forklift
#    #fossil
#    frontend-search
#    #fzf
#    gas
#    gatsby
#    gb
#    gcloud
#    geeknote
#    gem
#    git
#    git-auto-fetch
#    git-escape-magic
#    git-extras
#    git-flow
#    git-flow-avh
#    git-hubflow
#    git-prompt
#    git-remote-branch
#    gitfast
#    github
#    gitignore
#    glassfish
#    globalias
#    gnu-utils
#    go
#    golang
#    gpg-agent
#    gradle
#    grails
#    grunt
#    gulp
#    hanami
#    helm
#    heroku
#    history
#    history-substring-search
#    hitokoto
#    homestead
#    httpie
#    ionic
#    iterm2
#    jake-node
#    jenv
#    jfrog
#    jhbuild
#    jira
#    jruby
#    jsontools
#    jump
#    kate
#    #keychain
#    kitchen
#    knife
#    knife_ssh
#    kops
#    kube-ps1
#    kubectl
#    laravel
#    laravel4
#    laravel5
#    last-working-dir
#    lein
#    lighthouse
#    lol
#    macports
#    magic-enter
#    man
#    marked2
#    mercurial
#    meteor
#    microk8s
#    minikube
#    mix
#    mix-fast
#    mosh
#    mvn
#    mysql-macports
#    n98-magerun
#    nanoc
#    ng
#    nmap
#    node
#    nomad
#    npm
#    npx
#    nvm
#    #nyan
#    oc
#    osx
#    otp
#    pass
#    paver
#    pep8
#    per-directory-history
#    percol
#    perl
#    perms
#    phing
#    pip
#    pipenv
#    pj
#    please
#    pod
#    postgres
#    pow
#    powder
#    powify
#    profiles
#    pyenv
#    pylint
#    python
#    #rails
#    rake
#    rake-fast
#    rand-quote
#    rbenv
#    rbfu
#    react-native
#    rebar
#    redis-cli
#    repo
#    ripgrep
#    ros
#    rsync
#    ruby
#    rust
#    rvm
#    safe-paste
#    salt
#    sbt
#    scala
#    scd
#    screen
#    scw
#    sdk
#    sfdx
#    sfffe
#    shrink-path
#    singlechar
#    spring
#    sprunge
#    #ssh-agent
#    stack
#    sublime
#    sudo
#    supervisor
#    suse
#    svcat
#    svn
#    svn-fast-info
#    swiftpm
#    symfony
#    symfony2
#    systemadmin
#    systemd
#    taskwarrior
#    terminitor
#    terraform
#    textastic
#    textmate
#    thefuck
#    themes
#    thor
#    tig
#    timer
#    tmux
#    tmux-cssh
#    tmuxinator
#    torrent
#    transfer
#    tugboat
#    ubuntu
#    ufw
#    urltools
#    vagrant
#    vagrant-prompt
#    vault
#    vi-mode
#    vim-interaction
##    virtualenv
##    virtualenvwrapper
#    vscode
#    vundle
#    wakeonlan
#    wd
#    web-search
#    wp-cli
#    xcode
#    yarn
#    yii
#    yii2
#    yum
#    z
#    zeus
#    zsh-interactive-cd
#    zsh-navigation-tools
#    zsh_reload
#)





