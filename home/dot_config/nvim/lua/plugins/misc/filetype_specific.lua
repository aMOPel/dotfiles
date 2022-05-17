local setups = {}
local configs = {}

setups['emmet-vim'] = function()
  vim.g.user_emmet_leader_key='<C-t>'
  vim.g.user_emmet_mode='in'
end

configs['package-info.nvim'] = function()
  require('package-info').setup()

  local noremap = require 'utils'.noremap_buffer
  noremap("n", "<leader>js", ":lua require('package-info').show()<CR>")
  noremap("n", "<leader>jh", ":lua require('package-info').hide()<CR>")
  noremap("n", "<leader>ju", ":lua require('package-info').update()<CR>")
  noremap("n", "<leader>jd", ":lua require('package-info').delete()<CR>")
  noremap("n", "<leader>ji", ":lua require('package-info').install()<CR>")
  noremap("n", "<leader>jr", ":lua require('package-info').reinstall()<CR>")
  noremap("n", "<leader>jp", ":lua require('package-info').change_version()<CR>")
end

configs['nvim-colorizer.lua'] = function()
  require 'colorizer'.setup {
    'css';
    'javascript';
    'yaml';
    'kitty';
    html = {
      mode = 'foreground';
    }
  }
end

local p = require 'utils'.p

local M = function(use)
  use {
    p 'https://github.com/mattn/emmet-vim',
    ft = { 'html', 'css' , 'vue' },
    setup = setups['emmet-vim']
  }

  use {
    p 'https://github.com/vuki656/package-info.nvim',
    requires = 'MunifTanjim/nui.nvim',
    config = configs['package-info.nvim'],
    event = 'BufEnter package.json',
  }

  use {
    p 'https://github.com/norcalli/nvim-colorizer.lua',
    ft = { 'kitty', 'yaml', 'html', 'css', 'javascript', 'typescript', 'vue' },
    -- config = configs['nvim-colorizer.lua'],
  }

  -- provides ax and ix
  use {
    p 'https://github.com/whatyouhide/vim-textobj-xmlattr',
    requires = 'kana/vim-textobj-user',
    ft = { 'html', 'vue' },
  }
end
return M

-- for sql:
-- https://github.com/tpope/vim-dadbod
