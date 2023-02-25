local M = {}

function M.require_mod(mod, file)
    local status, loaded = pcall(require, mod)
    if not status then
        local msg = "Couldn't require " .. mod .. " in " .. file
        vim.notify(msg, vim.log.levels.ERROR)
    end
    return status, loaded
end

return M
