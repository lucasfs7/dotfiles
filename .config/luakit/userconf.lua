local settings = require "settings"
local downloads = require "downloads"
local window = require "window"
local modes = require "modes"
local noscript = require "noscript"
local search_engines = settings.window.search_engines
local home_dir = os.getenv("HOME")
local video_cmd_fmt = "mpv --gpu-context=wayland --keep-open=yes --force-window=yes --load-unsafe-playlists '%s'"

-- general settings
settings.webview.enable_tabs_to_links = false

-- default locations
settings.window.home_page = "file://" .. home_dir .. "/.config/luakit/home/index.html"
downloads.default_dir = home_dir .. "/Downloads"

-- search engines
search_engines.ddg = "https://duckduckgo.com/?q=%s"
search_engines.ddgl = "https://duckduckgo.com/lite/?q=%s"
search_engines.bandcamp = "https://bandcamp.com/search?q=%s"
search_engines.yt = "https://youtube.com/results?search_query=%s"
search_engines.default = search_engines.ddgl

-- NoScript plugin, toggle scripts and or plugins on a per-domain basis.
-- `,ts` to toggle scripts, `,tp` to toggle plugins, `,tr` to reset.
-- If you use this module, don't use any site-specific `enable_scripts` or
-- `enable_plugins` settings, as these will conflict.
noscript.enable_scripts = false
noscript.enable_plugins = true

-- yank text to clipboard
modes.add_binds("normal", {
    { "<Control-Shift-c>", "Copy selected text.", function ()
        luakit.selection.clipboard = luakit.selection.primary
    end},
})

-- open everything as new window
-- instead of new tab
window.add_signal("init", function (w)
    w.new_tab_backup = w.new_tab
    w.new_tab = function (w, arg, opts)
        if type(arg) == "table" and arg.newtab_hack then
            arg.tab = w:new_tab_backup(arg.arg, arg.opts)
            return arg.tab
        elseif w.tabs ~= nil and w.tabs:count() > 0 then
            local args = { newtab_hack = true, arg = arg, opts = opts }
            local new_w = window.new({args})
            return args.tab
        else
            return w:new_tab_backup(arg, opts)
        end
    end
end)

-- open links with mpv
modes.add_binds("ex-follow", {
  { "v", "Hint all links and open the video behind that link externally with MPV.",
      function (w)
          w:set_mode("follow", {
              prompt = "open with MPV", selector = "uri", evaluator = "uri",
              func = function (uri)
                  assert(type(uri) == "string")
                  luakit.spawn(string.format(video_cmd_fmt, uri))
                  w:notify("Launched MPV")
              end
          })
      end },
  { "V", "Open the video on the current page externally with MPV.",
      function (w)
        local uri = string.gsub(w.view.uri or "", " ", "%%20")
        luakit.spawn(string.format(video_cmd_fmt, uri))
        w:notify("Launched MPV")
      end },
})

-- vim: et:sw=4:ts=8:sts=4:tw=80
