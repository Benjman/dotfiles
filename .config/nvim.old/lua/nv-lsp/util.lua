local M = {}
local api = vim.api;
local path = require('nv-lsp.path')

function M.reload(name)
  package.loaded[name] = nil
  return require(name)
end

M.RE = setmetatable({}, {
  __index = function(_, k)
    return M.reload(k)
  end
})

function M.find_root(markers, bufname)
  bufname = bufname or api.nvim_buf_get_name(api.nvim_get_current_buf())
  local dirname = vim.fn.fnamemodify(bufname, ':p:h')
  local getparent = function(p)
    return vim.fn.fnamemodify(p, ':h')
  end
  while not (getparent(dirname) == dirname) do
    for _, marker in ipairs(markers) do
      if vim.loop.fs_stat(path.join(dirname, marker)) then
        return dirname
      end
    end
    dirname = getparent(dirname)
  end
end

function M.find_path(markers, bufname)
  bufname = bufname or api.nvim_buf_get_name(api.nvim_get_current_buf())
  local dirname = vim.fn.fnamemodify(bufname, ':p:h')
  local getparent = function(p)
    return vim.fn.fnamemodify(p, ':h')
  end
  while not (getparent(dirname) == dirname) do
    for _, marker in ipairs(markers) do
      local path = path.join(dirname, marker)
      if vim.loop.fs_stat(path) then
        return path
      end
    end
    dirname = getparent(dirname)
  end
end

return M
