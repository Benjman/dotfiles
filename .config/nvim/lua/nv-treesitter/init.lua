require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'bash',
        'c',
        'cpp',
        'css',
        'html',
        'java',
        'javascript',
        'json',
        'lua',
        'python',
    },
    highlight = {
        enable = true,
        use_languagetree = true,
    }
}

