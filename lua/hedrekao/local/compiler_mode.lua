local M = {}

local parse_error_string = function(str)
  -- src/Parser.hs:(30,3)-(32,11): warning:
  local file, line = str:match('([^:]+):%((%d+),%d+%)%-%(%d+,%d+%): .+')

  -- src/Parser.hs:10:3-8: error:
  if not file then
    file, line = str:match('([^:]+):(%d+):%d+%-%d+: .+:')
  end

  -- src/Model.hs:4:12: error:
  if not file then
    file, line = str:match('([^:]+):(%d+):%d+: .+:')
  end

  -- /absolute/path/to/some/java/source.java:229: error:
  if not file then
    file, line = str:match('([^:]+):(%d+): .+:')
  end

  return file, line
end

local function file_exists(filename)
  return vim.fn.filereadable(filename) == 1
end

local function open_file_line(filename, line)
  local line_arg = ''
  if line then
    line_arg = '+' .. line
  end

  vim.cmd(table.concat({ 'edit', line_arg, filename }, ' '))
end

function M.open_error(error_str)
  local filename, line = parse_error_string(error_str)

  if file_exists(filename) then
    open_file_line(filename, line)
  else
    vim.notify('Could not open file: ' .. filename, vim.log.levels.ERROR)
  end
end

function M.open_yanked_error()
  local error_str = vim.fn.getreg('+')
  M.open_error(error_str)
end

return M

