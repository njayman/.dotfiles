local status, nvtat = pcall(require, "nvim-ts-autotag")
if (not status) then return end

nvtat.setup {}
