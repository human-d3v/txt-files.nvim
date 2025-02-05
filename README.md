# Text File Handling in Neovim 
This plugin won't be for everyone. It compiles a simple typescript binary that
accepts a word as an argument and returns a string representing a Lua Table. 

It adds the following keymaps by default:
| Mode | Keymap | Description |
| ---- |------ | ----------- |
| Visual | `leader + def` | displays the definition of the selected word |
| Visual | `leader + syn` | displays the synonyms of the selected word |
| Normal | `leader + br` | Added a line break on the line after the cursor|
| Visual | `leader + wc` | Displays the current word count in the visual selection|

To add this to lazy.nvim, add the following to your `lazy.nvim` file:
```lua
{ 
    "human-d3v/txt-files.nvim", 
    build = "cd api-caller && bun install && bun run compile", 
    opts = {}
}
```
