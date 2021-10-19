local M = {}
local api = vim.api;
local uv = vim.loop;
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

function M.init_hl()
    local ft = api.nvim_buf_get_option(0, 'filetype')
    local ok, parser = pcall(vim.treesitter.get_parser, 0, ft)
    if not ok then return end
    local get_query = require('vim.treesitter.query').get_query
    local ok, query = pcall(get_query, ft, 'highlights')
    if ok and query then
        vim.treesitter.highlighter.new(parser, query)
    end
end


--- Like :only but delete other buffers
function M.only()
    local cur_buf = api.nvim_get_current_buf()
    for _, buf in ipairs(api.nvim_list_bufs()) do
        if cur_buf ~= buf then
            pcall(vim.cmd, 'bd ' .. buf)
        end
    end
end


function M.emoji()
    local lines = {}
    for line in io.lines(os.getenv('HOME') .. '/.config/dm/emoji.json') do
        table.insert(lines, line)
    end
    local items = vim.fn.json_decode(table.concat(lines, '\n'))
    require('fzy').pick_one(
    items,
    'Emoji> ',
    function(item) return  item.emoji .. ' ' .. item.description end,
    function(item)
        if item then
            api.nvim_feedkeys('a' .. item.emoji, 'n', true)
        end
    end
    )
end


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

function M.buf_close_current()
    vim.api.nvim_buf_delete(0, {})
end


return M
