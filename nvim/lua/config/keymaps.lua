local def = {noremap=true, silent=true}
local map = vim.keymap.set

map("n", "<C-q>", "", def)
map("n", " ", "<Nop>", {silent=true,remap=false})
vim.g.mapleader = " "

local ts_bi = require('telescope.builtin')
map('n', '<leader>ff', ts_bi.find_files, {} )
map('n', '<leader>fg', ts_bi.live_grep, {} )
map('n', '<leader>fb', ts_bi.buffers, {} )

vim.diagnostic.config{
  float={
    scope='line',
    source='always',
    focusable=true,
    border='rounded',
  }
}
map('n', '<leader>k', vim.diagnostic.open_float )

map('n', '<C-s>', ':w<Cr>', def)

--map('t', '<Esc>', [[<C-\><C-n>]], {desc='Exit Terminal Mode'})
--map('t', '<C-h>', [[<C-\><C-n><C-w>h]], {desc='Move Left From Terminal'})
--map('t', '<C-j>', [[<C-\><C-n><C-w>j]], {desc='Move Down From Terminal'})
--map('t', '<C-k>', [[<C-\><C-n><C-w>k]], {desc='Move Up From Terminal'})
--map('t', '<C-l>', [[<C-\><C-n><C-w>l]], {desc='Move Right From Terminal'})

--map('n', 'T', ':botright split | terminal<Cr>', {desc='Opens a Terminal at the bottom'})
map('t', '<Esc>', '<C-\\><C-n>:FloatermHide!<Cr>', {desc='Hide FLoating Term'} )
map('n', 'T', ':FloatermNew<Cr>', {desc='Open New Floating Terminal'})
map('n', '<leader>t', ':FloatermShow!<Cr>', {desc='Toggle Existing Terminal'})

map('n', '<A-,>', ':BufferPrevious<Cr>')
map('n', '<A-.>', ':BufferNext<Cr>')
map('n', '<A-c>', ':BufferClose<Cr>')
for i = 1,9,1 do
  map('n', '<A-'..i..'>', ':BufferGoto '..i..'<Cr>')
end
