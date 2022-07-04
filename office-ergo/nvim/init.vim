set confirm
set encoding=utf-8
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set exrc
set number relativenumber
set noerrorbells
set nu rnu
set smartcase
set noswapfile
set incsearch
set termguicolors
set scrolloff=6
set signcolumn=yes
set hidden
set nobackup
set nowritebackup
set clipboard=unnamedplus
set cmdheight=2
set termguicolors
set cursorline
set completeopt=noinsert,menuone,noselect
set splitbelow splitright
set title
set wildmenu
set t_Co=256
set mouse=a
set background=dark
syntax on

call plug#begin('~/.config/nvim/plugged')
Plug 'ThePrimeagen/vim-be-good'
Plug 'wakatime/vim-wakatime'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips'
Plug 'mlaursen/vim-react-snippets'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'tpope/vim-commentary'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'suy/vim-context-commentstring'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'PhilRunninger/nerdtree-visual-selection'
Plug 'puremourning/vimspector'
Plug 'mustache/vim-mustache-handlebars'
" Plug 'PhilRunninger/nerdtree-buffer-ops'

Plug 'github/copilot.vim'

Plug 'voldikss/vim-floaterm'

Plug 'folke/which-key.nvim'

" Dap
Plug 'mfussenegger/nvim-dap'
Plug 'Pocco81/DAPInstall.nvim'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'nvim-telescope/telescope-dap.nvim'

" Icon plugin
Plug 'ryanoasis/vim-devicons'
call plug#end()

" which key

lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF

set pyxversion=3

" For Neovim 0.1.3 and 0.1.4 - https://github.com/neovim/neovim/pull/2198
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

" For Neovim > 0.1.5 and Vim > patch 7.4.1799 - https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162
" Based on Vim patch 7.4.1770 (`guicolors` option) - https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd
" https://github.com/neovim/neovim/wiki/Following-HEAD#20160511

let g:tokyonight_style = "night"
colorscheme tokyonight


let g:python3_host_prog = expand('/usr/bin/python3')
let g:coc_node_path = substitute(system('which node'), '\n', '', '')

let mapleader = " "

nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>gf <cmd>Telescope git_files<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap <leader>rn :!node %:p<cr>
nnoremap <leader>rtn :!ts-node-transpile-only %<cr>

tnoremap <Esc> <C-\><C-n>

" nerd tree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\\.swo$', '\\.swp$', '\\.git']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=0
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1

if has_key(g:plugs, 'nerdtree-git-plugin')
let g:NERDTreeGitStatusIndicatorMapCustom = {
  \ 'Modified'  : '✹',
  \ 'Staged'    : '✚',
  \ 'Untracked' : '✭',
  \ 'Renamed'   : '➜',
  \ 'Unmerged'  : '═',
  \ 'Deleted'   : '✖',
  \ 'Dirty'     : '✗',
  \ 'Clean'     : '✔︎',
  \ 'Ignored'   : '⛌',
  \ 'Unknown'   : '?'
\ }
let g:NERDTreeGitStatusShowIgnored=1
endif
 
" vimspector
" nnoremap <Leader>dd :call vimspector#Launch()<CR>
" nnoremap <Leader>de :call vimspector#Reset()<CR>
" nnoremap <Leader>dc :call vimspector#Continue()<CR>

" nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
" nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>

" nmap <Leader>dk <Plug>VimspectorRestart
" nmap <Leader>dh <Plug>VimspectorStepOut
" nmap <Leader>dl <Plug>VimspectorStepInto
" nmap <Leader>dj <Plug>VimspectorStepOver

" vim floaterm

let g:floaterm_keymap = '<leader>f'
let g:floaterm_keymap_toggle = '<leader>t'

function! Flt_term_win(cmd, width, height, border_highlight) abort
    let width = float2nr(&columns * a:width)
    let height = float2nr(&lines * a:height)
    let bufnr = term_start(a:cmd, {'hidden': 1, 'term_finish': 'close', 'cwd': getcwd()})

    let winid = popup_create(bufnr, {
            \ 'minwidth': width,
            \ 'maxwidth': width,
            \ 'minheight': height,
            \ 'maxheight': height,
            \ 'border': [],
            \ 'borderchars': ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
            \ 'borderhighlight': [a:border_highlight],
            \ 'padding': [0,1,0,1],
            \ 'highlight': a:border_highlight
            \ })

    " Optionally set the 'Normal' color for the terminal buffer
    " call setwinvar(winid, '&wincolor', 'Special')

    return winid
endfunction

" floaterm lazygit
nnoremap <silent> <Leader>gz :<C-u>FloatermNew height=0.7 width=0.8 lazygit<CR>

" mfussenegger/nvim-dap
lua << EOF
local dap = require('dap')
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/apps/vscode-node-debug2/out/src/nodeDebug.js'},
}
vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})
EOF
nnoremap <leader>dh :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <S-k> :lua require'dap'.step_out()<CR>
nnoremap <S-l> :lua require'dap'.step_into()<CR>
nnoremap <S-j> :lua require'dap'.step_over()<CR>
nnoremap <leader>ds :lua require'dap'.stop()<CR>
nnoremap <leader>dn :lua require'dap'.continue()<CR>
nnoremap <leader>dk :lua require'dap'.up()<CR>
nnoremap <leader>dj :lua require'dap'.down()<CR>
nnoremap <leader>d_ :lua require'dap'.disconnect();require'dap'.stop();require'dap'.run_last()<CR>
nnoremap <leader>dr :lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>l
nnoremap <leader>di :lua require'dap.ui.variables'.hover()<CR>
vnoremap <leader>di :lua require'dap.ui.variables'.visual_hover()<CR>
nnoremap <leader>d? :lua require'dap.ui.variables'.scopes()<CR>
nnoremap <leader>de :lua require'dap'.set_exception_breakpoints({"all"})<CR>
nnoremap <leader>da :lua require'debugHelper'.attach()<CR>
nnoremap <leader>dA :lua require'debugHelper'.attachToRemote()<CR>
nnoremap <leader>di :lua require'dap.ui.widgets'.hover()<CR>
nnoremap <leader>d? :lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>

" Plug 'nvim-telescope/telescope-dap.nvim'
lua << EOF
require('telescope').setup()
require('telescope').load_extension('dap')
EOF
nnoremap <leader>df :Telescope dap frames<CR>
nnoremap <leader>dc :Telescope dap commands<CR>
nnoremap <leader>db :Telescope dap list_breakpoints<CR>

" theHamsta/nvim-dap-virtual-text and mfussenegger/nvim-dap
let g:dap_virtual_text = v:true
