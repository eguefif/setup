-- Add an alias for the module name under the cursor
local ts = require('config.elixir.treesitter')

local M = {}

-- Find the full names of the project modules whose name ends with `name`,
-- e.g. "Client" -> {"MyApp.Client", "OtherApp.Client"}.
local function find_modules(name)
    local root = vim.fs.root(0, 'mix.exs') or vim.fn.getcwd()
    -- `defmodule MyApp.Client do` -> capture "MyApp.Client"
    local pattern = '^\\s*defmodule\\s+((?:[\\w.]+\\.)?' ..
                        name:gsub('%.', '\\.') .. ')\\s+do'
    local result = vim.system({
        'rg', '--no-filename', '--only-matching', '--replace', '$1', '--glob',
        '*.{ex,exs}', pattern, root
    }, {text = true}):wait()

    local modules, seen = {}, {}
    for line in result.stdout:gmatch('[^\n]+') do
        if not seen[line] then
            seen[line] = true
            table.insert(modules, line)
        end
    end
    return modules
end

-- Find the module name the cursor refers to. `Client.my_func()` parses as
-- (call target: (dot left: (alias) right: (identifier)) (arguments)),
-- so from `my_func` or `()` we climb to the `dot` and take its left side.
local function module_under_cursor()
    vim.treesitter.get_parser(0):parse()
    local node = vim.treesitter.get_node()
    if not node then return end

    -- on `my_func`: go up to the dot
    if node:type() == 'identifier' and node:parent():type() == 'dot' then
        node = node:parent()
    end
    -- on `()`: go up to the call, then to its target (the dot)
    if node:type() == 'arguments' then node = node:parent() end
    if node:type() == 'call' then node = node:field('target')[1] end
    -- on the dot: take the module on its left
    if node and node:type() == 'dot' then node = node:field('left')[1] end

    if node and node:type() == 'alias' then
        return vim.treesitter.get_node_text(node, 0)
    end
end

-- Check whether the module already has `alias <module>` at its top level.
-- Each alias line is a (call target: (identifier) (arguments (alias) ...))
-- that is a direct child of the module's do_block.
local function has_alias(buf, mod_node, module)
    for child in mod_node:iter_children() do
        if child:type() == 'do_block' then
            for stmt in child:iter_children() do
                local target = stmt:type() == 'call' and
                                   stmt:field('target')[1]
                if target and vim.treesitter.get_node_text(target, buf) ==
                    'alias' then
                    local args = stmt:named_child(1)
                    local first = args and args:type() == 'arguments' and
                                      args:named_child(0)
                    if first and vim.treesitter.get_node_text(first, buf) ==
                        module then return true end
                end
            end
        end
    end
    return false
end

-- Insert `alias <module>` on the line after the module's `defmodule ... do`,
-- unless it is already there.
local function insert_alias(buf, mod_node, module)
    if has_alias(buf, mod_node, module) then
        vim.notify('Alias ' .. module .. ' already exists')
        return
    end

    local start_row = mod_node:range()
    local mod_line = vim.api.nvim_buf_get_lines(buf, start_row, start_row + 1,
                                                false)[1]
    local indent = mod_line:match('^%s*') ..
                       string.rep(' ', vim.fn.shiftwidth())
    vim.api.nvim_buf_set_lines(buf, start_row + 1, start_row + 1, false,
                               {indent .. 'alias ' .. module})
end

-- Add `alias MyApp.Client` for the module name under the cursor.
-- When several modules match, let the user pick one.
function M.add_alias()
    local name = module_under_cursor()
    if not name then
        vim.notify('Cursor is not on a module name', vim.log.levels.WARN)
        return
    end

    local mod_node = ts.enclosing_call({defmodule = true})
    if not mod_node then
        vim.notify('Cursor is not inside a module', vim.log.levels.WARN)
        return
    end

    local modules = find_modules(name)
    if #modules == 0 then
        vim.notify('No module found for ' .. name, vim.log.levels.WARN)
        return
    end

    -- Remember the buffer now: the picker opens its own window
    local buf = vim.api.nvim_get_current_buf()
    if #modules == 1 then
        insert_alias(buf, mod_node, modules[1])
        return
    end

    vim.ui.select(modules, {prompt = 'Alias ' .. name}, function(choice)
        if choice then insert_alias(buf, mod_node, choice) end
    end)
end

return M
