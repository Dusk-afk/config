# My Config
Welcome to my config! This is a collection of my dotfiles and configurations for various programs that I use. I have tried to keep everything as organized as possible, so feel free to look around and use anything you find useful.

## Installation
### 1. Clone the repository
```bash
git clone
```

### 2. Install the dotfiles
#### Linux / macOS
Use GNU Stow to install the dotfiles:
```bash
stow package1 package2
```

#### Windows
1. Download [Stow Clone](https://github.com/mattialancellotti/Stow) made for Windows.
2. Use the following command to install the dotfiles:
```powershell
# Administrator privileges required
.\winstow.ps1 -Stowdir "C:\destination\path" -Sourcedir "C:\path\to\dotfiles" -Stow package1 package2
```

Example:
```powershell
.\winstow.ps1 -Stowdir "C:\Users\<USERNAME>" -Sourcedir "D:\...\config" -Stow yasb wezterm
```