alias ga='git add'
alias gb='git branch'
alias gbd='git branch -d '
alias br="git for-each-ref --sort=committerdate refs/heads/ --format='%(align:1)%(HEAD)%(end) %(align:32)%(color:green)%(committerdate:iso)%(color:reset)%(end) %(align:40)%(color:yellow)%(refname:short)%(color:reset)%(end) %(authorname) | %(align:50)%(contents:subject)%(end)'"
alias branch="git for-each-ref --sort=committerdate refs/heads/ --format='%(align:1)%(HEAD)%(end) %(align:32)%(color:green)%(committerdate:iso)%(color:reset)%(end) %(align:40)%(color:yellow)%(refname:short)%(color:reset)%(end) %(authorname) | %(align:50)%(contents:subject)%(end)'"
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout master'
alias gd='git diff'
alias gda='git diff HEAD'
alias gi='git init'
alias gl='git log'
alias glg='git log --graph --oneline --decorate --all'
alias gld='git log --pretty=format:"%h %ad %s" --date=short --all'
alias gm='git merge --no-ff'
alias gp='git pull'
alias gpom='git pull origin master'
alias gfom='git fetch origin master'
alias gss='git status -s'
alias gst='git stash'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gstd='git stash drop'

# Git log find by commit message
function glf() { git log --all --grep="$1"; }

# run emacs daemon if not running and connect
alias emacs='emacsclient -c -a ""'
alias doom='~/.emacs.d/bin/doom'

updateGoToolchain() {
    installs=(
        github.com/golangci/golangci-lint/cmd/golangci-lint
        github.com/mgechev/revive
        github.com/cweill/gotests/...
        github.com/davidrjenni/reftools/cmd/fillstruct
        github.com/fatih/gomodifytags
        github.com/go-delve/delve/cmd/dlv
        github.com/godoctor/godoctor
        github.com/josharian/impl
        github.com/ramya-rao-a/go-outline
        github.com/rogpeppe/godef
        github.com/uudashr/gopkgs
        github.com/zmb3/gogetdoc
        golang.org/x/lint/golint
        golang.org/x/tools/cmd/godoc
        golang.org/x/tools/cmd/goimports
        golang.org/x/tools/cmd/gorename
        golang.org/x/tools/cmd/guru
        golang.org/x/tools/gopls
    )
    for d in ${installs[@]}; do
        echo Updating $d
        GO111MODULE=on go install -v -trimpath -ldflags '-s -w' $d@latest
    done
}

installVSCodeExtensions() {
    installs=(
	ms-python.python
	ms-vscode-remote.remote-containers
	ms-vscode-remote.remote-ssh
	ms-vscode-remote.remote-ssh-edit
	ms-vscode.Go
	vscodevim.vim
    )
    for d in ${installs[@]}; do
        echo Installing $d
	code --install-extension $d
    done
}
