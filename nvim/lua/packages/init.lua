local gh = function( pack ) return 'https://github.com/' .. pack end

vim.pack.add({
  gh( 'shaunsingh/nord.nvim' ),
  gh( 'rose-pine/neovim' ),
  { src = gh('nvim-treesitter/nvim-treesitter'), version = 'main' },
  gh( 'neovim/nvim-lspconfig' ),
  gh( 'nvim-tree/nvim-web-devicons' ),
  gh( 'nvim-lualine/lualine.nvim' ),
  gh( 'windwp/nvim-autopairs' ),
  gh( 'MunifTanjim/nui.nvim' ),
  gh( 'm4xshen/hardtime.nvim' ),
  gh( 'nvim-lua/plenary.nvim' ),
  { src=gh( 'nvim-telescope/telescope-fzf-native.nvim' ), build = 'make' },
  gh( 'nvim-telescope/telescope.nvim' ),
  gh( 'saghen/blink.lib' ),
  gh( 'saghen/blink.cmp' ),
  gh( 'voldikss/vim-floaterm' ),
  gh( 'romgrk/barbar.nvim' ),
})

require('nvim-treesitter').setup()
require('rose-pine').setup()
require('lualine').setup{options={theme='material'}}
--require('hardtime').setup()
require('nvim-web-devicons').setup()
require('nvim-autopairs').setup()
require('telescope').setup()
require('telescope').load_extension('fzf')
local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup()

