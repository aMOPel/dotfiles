-- auto recompile lazy loading after altering plugins.lua
-- TODO: figure out how to make this work
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost $XDG_DATA_HOME/chezmoi/home/nvim/lua/* :PackerCompile<CR>
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

  -- importing in order
  useCore('libs')
  useCore('filetypes')
  useCore('lsp')
  useCore('treesitter')
  useCore('visuals')
  useCore('cmp')
  useCore('basics')

  -- importing all misc scripts
  useDir(misc_prefix)

end)

local noremap = utils.noremap
noremap('n', '<leader>pu', ':PackerSync<cr>')
noremap('n', '<leader>pi', ':PackerInstall<cr>')
noremap('n', '<leader>pc', ':PackerClean<cr>')
noremap('n', '<leader>pr', ':PackerCompile<cr>')
noremap('n', '<leader>ps', ':PackerStatus<cr>')
