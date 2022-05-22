local configs = require'globals'.plugin.configs

for plugin_name, data in pairs(configs) do
  print(plugin_name)
  data.config()
end
