local plugins = require'globals'.plugins

for _, data in pairs(plugins) do
  data.setup()
end
