# 🌌 Termux Desktop (Inspired From ![Adi1090x](https://github.com/adi1090x) / Aditya Shakya)

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

## 🔥 Step-by-Step Quickstart (Native Termux)

1. Open Termux app on your Android device.
2. Update packages:

```bash
pkg update && pkg upgrade -y
```

3. Install git:

```bash
pkg install git -y
```

4. Clone this repo:

```bash
git clone https://github.com/taezeem14/termux-desktop
```

5. Enter repo directory:

```bash
cd termux-desktop
```

6. Run installer:

```bash
bash install.sh riced xfce
```

7. Start desktop environment:

```bash
bash start-desktop.sh
```

8. (Optional) Add start shortcut:

```bash
cp ~/.termux-desktop-start ~/start-desktop.sh
chmod +x ~/start-desktop.sh
```

---

## 🛰️ Step-by-Step Quickstart (Proot-distro)

1. Install proot-distro:

```bash
pkg install proot-distro -y
```

2. Install a distro (Ubuntu/Arch):

```bash
proot-distro install ubuntu
```

3. Login to the distro:

```bash
proot-distro login ubuntu
```

4. Update packages inside distro:

```bash
apt update && apt upgrade -y
```

5. Install git & wget:

```bash
apt install -y git wget
```

6. Clone this repo:

```bash
git clone https://github.com/taezeem14/termux-desktop
```

7. Enter repo directory:

```bash
cd termux-desktop
```

8. Run installer:

```bash
bash install.sh riced xfce
```

9. Start desktop environment:

```bash
bash start-desktop.sh
```

---

## ⚠️ Important Notes for Beginners

* Ensure you have a working Termux or proot-distro environment.
* Make sure dotfiles folder and start-desktop.sh exist in the repo.
* If icons and themes are missing, install ttf fonts:

```bash
pkg install ttf-dejavu -y
```

* PulseAudio is automatically started by the installer, but you can manually start it:

```bash
pulseaudio --start
```

* To switch themes after installation:

```bash
bash set-theme.sh <theme-name>
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

### ⭐ Extra Tips

* Star the repo if you like it.
* Share screenshots of your riced setup.
* Experiment with profiles: `minimal`, `full`, or `riced`.
* If installer fails, check `termux-x11` repo is installed:

```bash
pkg install x11-repo -y
```

