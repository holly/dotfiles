return {
    'CRAG666/code_runner.nvim',
    keys = {
        { '<leader>r', '<cmd>RunCode<cr>', desc = 'Run Code' },
    },
    config = function()
        local function find_root(markers)
            local path = vim.fn.expand('%:p:h')
            while path ~= '/' do
                for _, marker in ipairs(markers) do
                    if vim.fn.filereadable(path .. '/' .. marker) == 1 or
                        vim.fn.isdirectory(path .. '/' .. marker) == 1 then
                        return path
                    end
                end
                path = vim.fn.fnamemodify(path, ':h')
            end
            return nil
        end

        require('code_runner').setup({
            filetype = {
                typescript = "bun run",
                javascript = "bun run",
                python     = function()
                    if find_root({ 'uv.lock' }) then
                        return 'uv run'
                    elseif find_root({ 'poetry.lock' }) then
                        return 'poetry run python'
                    elseif find_root({ 'Pipfile' }) then
                        return 'pipenv run python'
                    else
                        return 'python -u'
                    end
                end,
                markdown   = "glow",
                perl       = "perl",
                sh         = "bash",
                bash       = "bash",
            },

            before_run_filetype = function()
                vim.cmd('write')
            end,
        })
    end,
}
