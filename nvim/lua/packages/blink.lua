local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup{
  signature = { enabled = true },
  cmdline = { enabled = false },
  keymap = {
    preset = 'default',
    ["<C-s>"] = {"show_signature", "fallback"},
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  completion = {
    list = { selection = { preselect = false, auto_insert = false } },
    menu = { auto_show = true, },
    ghost_text = { enabled = true },
  },
}

