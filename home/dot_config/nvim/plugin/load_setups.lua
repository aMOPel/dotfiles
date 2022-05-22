local setups = require'globals'.plugin.setups

for _, setup in pairs(setups) do
  setup()
end
