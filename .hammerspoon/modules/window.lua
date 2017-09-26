hs.hints.showTitleThresh = 0
hs.window.animationDuation = 0
hs.grid.setMargins(hs.geometry.size(0, 0))

function mouseMove()
    local frame = hs.window.focusedWindow():frame()
    local point = {x = frame.x + frame.w / 2, y = frame.y + frame.h / 2}
    hs.mouse.setAbsolutePosition(point)
end

function mouseHighlight()
    if mouseCircle then
        mouseCircle:delete()
        if mouseCircleTimer then
            mouseCircleTimer:stop()
        end
    end
    mousePoint = hs.mouse.getAbsolutePosition()
    mouseCircle = hs.drawing.circle(hs.geometry.rect(mousePoint.x - 25, mousePoint.y - 25, 60, 60))
    mouseCircle:setStrokeColor({["red"] = 1, ["blue"] = 0, ["green"] = 0, ["alpha"] = 1})
    mouseCircle:setStrokeWidth(5)
    mouseCircle:setFill(false)
    mouseCircle:bringToFront(true)
    mouseCircle:show(0.5)
    mouseCircleTimer = hs.timer.doAfter(3, function()
        mouseCircle:hide(0.5)
        hs.timer.doAfter(0.6, function()
            mouseCircle:delete()
        end)
    end)
end

hs.fnutils.each(hs.screen.allScreens(), function(screen)
    local frame = screen:frame()
    if frame.w >= 1920 then
        hs.grid.setGrid("3x3", s)
    elseif frame.w >= 1440 then
        hs.grid.setGrid("2x2", s)
    end
end)

hs.hotkey.bind(hyper, "[", function()
    local win = hs.window.focusedWindow()
    if not win then
        return
    end
    win:moveToUnit(hs.layout.left50)
end)

hs.hotkey.bind(hyper, "]", function()
    local win = hs.window.focusedWindow()
    if not win then
        return
    end
    win:moveToUnit(hs.layout.right50)
end)

hs.hotkey.bind(hyper, "up", function()
    local win = hs.window.focusedWindow()
    if not win then
        return
    end
    win:moveToUnit(hs.layout.maximized)
end)

hs.hotkey.bind(hyper, "down", function()
    local win = hs.window.focusedWindow()
    if not win then
        return
    end
    local screen = win:screen()
    local frame = screen:frame()
    frame.w = frame.w / 1.5
    frame.h = frame.h / 1.5
    win:move(frame)
    win:centerOnScreen(screen)
end)

hs.hotkey.bind(hyper, "left", function()
    local win = hs.window.focusedWindow()
    if not win then
        return
    end
    local s = win:screen():toWest()
    if s then
        win:moveToScreen(s)
        mouseMove()
    end
    -- win:moveOneScreenWest()
end)

hs.hotkey.bind(hyper, "right", function()
    local win = hs.window.focusedWindow()
    if not win then
        return
    end
    local s = win:screen():toEast()
    if s then
        win:moveToScreen(s)
        mouseMove()
    end
    -- win:moveOneScreenEast()
end)


hs.hotkey.bind(hyper, ",", function()
    hs.hints.windowHints(nil, mouseMove, false)
end)

hs.hotkey.bind(hyperShift, ",", function()
    hs.hints.windowHints(hs.window.focusedWindow():application():allWindows(), mouseMove, true)
end)

hs.hotkey.bind(hyper, ".", function()
    hs.grid.toggleShow()
end)

hs.hotkey.bind(hyper, "/", function()
    mouseHighlight()
end)

