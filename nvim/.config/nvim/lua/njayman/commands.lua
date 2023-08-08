-- Define the custom :Love command
vim.cmd([[command! -nargs=0 Love :lua love_command()]])

-- Function to execute the "love ." command in the current project directory
function love_command()
    local project_dir = vim.fn.getcwd()
    vim.fn.system("love " .. project_dir)
end
