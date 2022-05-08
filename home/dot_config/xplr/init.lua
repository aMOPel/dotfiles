version = "0.17.6"

xplr.config.general.show_hidden = true
xplr.config.general.enable_recover_mode = true
xplr.config.general.enforce_bounded_index_navigation = true

xplr.config.modes.builtin.go_to.key_bindings.on_key.h = {
  help = "history",
  messages = {
    "PopMode",
    {
      BashExec = [===[
        PTH=$(cat "${XPLR_PIPE_HISTORY_OUT:?}" | sort -u | fzf --no-sort)
        if [ "$PTH" ]; then
          echo ChangeDirectory: "'"${PTH:?}"'" >> "${XPLR_PIPE_MSG_IN:?}"
        fi
      ]===],
    },
  },
}
xplr.config.modes.builtin.default.key_bindings.on_key.R = {
  help = "batch rename",
  messages = {
    {
      BashExec = [===[
       SELECTION=$(cat "${XPLR_PIPE_SELECTION_OUT:?}")
       NODES=${SELECTION:-$(cat "${XPLR_PIPE_DIRECTORY_NODES_OUT:?}")}
       if [ "$NODES" ]; then
         echo -e "$NODES" | renamer
         echo ExplorePwdAsync >> "${XPLR_PIPE_MSG_IN:?}"
       fi
     ]===],
    },
  },
}
local home = os.getenv("HOME")
local xpm_path = home .. "/.local/share/xplr/dtomvan/xpm.xplr"
local xpm_url = "https://github.com/dtomvan/xpm.xplr"

package.path = package.path
  .. ";"
  .. xpm_path
  .. "/?.lua;"
  .. xpm_path
  .. "/?/init.lua"

os.execute(
  string.format(
    "[ -e '%s' ] || git clone '%s' '%s'",
    xpm_path,
    xpm_url,
    xpm_path
  )
)
require("xpm").setup({
  plugins = {
    -- Let xpm manage itself
    'dtomvan/xpm.xplr',
    { name = 'sayanarijit/fzf.xplr' },
    { name = 'sayanarijit/zoxide.xplr' },
    { name = 'sayanarijit/dual-pane.xplr' },
    { name = 'prncss-xyz/type-to-nav.xplr' },
    { name = 'prncss-xyz/icons.xplr' },
  },
  auto_install = true,
  auto_cleanup = true,
})
