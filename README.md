#  Agora Chat Sample for iOS

This repository provides feature-level Chat samples with Swift.

## Getting Started
You must use [tuist](https://github.com/tuist/tuist) to build these sample apps.
1. Install tuist
The recommended installation method is to install mise and then run mise install tuist to install Tuist.
* Install mise
```
$ curl https://mise.run | sh
$ ~/.local/bin/mise --version
2024.2.7 macos-x64 (2024-02-08)
```
Hook mise into your shell (pick the right one for your shell):
```
# note this assumes mise is located at ~/.local/bin/mise
# which is what https://mise.run does by default
echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc
echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
echo '~/.local/bin/mise activate fish | source' >> ~/.config/fish/config.fish
```
* Install tuist via mise
```
$ mise use --global tuist@3.27.0
$ tuist version
3.27.0
```
2. Install Dependencies
```
tuist fetch
```
3. Generate Xcode project & workspace
```
tuist generate 
```
For more details: [Tuist Docs](https://docs.old.tuist.io/tutorial/get-started)


