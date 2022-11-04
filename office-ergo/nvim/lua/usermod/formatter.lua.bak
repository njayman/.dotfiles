local formatter = require('formatter')
local util = require "formatter.util"

local function formarJS()
    return {
        exe = "prettierd",
        args = { util.escape_path(util.get_current_buffer_file_path()) },
        stdin = true
    }
end

formatter.setup {
    logginf = false,
    filetype = {
        javascript = {
            -- prettierd
            formarJS()
        },
        javascriptreact = {
            formarJS()
        },
        typescript = {
            formarJS()
        },
        typescriptreact = {
            formarJS()
        }
        -- other formatters ...
    }
}
