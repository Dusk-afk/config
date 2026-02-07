---------------------------------------------------------------------
-- Hammerspoon App Switcher by Rakhesh (cleaned up and annotated)
---------------------------------------------------------------------

-- Get first app from list (before ';')
local function getFirstAppFromList(appList, separator)
  separator = separator or ';'
  if string.find(appList, separator) then
    return (string.gsub(appList, separator .. ".*", ''))
  else
    return appList
  end
end

-- Given a list of apps (e.g. "VS Code; Calendar") and current app,
-- return the *next* app in that list
local function getAppToLaunchFromList(appList, appName, separator)
  separator = separator or ';'
  local position, counter = 0, 1
  local tokens = {}

  for str in string.gmatch(appList, "([^" .. separator .. "]+)") do
    local sanitized = (string.gsub(str, '^%s+', ''))
    table.insert(tokens, sanitized)
    if sanitized == appName then position = counter end
    counter = counter + 1
  end

  if position == 0 then
    return nil
  elseif position == #tokens then
    return tokens[1]
  else
    return tokens[position + 1]
  end
end

-- Launch, focus, or rotate windows/apps
local function launchOrFocusOrRotate(appList)
  local app = getFirstAppFromList(appList)
  local focusedWindow = hs.window.focusedWindow()

  if not focusedWindow then
    hs.application.launchOrFocus(app)
    return
  end

  local focusedApp = focusedWindow:application()
  local focusedAppName = focusedApp:name()
  local focusedAppPath = focusedApp:path() or ""
  local appNameOnDisk = focusedAppPath:gsub("/Applications/", "")
                                       :gsub("%.app", "")
                                       :gsub("/System/Library/CoreServices/", "")

  if appNameOnDisk == app then
    local appWindows = hs.application.get(focusedAppName):allWindows()
    if #appWindows > 1 then
      if app == "Finder" then
        appWindows[#appWindows - 1]:focus()
      else
        appWindows[#appWindows]:focus()
      end
    else
      -- no extra window → move to next app in list
      local nextApp = getAppToLaunchFromList(appList, app)
      hs.application.launchOrFocus(nextApp)
    end
  else
    hs.application.launchOrFocus(app)
  end
end

---------------------------------------------------------------------
-- Define your shortcuts here
---------------------------------------------------------------------
-- Format: {"<key>", "<App1; App2; ...>"}
-- Keys are case-insensitive; multiple apps separated by semicolon
---------------------------------------------------------------------
local ctrlCmdShortcuts = {
  {"1", "Zen"},
  {"2", "Visual Studio Code"},
  {"3", "IntelliJ IDEA CE"},
  {"4", "Slack"},
  {"5", "ChatGPT"},
  {"6", "Postman"},
  {"9", "WezTerm"},
  {"0", "Google Chrome"},
  -- Example multi-app toggle:
  -- {"5", "Notes; Calendar"}
}

for _, shortcut in ipairs(ctrlCmdShortcuts) do
  hs.hotkey.bind({"cmd", "ctrl"}, shortcut[1], function()
    launchOrFocusOrRotate(shortcut[2])
  end)
end

---------------------------------------------------------------------
-- Done. Save file, reload Hammerspoon, enjoy!
---------------------------------------------------------------------



---------------------------------------------------------------------
-- Move current fullscreen window to next monitor
---------------------------------------------------------------------

hs.hotkey.bind({"cmd", "ctrl"}, "P", function()
    local win = hs.window.focusedWindow()
    if not win then return end

    local currentScreen = win:screen()
    local nextScreen = currentScreen:next()
    if not nextScreen then return end

    local wasFullScreen = win:isFullScreen()

    -- Step 1: Exit fullscreen if needed
    if wasFullScreen then
        win:setFullScreen(false)
        -- Wait for macOS to finish animation (~0.6s)
        hs.timer.doAfter(0.6, function()
            -- Step 2: Move to next screen
            win:moveToScreen(nextScreen)
            -- Step 3: Re-enter fullscreen after moving
            hs.timer.doAfter(0.6, function()
                win:setFullScreen(true)
                win:focus()
            end)
        end)
    else
        -- If not fullscreen, just move it instantly
        win:moveToScreen(nextScreen)
        win:focus()
    end
end)
