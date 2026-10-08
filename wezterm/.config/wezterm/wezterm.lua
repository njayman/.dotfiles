local wezterm = require("wezterm")

return {
  font = wezterm.font("JetBrainsMono Nerd Font"),
  font_size = 13,
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  window_close_confirmation = "AlwaysPrompt",
  mouse_bindings = {
    -- selecting copies nothing; right-click copies
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "NONE",
      action = wezterm.action.Nop,
    },
    {
      event = { Up = { streak = 2, button = "Left" } },
      mods = "NONE",
      action = wezterm.action.Nop,
    },
    {
      event = { Up = { streak = 3, button = "Left" } },
      mods = "NONE",
      action = wezterm.action.Nop,
    },
    {
      event = { Down = { streak = 1, button = "Right" } },
      mods = "NONE",
      action = wezterm.action_callback(function(window, pane)
        local text = window:get_selection_text_for_pane(pane)
        if text == "" then return end
        window:perform_action(wezterm.action.CopyTo("ClipboardAndPrimarySelection"), pane)
        window:perform_action(wezterm.action.ClearSelection, pane)
        window:toast_notification("wezterm", "Copied " .. #text .. " chars", nil, 1500)
      end),
    },
  },
  colors = {
    -- rainbowmetal (ported from foot)
    foreground = "#d6d0d6",
    background = "#000000",
    cursor_bg = "#c7b463",
    cursor_fg = "#000000",
    selection_fg = "#d6d0d6",
    selection_bg = "#161116",
    ansi = { "#000000", "#974b46", "#99bbaa", "#eecc6c", "#5f81a5", "#b5679d", "#5c9fc2", "#d6d0d6" },
    brights = { "#3a3542", "#bb8a87", "#ddeecc", "#f3ecd4", "#97adc4", "#cf82b5", "#74b8d9", "#efeaef" },
  },
}
