vim.cmd([[
  if has('termguicolors')
    set termguicolors
  endif
]])

local colorscheme = "everforest"


local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end


vim.cmd([[
  set background=dark
  "colorscheme everforest
]])
