local config = {}

function config.mason()
  return function()
    require('mason').setup({
      ui = {
        border = 'rounded'
      }
    })
  end
end

return config
