local apps = {
    f = 'Finder',
    t = 'iTerm',
    v = 'MacVim',
    b = 'Google Chrome'
}

for key, app in pairs(apps) do
    hs.hotkey.bind(hyper, key, function()
        hs.application.launchOrFocus(app)
    end)
end
