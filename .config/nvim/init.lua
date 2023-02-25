-- Use the following instead of require() if you want things to reload with source $MYVIMRC
-- local function import(module)
--     package.loaded[module] = nil
--     return require(module)
-- end
require("plugins")
require("remap")
require("options")
require("autocmd")
require("lsp-setup")
require("completions")
