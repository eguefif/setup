-- Create a new function from the symbol under the cursor
local ts = require('config.elixir.treesitter')

local M = {}

-- Find the function name the cursor refers to. `hello()` parses as
-- (call target: (identifier) (arguments)), so from `()` we climb to the call
-- and take its target.
local function name_under_cursor()
    vim.treesitter.get_parser(0):parse()
    local node = vim.treesitter.get_node()
    if not node then return end

    -- on `()`: go up to the call, then to its target (the function name)
    if node:type() == 'arguments' then
        node = node:parent():field('target')[1]
    end

    if node and node:type() == 'identifier' then
        return vim.treesitter.get_node_text(node, 0)
    end
end

-- Create a function named after the symbol under the cursor.
-- The function is inserted right after the function the cursor is in.
-- Public functions get a @doc placeholder, private ones only the spec comment.
function M.create_function(private)
    local name = name_under_cursor()
    if not name then
        vim.notify('Cursor is not on a function name', vim.log.levels.WARN)
        return
    end

    local fn_node = ts.enclosing_call({def = true, defp = true})
    if not fn_node then
        vim.notify('Cursor is not inside a function', vim.log.levels.WARN)
        return
    end

    -- Rows are 0-based; end_row is the line holding the function's `end`
    local start_row, _, end_row, _ = fn_node:range()
    local def_line = vim.api.nvim_buf_get_lines(0, start_row, start_row + 1,
                                                false)[1]
    local indent = def_line:match('^%s*')

    local new_lines
    if private then
        new_lines = {
            '', indent .. '#@spec ' .. name .. '() ::',
            indent .. 'defp ' .. name .. '() do', indent .. 'end'
        }
    else
        new_lines = {
            '', indent .. '@doc """', '', indent .. '"""',
            indent .. '#spec ' .. name .. '() ::',
            indent .. 'def ' .. name .. '() do', indent .. 'end'
        }
    end
    vim.api.nvim_buf_set_lines(0, end_row + 1, end_row + 1, false, new_lines)
end

return M
