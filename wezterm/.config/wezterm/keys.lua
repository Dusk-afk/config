local wezterm = require 'wezterm'
local act = wezterm.action
local module = {}

-- Remembers the workspace we were on before jumping to `scratch`,
-- so LEADER o can bounce us back.
local last_workspace = nil
local SCRATCH = 'scratch'

function module.apply_to_config(config)
    config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1500 }

    -- Extend (don't replace) the default key tables so we keep WezTerm's
    -- built-in search_mode bindings (Esc, Ctrl-n/p, etc.) and only add ours.
    local key_tables = wezterm.gui.default_key_tables()
    table.insert(key_tables.search_mode, {
      key = 'Backspace',
      mods = 'CMD',
      action = act.CopyMode 'ClearPattern',
    })
    config.key_tables = key_tables

    config.keys = {
      -- Shift + Enter for new line
      {
        key = "Enter",
        mods = "SHIFT",
        action = wezterm.action.SendString("\n")
      },

      -- Rebind OPT-Left, OPT-Right as ALT-b, ALT-f respectively to match Terminal.app behavior
      {
        key = 'LeftArrow',
        mods = 'OPT',
        action = wezterm.action.SendKey { key = 'b', mods = 'ALT' },
      },
      {
        key = 'RightArrow',
        mods = 'OPT',
        action = wezterm.action.SendKey { key = 'f', mods = 'ALT' },
      },

      -- macOS line-nav shortcuts: CMD-Left/Right jump to line start/end,
      -- CMD-Backspace deletes from cursor to line start.
      {
        key = 'LeftArrow',
        mods = 'CMD',
        action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
      },
      {
        key = 'RightArrow',
        mods = 'CMD',
        action = wezterm.action.SendKey { key = 'e', mods = 'CTRL' },
      },
      {
        key = 'Backspace',
        mods = 'CMD',
        action = wezterm.action.SendKey { key = 'u', mods = 'CTRL' },
      },

      -- LEADER n: create or jump to a workspace by name
      {
        key = 'n',
        mods = 'LEADER',
        action = act.PromptInputLine {
          description = wezterm.format {
            { Attribute = { Intensity = 'Bold' } },
            { Foreground = { AnsiColor = 'Fuchsia' } },
            { Text = 'New workspace name:' },
          },
          action = wezterm.action_callback(function(window, pane, line)
            if line and line ~= '' then
              window:perform_action(act.SwitchToWorkspace { name = line }, pane)
            end
          end),
        },
      },

      -- LEADER s: fuzzy switch between workspaces
      {
        key = 's',
        mods = 'LEADER',
        action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
      },

      -- LEADER b: toggle between normal (0.95) and more transparent (0.70).
      {
        key = 'b',
        mods = 'LEADER',
        action = wezterm.action_callback(function(window, _)
          local overrides = window:get_config_overrides() or {}
          if overrides.window_background_opacity == 0.70 then
            -- Back to normal: less transparent, less blur.
            overrides.window_background_opacity = 0.95
            overrides.macos_window_background_blur = 20
          else
            -- More transparent: bump blur to keep text legible over busy bg.
            overrides.window_background_opacity = 0.70
            overrides.macos_window_background_blur = 60
          end
          window:set_config_overrides(overrides)
        end),
      },

      -- LEADER d: jump to the default workspace from anywhere.
      {
        key = 'd',
        mods = 'LEADER',
        action = act.SwitchToWorkspace { name = 'default' },
      },

      -- LEADER o: toggle between the scratch workspace and wherever we were before.
      {
        key = 'o',
        mods = 'LEADER',
        action = wezterm.action_callback(function(window, pane)
          local current = window:active_workspace()
          if current == SCRATCH then
            local target = last_workspace or 'default'
            window:perform_action(act.SwitchToWorkspace { name = target }, pane)
          else
            last_workspace = current
            window:perform_action(act.SwitchToWorkspace { name = SCRATCH }, pane)
          end
        end),
      },

      -- LEADER t: fuzzy switch between tabs in current workspace
      {
        key = 't',
        mods = 'LEADER',
        action = act.ShowTabNavigator,
      },

      -- LEADER c: new tab in current workspace
      {
        key = 'c',
        mods = 'LEADER',
        action = act.SpawnTab 'CurrentPaneDomain',
      },

      -- LEADER r: rename current tab
      {
        key = 'r',
        mods = 'LEADER',
        action = act.PromptInputLine {
          description = wezterm.format {
            { Attribute = { Intensity = 'Bold' } },
            { Foreground = { AnsiColor = 'Fuchsia' } },
            { Text = 'Tab title:' },
          },
          action = wezterm.action_callback(function(window, pane, line)
            if line then
              window:active_tab():set_title(line)
            end
          end),
        },
      },

      -- Move current tab left/right. Behind LEADER so nothing else (AeroSpace,
      -- browsers, macOS) can intercept. Capital H/L mirrors vim convention:
      -- lowercase h/l navigates between panes, uppercase moves the tab itself.
      {
        key = 'H',
        mods = 'LEADER|SHIFT',
        action = act.MoveTabRelative(-1),
      },
      {
        key = 'L',
        mods = 'LEADER|SHIFT',
        action = act.MoveTabRelative(1),
      },

      -- Pane splits: \ = right (vertical divider), - = below (horizontal divider)
      {
        key = '\\',
        mods = 'LEADER',
        action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
      },
      {
        key = '-',
        mods = 'LEADER',
        action = act.SplitVertical { domain = 'CurrentPaneDomain' },
      },

      -- Vim-style pane navigation
      { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
      { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
      { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
      { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },

      -- Toggle zoom on the current pane (fullscreen within the tab)
      {
        key = 'z',
        mods = 'LEADER',
        action = act.TogglePaneZoomState,
      },

      -- Close current pane with confirmation
      {
        key = 'x',
        mods = 'LEADER',
        action = act.CloseCurrentPane { confirm = true },
      },

      -- LEADER p: "park" the current Claude session.
      -- Sends /exit to Claude (which prints its `claude --resume <uuid>` hint
      -- before quitting) and marks the tab with a 💤 prefix so we know
      -- visually that it's RAM-free.
      {
        key = 'p',
        mods = 'LEADER',
        action = wezterm.action_callback(function(window, pane)
          -- \r is the actual Enter keystroke (carriage return). \n would be
          -- a literal newline inside Claude's input box, not a submit.
          pane:send_text('/exit\r')
          local tab = window:active_tab()
          local current = tab:get_title()
          if current == '' then
            current = pane:get_title() or 'parked'
          end
          if not current:find('^💤 ') then
            tab:set_title('💤 ' .. current)
          end
        end),
      },

      -- LEADER u: "unpark" — find the most recent `claude --resume <uuid>`
      -- line in the pane scrollback and replay it. Falls back to the resume
      -- picker if nothing matches.
      {
        key = 'u',
        mods = 'LEADER',
        action = wezterm.action_callback(function(window, pane)
          local text = pane:get_lines_as_text(300)
          -- Collect lines, then iterate bottom-up so the newest park wins
          -- when multiple `claude --resume <uuid>` lines sit in scrollback.
          local lines = {}
          for line in text:gmatch('[^\n]+') do
            table.insert(lines, line)
          end
          local cmd
          -- Match lines that *start* with `claude --resume ...` (Claude's
          -- own exit hint). This skips shell-prompt lines like
          -- `❯ claude --resume <uuid>` from prior unparks, and accepts
          -- both UUID and quoted-name forms ("test", "my-session", etc.).
          for i = #lines, 1, -1 do
            local m = lines[i]:match('^%s*(claude%s+%-%-resume%s+.+)$')
            if m then
              cmd = m:gsub('%s+$', '')
              break
            end
          end
          pane:send_text((cmd or 'clod --resume') .. '\r')

          local tab = window:active_tab()
          local title = tab:get_title()
          local stripped = title:gsub('^💤%s+', '')
          if stripped ~= title then
            -- Clear the override so the tab title falls back to whatever
            -- the running process publishes (Claude will set it on resume).
            tab:set_title(stripped == pane:get_title() and '' or stripped)
          end
        end),
      },

      -- LEADER g: spawn a 4x2 grid of `clod` sessions in ~/cred
      {
        key = 'g',
        mods = 'LEADER',
        action = wezterm.action_callback(function(window, _)
          local cwd = wezterm.home_dir .. '/cred'
          local _, first, _ = window:mux_window():spawn_tab { cwd = cwd }

          -- Recursive halving gives 4 equal-width columns.
          local col1 = first
          local col3 = col1:split { direction = 'Right',  size = 0.5, cwd = cwd }
          local col2 = col1:split { direction = 'Right',  size = 0.5, cwd = cwd }
          local col4 = col3:split { direction = 'Right',  size = 0.5, cwd = cwd }

          -- For each column, split bottom at 50% to create row 2.
          local tops = { col1, col2, col3, col4 }
          local bottoms = {}
          for i, top in ipairs(tops) do
            bottoms[i] = top:split { direction = 'Bottom', size = 0.5, cwd = cwd }
          end

          -- Fire `clod` in every pane (alias, so we send it as shell input).
          for _, p in ipairs(tops) do p:send_text('clod\n') end
          for _, p in ipairs(bottoms) do p:send_text('clod\n') end

          window:active_tab():set_title('clods')
        end),
      },
    }
end

return module
