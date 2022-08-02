First, install Karabiner elements

Then set up the simple modification:

`right_command` -> `escape`
`caps_lock` -> `left_control`
`semicolon` -> `return_or_enter`
`return_or_enter` -> `semicolon`

Then just move the config in place:
`mv ~/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.old.json`
`cp karabiner/karabiner.json ~/.config/karabiner/karabiner.json`

# Complex (NO LONGER WORKS)

Then at a terminal, do:

`open karabiner://karabiner/assets/complex_modifications/import?url=https://raw.githubusercontent.com/wuthefwasthat/dotfiles/master/karabiner/mouse_keys.json`

Or if cloned:

`open karabiner://karabiner/assets/complex_modifications/import?url=file:///Users/jeffwu/dotfiles/karabiner/mouse_mode.json`

This will install a number of useful modifications, of which you can enable any subset.
(replace `master` with a git hash if you want.  You can also just open the link directly in Chrome).

NOTE: See [here](https://pqrs.org/osx/karabiner/complex_modifications/) for some other example complex modifications.

## Mouse mode

Key bindings:

`command-m`: toggle mouse mode
`semicolon-m`: toggle mouse mode

`hjkl`: mouse move
`f + hjkl`: fast mouse move
`s + hjkl`: slow mouse move
`d + hjkl`: scroll
`r + hjkl`: arrows
`shift + hjkl`: scroll

`u` or `f`: left click
`i` or `v`: middle click
`o` or `F` or `g`: right click

## Better arrows

`; + hjkl`: arrow keys

## Better backspace

Ctrl+Space = Backspace

(assumes you have caps lock mapped to left_control)

## Better caps

Caps lock = left control, or esc if alone

## Better shift

Shift = parentheses if alone
