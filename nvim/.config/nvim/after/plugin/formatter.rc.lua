local formatter = require("formatter")
local util = require('formatter.util')

local function format_prettier()
    return {
        exe = "prettier",
        args = { util.escape_path(util.get_current_buffer_file_path()) },
        stdin = true
    }
end

local filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json" }

local filetype = {}

for _, value in pairs(filetypes) do
    filetype[value] = format_prettier()
end

formatter.setup {
    filetype = filetype
}
