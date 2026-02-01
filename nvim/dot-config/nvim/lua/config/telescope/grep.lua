local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local conf = require("telescope.config").values
local M = {}

-- Example, if the path is /home/eguefif/lab/my_project/src/db/parser/
-- it will return src/db/parser
local get_relative_path = function(path)
    local project_path_splits = vim.split(vim.fn.getcwd(), "/")
    local path_splits = vim.split(path, "/")
    local new_path = ""
    if #path_splits <= #project_path_splits then return "" end
    for n = #project_path_splits, #path_splits, 1 do
        new_path = new_path .. "/" .. path_splits[n]
    end
    return new_path
end

local live_grep_type = function(opts)
    local prompt_title = "Multi grep"
    if opts and opts.cwd then
        local relative_path = get_relative_path(opts.cwd)
        if #relative_path > 0 then
            prompt_title = "Multi Grep (" .. relative_path .. ")"
        end
    end
    opts = opts or {}
    opts.cwd = opts.cwd or vim.fn.getcwd()
    local finder = finders.new_async_job({
        command_generator = function(prompt)
            if not prompt or prompt == "" then return nil end

            local pieces = vim.split(prompt, "  ")
            local args = {"rg"}
            if pieces[1] then
                table.insert(args, "-e")
                table.insert(args, pieces[1])
            end
            if pieces[2] then
                table.insert(args, "-g")
                table.insert(args, pieces[2])
            end
            return vim.iter({
                args, {
                    "--color=never", "--no-heading", "--with-filename",
                    "--line-number", "--column", "--smart-case"
                }
            }):flatten():totable()
        end,
        entry_maker = make_entry.gen_from_vimgrep(),
        cwd = opts.cwd
    })

    pickers.new(opts, {
        debounce = 100,
        prompt_title = prompt_title,
        finder = finder,
        previewer = conf.grep_previewer({}),
        sorter = require("telescope.sorters").empty()
    }):find()
end

M.setup = function(opts) live_grep_type(opts) end

return M
