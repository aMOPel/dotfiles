-- auto recompile lazy loading after altering plugins.lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
  vim.cmd [[qa]]
end

local utils = require('utils')
local p = utils.p


vim.cmd [[packadd packer.nvim]]
require('packer').startup(function(use)
  local core_prefix = 'plugins/core/'
  local ft_prefix = 'ft/'
  local misc_prefix = 'plugins/misc/'

  local function useCore(script_name)
    require(core_prefix .. script_name)(use)
  end

  local function useDir(prefix)
    for _, s in pairs(utils.getPluginScripts(prefix)) do
      require(prefix .. s)(use)
    end
  end

  use { p 'https://github.com/wbthomason/packer.nvim', }

  useDir(ft_prefix)

  -- importing in order
  useCore('libs')
  useCore('ft')
  useCore('lsp')
  useCore('treesitter')
  useCore('visuals')
  useCore('cmp')
  useCore('basics')

  useDir(misc_prefix)

end)

local noremap = utils.noremap
noremap('n', '<leader>pu', ':PackerSync<cr>')
noremap('n', '<leader>pi', ':PackerInstall<cr>')
noremap('n', '<leader>pc', ':PackerClean<cr>')
noremap('n', '<leader>pr', ':PackerCompile<cr>')
noremap('n', '<leader>ps', ':PackerStatus<cr>')
