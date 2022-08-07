local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path})
    vim.cmd [[packadd packer.nvim]]
end


local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end


packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}


packer.startup(function(use)
    -- Basics
    use 'wbthomason/packer.nvim'                  -- Have packer manage itself
    use 'lewis6991/impatient.nvim'                -- Jit and speedup and whatnot
    use 'nvim-lua/plenary.nvim'                   -- Useful lua functions used by lots of plugins

    -- Small stuff / helpers and whatnot
     use 'windwp/nvim-autopairs'                  -- Automatically close parenthesis and stuff
    use 'numToStr/Comment.nvim'                   -- Comment / Uncomment
    use 'kyazdani42/nvim-web-devicons'            -- Make things look nice
    use 'tpope/vim-fugitive'                      -- Git integration
    use 'tpope/vim-repeat'                        -- Make . work for various plugins
    use 'tpope/vim-surround'                      -- Add, change, delete surrounding parenthesis, etc
    use 'godlygeek/tabular'                       -- Tabularize text on pattern
    use 'moll/vim-bbye'                           -- Dump buffers
    use 'nvim-lualine/lualine.nvim'               -- Eyecandy
    use 'danymat/neogen'                          -- Docstrings
    use 'lukas-reineke/indent-blankline.nvim'     -- Viual indicator for indents and such

    -- Color
    use "EdenEast/nightfox.nvim"

    -- Completion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'saadparwaiz1/cmp_luasnip'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-omni'

    -- Snippets
    use 'L3MON4D3/LuaSnip'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'RRethy/vim-illuminate'
    use 'SmiteshP/nvim-navic'
    use 'jose-elias-alvarez/null-ls.nvim'

    -- Telescope
    use 'nvim-telescope/telescope.nvim'

    -- Treesitter
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/nvim-treesitter-textobjects'
    use 'p00f/nvim-ts-rainbow'
    use 'nvim-treesitter/playground'

    -- Vimtex
    use 'lervag/vimtex'

    -- Rust or bust
    use 'simrat39/rust-tools.nvim'

    -- Special stuff
    use 'baskerville/vim-sxhkdrc'


    if packer_bootstrap then
        require('packer').sync()
    end
end)
