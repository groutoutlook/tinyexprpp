shebang := if os() == 'windows' { 'pwsh.exe' } else { '/usr/bin/env pwsh' }
set shell := ["pwsh", "-c"]
set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]
set dotenv-load := true
# INFO: really dont want to meddle with the .env, direnv is also related to this.
# WARN: should have get them in .gitignore.
set dotenv-filename	:= ".env"
# set dotenv-required := true
export JUST_ENV := "just_env" # WARN: this is also a method to export env var. 
help:
    @just --list -f "{{home_directory()}}/justfile"

default_arg := 'TODO:'
alias td := todo
todo todo_arg=default_arg:
    rg {{todo_arg}} -g '!justfile' -g "!third_party" 

hello:
    @Write-Host "Hello, world!" -ForegroundColor Yellow

placeholder args="nothing":
    #!{{ shebang }}
    Write-Host "Havent written build task for this repo." -ForegroundColor Red
    if($env:pwsh_env) {Write-Host "$env:pwsh_env and {{args}} as ``just`` args"}
    else {Write-Host "Apparently no .env as well" -ForegroundColor Yellow}

alias b := build
build: (placeholder "from build") 

alias fmt := format
format args="nothing":
    clang-format -i *.h *.cpp 

# INFO: basic `run` recipe.
alias r := run
default_args := 'args here'
run args=default_args:
    ./bin/te_demo.exe

var_test := "test format"
alias t := test
test *args=var_test: (format args) && (placeholder "'from test'") 
    # also something directly test behaviour.

wt:
    #!{{ shebang }}
    wt -f new-tab -p "Developer PowerShell for VS 2022" -d  {{ invocation_directory() }} --tabColor '#FFFFFF'
    
# alias dox := makedoc
# makedoc:
#     cd ./docs ; doxygen ./Doxyfile ; start ./html/index.html
