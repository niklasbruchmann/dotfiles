---@module 'lazy'
---@type LazySpec
return {
    'eboody/maud-fmt.nvim',
    config = function() require('maud-fmt').setup() end,
    ft = 'rust', -- Only load for Rust files
    opts = {
        indent_size = 4, -- Default indentation size (spaces)
        keymaps = {
            format = '<leader>mf', -- Keymap to format the current buffer
        },
    },
}
