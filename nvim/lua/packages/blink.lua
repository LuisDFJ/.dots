local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup{
  signature = { enabled = true },
  keymap = { 
    preset = 'default',
    ["<C-n>"] = {"select_next", "fallback"},
    ["<C-p>"] = {"select_prev", "fallback"},
    ["<C-y>"] = {"select_and_accept", "fallback"},
    ["<C-Space>"] = {"show", "fallback"},
    ["<C-s>"] = {"show_signature", "fallback"},
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  }
}
