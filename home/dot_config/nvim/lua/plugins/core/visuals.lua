local configs = {}

configs['onedark.nvim'] = function()
  require('onedark').load()
end

configs['nvim-gps'] = function()
  require('nvim-gps').setup()
end

configs['lualine.nvim'] = function()
  local gps = require("nvim-gps")

  require('lualine').setup {
    options = {
      theme = 'onedark',
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff' },
      lualine_c = {
        { gps.get_location, cond = gps.is_available },
      },
      lualine_x = {
        {
          'diagnostics',
          padding = 2,
          sources = { 'nvim_diagnostic' },
          sections = { 'error', 'warn', 'info', 'hint' },
          symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
          update_in_insert = false,
        },
      },
      lualine_y = { 'progress' },
      lualine_z = {
        {
          'filetype',
          colored = false,
          icon_only = true
        },
        {
          'filename',
          file_status = true,
          path = 1,
          shorting_target = 40
        },
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {
        {
          'filetype',
          colored = false,
          icon_only = true
        },
        {
          'filename',
          file_status = true,
          path = 1,
          shorting_target = 40
        },
      },
    },
    tabline = {
      lualine_a = { 'tabs' },
      lualine_b = { 'ObsessionStatusMod' },
      lualine_c = {},
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = {},
      lualine_z = {},
    },
    extensions = { 'quickfix', 'fugitive' },
  }
end

local p = require 'utils'.p

local M = function(use)
  use { p 'https://github.com/kyazdani42/nvim-web-devicons', }

  use {
    p 'https://github.com/nvim-lualine/lualine.nvim',
    config = configs['lualine.nvim'],
    after = 'nvim-treesitter',
    requires = {
      {
        p 'https://github.com/navarasu/onedark.nvim',
        config = configs['onedark.nvim'],
      },
      {
        p 'https://github.com/SmiteshP/nvim-gps',
        config = configs['nvim-gps'],
        -- after = 'nvim-treesitter',
      },
    },
  }
end
return M
