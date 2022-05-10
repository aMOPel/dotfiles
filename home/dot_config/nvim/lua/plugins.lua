-- auto recompile lazy loading after altering plugins.lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd[[qa]]
end

local utils = require('utils')
local p = utils.p
local map = utils.map

vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  use {
    p'https://github.com/wbthomason/packer.nvim',
  }

  -- require'libs'(use)
  -- require'cmp'(use)
  -- require'lsp'(use)

  -- require all scripts in /lua/plugins and pass them 'use'
  for _, s in pairs(utils.getPluginScripts()) do
    -- print(s)
    require('plugins/'..s)(use)
  end
end)

map('n', '<leader>pu', ':PackerSync<cr>')
map('n', '<leader>pi', ':PackerInstall<cr>')
map('n', '<leader>pc', ':PackerClean<cr>')
map('n', '<leader>pr', ':PackerCompile<cr>')
map('n', '<leader>ps', ':PackerStatus<cr>')
