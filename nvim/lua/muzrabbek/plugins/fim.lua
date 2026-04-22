return {
    "ggml-org/llama.vim",

    init = function()
        vim.keymap.set("i", "ff", "<C-o>:call llama#fim_accept('full')<CR>", { silent = true })
    end,
}
