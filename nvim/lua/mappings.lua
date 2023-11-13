vim.cmd([[
  map :W :w
  map :X :x
  map :Q :q

  imap <C-BS> <C-W>

  nnoremap j gj
  nnoremap k gk
  vnoremap j gj
  vnoremap k gk
  nnoremap <Down> gj
  nnoremap <Up> gk
  vnoremap <Down> gj
  vnoremap <Up> gk
  inoremap <Down> <C-o>gj
  inoremap <Up> <C-o>gk
]]
)
