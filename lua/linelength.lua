local M = {}

-- Function to find long lines in the current buffer and add them to diagnostics
M.add_line_length_diagnostics = function()
  local diagnostics = {}
  local currentBuf = vim.api.nvim_get_current_buf()

  -- Iterate over each line in the buffer
  for lnum = 1, vim.fn.line('$') do
    local line = vim.fn.getline(lnum)

    -- Match on lines that are too long
    if string.len(line) > 80 then
      table.insert(diagnostics,
      {
        bufnr = currentBuf,
        lnum = lnum - 1,
        end_lnum = lnum - 1,
        col = 80,
        end_col = 80,
        severity = vim.diagnostic.severity.INFO,
        message = "Line too long",
        source = 'Line too long'
      })
    end
  end

  -- Set the diagnostics for the current buffer
  vim.diagnostic.set(vim.api.nvim_create_namespace("line_length_namespace"), currentBuf, diagnostics, {})
end

vim.api.nvim_create_user_command('AddLineLengthDiagnostics', function()
  M.add_line_length_diagnostics()
end, {})

return M
