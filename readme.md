# 🌌 Termux Desktop (Inspired From Adi1090x / Aditya Shakya)
![Stars](https://img.shields.io/github/stars/taezeem14/termux-desktop?style=for-the-badge\&logo=github\&color=blue)
![Forks](https://img.shields.io/github/forks/taezeem14/termux-desktop?style=for-the-badge\&logo=github\&color=purple)
![License](https://img.shields.io/github/license/taezeem14/termux-desktop?style=for-the-badge\&logo=opensourceinitiative\&color=green)
![Made with Termux](https://img.shields.io/badge/Made%20with-Termux-black?style=for-the-badge\&logo=android\&color=teal)
![Platform](https://img.shields.io/badge/Platform-Android-orange?style=for-the-badge\&logo=android)

> 🚀 Minimal, **riced**, and fully hackable Termux desktop environment. <br>
> ✨ Run it natively (X11) or inside proot-distro (Ubuntu/Arch). <br>
> 🎨 Themes, rofi menus, polybar candy, and blazing fast XFCE/Openbox setup.

---

## ⚡ Features

* 🧠 **Autodetect**: Termux native vs proot-distro ✔️
* 🖥️ **Desktop Choices**: XFCE 🪐 / Openbox 🌌
* 🎛️ **Pre-configured**: rofi, picom, polybar, pulseaudio
* 🎨 **Theme Switcher**: flip between rices instantly
* 💾 **Backup Helper**: save + restore your dotfiles
* 🔮 Export-ready: push your config straight to GitHub

---

## 🔥 Quickstart (Native Termux)

```bash
pkg update && pkg upgrade -y
pkg install git -y
git clone <https://github.com/taezeem14/termux-desktop>
cd termux-desktop
bash install.sh riced xfce
```

👉 Start desktop:

```bash
bash start-desktop.sh
```

(or from `~/.termux-desktop-start`)

---

## 🛰️ Quickstart (Proot-distro)

```bash
pkg install proot-distro -y
proot-distro install ubuntu
proot-distro login ubuntu
# inside:
apt update && apt install -y git wget
# then clone + run installer
```

---

## 📂 Files of Interest

* ⚙️ `install.sh` → installer script
* 🚀 `start-desktop.sh` → start X11/VNC session
* 🎨 `set-theme.sh` → theme switcher
* 💾 `backup.sh` → backup configs

---


### 🌟 Pro Tip

Don’t just install a desktop. **Flex with it.** Push your rices, show your workflow, and make your phone feel like a cyberpunk terminal. 🕶️

