-- Treesitter helpers shared by the Elixir features
local M = {}

-- Walk up the syntax tree from the cursor until we find an enclosing call
-- whose target is one of `targets` (e.g. {def = true, defp = true}).
-- In the Elixir grammar, `def foo do ... end` is a `call` node whose `target`
-- is the identifier `def`; `defmodule` works the same way.
function M.enclosing_call(targets)
    vim.treesitter.get_parser(0):parse()
    local node = vim.treesitter.get_node()
    while node do
        if node:type() == 'call' then
            local target = node:field('target')[1]
            if target and targets[vim.treesitter.get_node_text(target, 0)] then
                return node
            end
        end
        node = node:parent()
    end
end

return M
