return {
    setup = function()
        require("indentmini").setup({
            char = "︲",
            exclude = {
                "markdown",
            }
        })
        -- use comment color
        -- vim.cmd.highlight("default link IndentLine Comment")
    end
}
