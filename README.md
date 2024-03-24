# telescope-foldmarkers.nvim

This [telescope.nvim][1] extension provides a search function for Vim
[fold-markers][2]. If you have long files with fold-markers, this
extension can help you to jump around in the file, regardless if you're
currently using `foldmethod=marker` or not.

## Prerequisites

- [telescope.nvim][1]
- NeoVim (tested with version 0.9.0)


## Installation

Install the plugin using your favorite package manager. For example, using
[lazy][3], you can declare it a dependency of telescope in your `init.lua`:

```lua
use {
  'gbirke/telescope-foldmarkers.nvim',
  requires = { 'nvim-telescope/telescope.nvim' },
}
```

Then, in your Telescope setup, add the extension:

```lua
require('telescope').load_extension('foldmarkers')
```

## Usage

You can use the extension by calling `:Telescope foldmarkers` or by creating a
mapping in your `init.lua`:

```lua
vim.api.nvim_set_keymap('n', '<leader>fm', '<cmd>Telescope foldmarkers<cr>', { noremap = true })
```

Your file has to contain fold-markers for this extension to work. You can use the following fold-marker syntax:

```vim
" Vim example
" Keybindings {{{1
" General keybindings {{{2
nnoremap <leader>q :q<CR>
```

```css

/* CSS example */
/* General tags {{{1 */
/* Header tags {{{2 */
h1 { font-size: 2em; }

/* Link tags {{{2 */

a { color: blue; }
```

The extension searches for the opening marker `{{{` and the optional
level number. It will not find the closing marker `}}}`. 

The number after the curly braces is the fold level. The extension will
use this number to determine the fold level of the marker and the
indentation inside the picker. If you don't provide a number, the
extension will use the default fold level of 1.


## Future improvements

The extension does what I want, but there are some ideas I did not
implement yet. Patches are welcome!

- Preview the context of the fold-marker in the preview window
- Add bindings to open and close folds (if `foldmethod=marker` is set)
- Make display customizable (e.g. show the fold marker and following
    comment characters)


[1]: https://github.com/nvim-telescope/telescope.nvim
[2]: https://vimdoc.sourceforge.net/htmldoc/fold.html#fold-marker
[3]: https://github.com/folke/lazy.nvim
