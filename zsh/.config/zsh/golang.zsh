export GOROOT=/usr/local/go
export GOPATH=$HOME/code/go
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin

# macOS config
# export GOROOT=/usr/local/go
# export GOPATH=$HOME/go
# export GOBIN=$HOME/go/bin
# export PATH=$PATH:$GOPATH/bin:$GOROOT/bin

alias golint='golangci-lint run --skip-dirs=static --skip-dirs-use-default -E gosec -E goimports --exclude G107'
alias fmt='goimports -w . && go mod tidy'
alias gocc='fmt && golint && go vet ./...'
alias gs='golangci-lint run -E golint,depguard,gocognit,goconst,gofmt,misspell'
alias gdv='godotenv'
alias gt='APP_ENV=dev go test --cover --race ./...'
alias gr='APP_ENV=stage go run main.go'
