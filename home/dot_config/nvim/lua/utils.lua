local M = {}

M.map = function(mode, keys, mapping, args)
  args = args or {silent = true, noremap = true}
  vim.api.nvim_set_keymap(mode, keys, mapping, args)
end

M.p = function(ghlink)
  local result, count = string.gsub(ghlink,'https://github.com/', '')
  if count == 0 then
    result, _ = string.gsub(ghlink,'https://gitlab.com/', '')
  end
  return result
end

M.scandir = function(directory)
  local i, t, popen = 0, {}, io.popen
  local pfile = popen('ls -A "'..directory..'"')
  for filename in pfile:lines() do
    i = i + 1
    t[i] = filename
  end
  pfile:close()
  return t
end

M.stripLuaExtension = function(file)
  return string.gsub(file, '.lua', '')
end

M.stripLuaExtensions = function(files)
  local result = {}
  for i, f in pairs(files) do
    result[i] = M.stripLuaExtension(f)
  end
  return result
end

M.getPluginScripts = function()
  return M.stripLuaExtensions(M.scandir(vim.fn.stdpath('config')..'/lua/plugins'))
end

return M