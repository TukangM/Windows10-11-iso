Multiplatform UUP converter requirements
========================================
The script requires the following applications:
 * cabextract - to extract cabs
 * wimlib-imagex - to export files from metadata ESD
 * chntpw - to modify registry of first index of boot.wim
 * genisoimage or mkisofs - to create ISO image

Linux
-----
If you use Debian or Ubuntu based distribution you can install these using
the following command:

```bash
sudo apt-get install cabextract wimtools chntpw genisoimage
```

If you use Arch Linux you can also install these using the following command:
```bash
sudo pacman -S cabextract wimlib chntpw cdrtools
```

If you use any other distribution, you'll need to check its repository for the
appropriate packages.

macOS
-----
macOS requires [Homebrew](https://brew.sh) to install the prerequisite software.
After Homebrew was installed, you can install the requirements using:

```bash
brew tap sidneys/homebrew
brew install cabextract wimlib cdrtools sidneys/homebrew/chntpw
```
