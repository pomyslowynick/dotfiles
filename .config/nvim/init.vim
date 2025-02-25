" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'elihunter173/dirbuf.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'google/vim-maktaba'
Plug 'bazelbuild/vim-bazel'
Plug 'google/vim-jsonnet'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'hashivim/vim-terraform'
Plug 'github/copilot.vim'
Plug 'epwalsh/obsidian.nvim'
Plug 'nvim-lua/plenary.nvim'
" Plug 'folke/noice.nvim' 
"   Plug 'MunifTanjim/nui.nvim'
"   Plug 'rcarriga/nvim-notify'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
" List ends here. Plugins become visible to Vim after this call.
call plug#end()


lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "markdown", "markdown_inline", "javascript", "typescript", "tsx", "css", "yaml" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
   textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ai"] = "@assignment.inner",
        ["ao"] = "@assignment.outer",
        ["al"] = "@assignment.lhs",
        ["ar"] = "@assignment.rhs",
      },
      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * selection_mode: eg 'v'
      -- and should return true or false
      include_surrounding_whitespace = true,
    },
  },
}
EOF

lua << EOF
require("nvim-autopairs").setup {}
EOF

set termguicolors

nnoremap <SPACE> <Nop>
let mapleader = "\<Space>"

inoremap <C-v> <Esc>:ObsidianPasteImg <C-R>=strftime("%Y%m%d%H%M%S")<Cr><Cr>y<Cr>
nnoremap <C-p> :GFiles<Cr>
nnoremap <C-j> :GFiles?<Cr>
nnoremap <C-l> :RG<Cr>
nnoremap <C-f> :Files<Cr>
nnoremap <C-k> :Dirbuf<Cr>
nnoremap <C-h> :History<Cr>
nnoremap <C-b> :History<Cr>
nnoremap <Esc> :nohl<Cr>
nnoremap <C-w>t <C-w>n<C-w>L:term<Cr>
vnoremap <C-I> <Esc>:v/\%V/d<Cr>zz
tnoremap <Tab> <Tab>
set rtp+=/opt/homebrew/opt/fzf
tnoremap <Esc> <C-\><C-n>


" leader mappings
nnoremap <leader>c :cd %:h<CR>
nnoremap <leader>pwd :pwd<CR>
nnoremap <leader>loff :set nolist<CR>
nnoremap <leader>lon :set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»<CR> :set list<CR>

" fzf mappings
nnoremap <leader>fb :BCommits<CR>
vnoremap <leader>fb :BCommits<CR>
nnoremap <leader>fc :Commands<CR>
nnoremap <leader>fg :Commits<CR>
nnoremap <leader>fh :Changes<CR>
nnoremap <leader>fj :Jumps<CR>
nnoremap <leader>fl :Lines<CR>
nnoremap <leader>fm :Maps<CR>
nnoremap <leader>fr :Marks<CR>
nnoremap <leader>/ :History/<CR>
nnoremap <leader>: :History:<CR>


" git mappings
nnoremap <leader>gl :Git pull<CR>
nnoremap <leader>gm :Git switch main<CR>
nnoremap <leader>gsww :Git switch 
nnoremap <leader>gswc :Git switch --create GKESRE-
nnoremap <leader>gra :Git restore ./<CR>
nnoremap <leader>grst :Git reset ./<CR>
nnoremap <leader>grf :Git restore %<CR>
nnoremap <leader>grm :Git restore --source main %<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>g- :Git switch -<CR>
nnoremap <leader>gst :Git status<CR>
nnoremap <leader>gg :Git log<CR>
nnoremap <leader>gsa :Git stash push<CR>
nnoremap <leader>gsp :Git stash pop<CR>
nnoremap <leader>gca :Git clean -f -d<CR>
nnoremap <leader>grh :Git reset --hard origin/main<CR>
nnoremap <leader>gaa :Git add .<CR>
nnoremap <leader>gcm :Git commit<CR>
nnoremap <leader>gilog :LineHistoryCmd<CR>
vnoremap <leader>l :<c-u>exe '!git log -L' line("'<").','.line("'>").':'.expand('%')<CR>

function LineHistory()
    let l:line_num = line('.')
    let l:original_file = expand('%')
    execute 'Git log -L ' . l:line_num . ',' . l:line_num . ':' . l:original_file
endfunction
command! LineHistoryCmd call LineHistory()

nnoremap <leader>gdr :WinMessage !git diff --no-ext-diff --unified=0 --exit-code -a --no-prefix<CR>

" gh mappings
nnoremap <leader>ghpw :!gh browse %<CR> 
nnoremap <leader>ghpc :!gh pr checkout 

" action mappings
nnoremap <leader>ai :e ~/.config/nvim/init.vim<CR>
nnoremap <leader>as :source ~/.config/nvim/init.vim<CR>
nnoremap <leader>af :!make -s render/% > out.yaml <CR><C-w>n:e out.yaml<CR> 
nnoremap <leader>aj :!jsonnet % > /tmp/out.yaml <CR><C-w>n:e /tmp/out.yaml<CR>
nnoremap <leader>afo :!open -a Finder %:h<CR>
nnoremap <leader>adt :windo diffthis<CR>
nnoremap <leader>ado :windo diffoff<CR>
nnoremap <leader>atr <C-w>li<C-l><Up><CR><C-\><C-n><C-w>h
nnoremap <leader>atb <C-w>li<C-c><C-l><Up><CR><C-\><C-n><C-w>h

function! GhOpenLineNum()

    let l:line_num = line('.')
    let l:original_file = expand('%')
    silent execute '!gh browse ' . l:original_file . ':' . l:line_num
endfunction
command! GhOpenLineNum call GhOpenLineNum()
nnoremap <leader>ghpl :GhOpenLineNum<CR>


function! BazelBuildLocal(...)
    let l:file = expand('%:h')
    execute 'Bazel build //' . l:file . '/...'
endfunction
command! -nargs=+ -complete=command BazelBuildLocal call BazelBuildLocal()
nnoremap <leader>acb :BazelBuildLocal('nothing')<CR> 

function LoadCommand()
    call inputsave()
    let g:loaded_command = input('Enter command to load: ')
    call inputrestore()
endfunction
command! LoadCommand call LoadCommand()
nnoremap <leader>jl :LoadCommand<CR> 

function ExecuteCommand()
    winc l
    call nvim_feedkeys(nvim_replace_termcodes('i<C-l>' . g:loaded_command . '<cr>',v:true,v:false,v:true),'m',v:true)
endfunction
command! ExecuteCommand call ExecuteCommand()
nnoremap <leader>je :ExecuteCommand<CR>

function ShowCommand()
    echo g:loaded_command
endfunction
command! ShowCommand call ShowCommand()
nnoremap <leader>js :ShowCommand<CR>

function RunUnderCursor()
    normal "ay
    let l:command = getreg('a', 1, 1)
    winc l
    call nvim_feedkeys(nvim_replace_termcodes('i<C-l>' . l:command . '<cr>',v:true,v:false,v:true),'m',v:true)
endfunction
command! RunUnderCursor call RunUnderCursor()
nnoremap <leader>jc :RunUnderCursor<CR>

if !isdirectory("/Users/rrosa/.config/.vim-undo-dir")
    call mkdir("/Users/rrosa/.config/.vim-undo-dir", "", 0700)
endif
set undodir=/Users/rrosa/.config/.vim-undo-dir
set undofile
set expandtab
set smartcase
set ignorecase
set mouse=
set conceallevel=1

let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:go_metalinter_command = 'golangci-lint'
let g:matchparen_timeout = 20
let g:matchparen_insert_timeout = 20

" omnifunc options
filetype plugin on
set omnifunc=syntaxcomplete#Complete

" set up folding with treesitter
" lua << EOF
  " vim.opt.foldmethod = "expr"
  " vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
" EOF

" set nofoldenable
" because otherwise everything starts as folded
set foldlevelstart=99

" to keep first 20 lines of the page visible when running zt
set scrolloff=5

" let's see if I miss swap files
set noswapfile

" to fold markdown files https://github.com/nvim-treesitter/nvim-treesitter/issues/2145
let g:markdown_folding = 1
