# Emacs Configuration

| Splash Screen | Code | Org-mode | Dark theme (editing markdown) |
| ------------- | ---- | -------- | ----------------------------- |
| ![](previews/splash.png) | ![](previews/rust.png) | ![](previews/orgmode.png) | ![](previews/darkmdown.png) |

My fairly minimal, vanilla configuration for emacs. It was written mostly from scratch, though some fairly significant portions are taken/inspired by [elegant-emacs](https://github.com/rougier/elegant-emacs). 

## Dependencies

There are no hard dependencies. Everything should work<sup>TM</sup> as long as you don't have an ancient version of emacs. However, the config was written for usage with the following fonts in mind:

- Fixed pitch font: SF Mono
- Variable pitch font: ETBembo (Cormodant Garamond is also supported)
- Italic font (for cursive italics): Victor Mono

If you don't have some of these installed, the config will fallback to your default system values. Some scaling issues may occur if you decide to use other fonts.

## Usage

1. Copy the files to `~/.emacs.d` or `~/.config/emacs`
2. Clear the `lisp/custom-ops.el` file, but don't delete it.
   - This file contains all custom configuration options set with `M-x customize` and also configuration for various plugins and things that are *not* in vanilla emacs.
   - Unless you use the exact same plugins I do, you probably want to clear my settings. Otherwise emacs will complain about missing plugins

### Optional Steps

If you want to install packages:
- Three package sources are initialized by default: Melpa, GNU Elpa, and Marmalade
- To get packages, use the builtin package.el: `M-x package-refresh-contents`, then the usual commands such as `M-x package-install` to install.
- To prevent unwanted network requests, the config *does not* run `package-refresh-contents` automatically. You will need to run it manually when you want to refresh the package list.

Default theme is light theme. If you want dark theme:
- Dark theme function is called `sayo`, and light theme function is called `blossom`. These are set near the bottom of the `init.el` file. Change it to set the default theme.
- To toggle theme on the fly, use `M-x theme-toggle`

If you want custom splash images:
- An image is randomly chosen from the `data/splash-img` directory on emacs startup. Change the images in this directory to display them on the splash screen
- The names of the files do not matter, and you can use any image file type supported by your build of emacs.

If you want to customize some options:
- Use `M-x customize` for interactive customization. Your custom options will be stored in `lisp/custom-ops.el`.
- Or just edit any of the files directly. You don't need black magic or anything :)