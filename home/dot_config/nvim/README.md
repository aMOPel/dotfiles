# Strucuture

```text
nvim/
|-lua
  |-ft
    |-ftconfigs   # configs for filetypes, including lsp, treesitter, and ft depedent settings and mappings
      |-...
    |-_ft_config_template.lua 
  |-plugins
    |-core        # the core plugins
      |-basics.lua      # stuff I always need
      |-cmp.lua         # completion and snippets
      |-filetypes.lua   # support for filetypes, some are already supported, like md, but the plugin improves it further
      |-libs.lua        # shared plugin libraries
      |-lsp.lua         # lsp settings using lsp_config and lsp_installer, the actual configuration is done in lua/ft/ftconfigs/*
      |-treesitter.lua  # treesitter settings
      |-visuals.lua     # colorscheme, lualine, ...
    |-misc        # miscellaneous plugins, this is WIP
      |-debug.lua
      |-giveitashot.lua
      |-handy.lua
    |-_plugin_config_template.lua
  |-globals.lua # this global table is used to transport configuration data from lua/ft/ftconfigs/* to lsp.lua and treesitter.lua
  |-main.lua    # require plugins.lua and anything in ft/ftconfigs/
  |-plugins.lua # setup packer.nvim and require plugins/core in order and anything in plugins/misc/
  |-utils.lua   # utility functions
|-vimscript
  |-general # general/global settings writtin in vimscript
|-init.vim # from here vimscript/general/* is sourced, as well as lua/main.lua
```
