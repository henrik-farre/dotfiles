-- the debug_print command does only print anything to stdout
-- if devilspie2 is run using the --debug option
-- debug_print("Window Name: " .. get_window_name());
-- debug_print("Application name: " .. get_application_name())

-- I want my Xfce4-terminal to the right on the second screen of my two-monitor
-- setup. (String comparison are case sensitive, please note this when
-- creating rule scripts.)
if (get_application_name() == "neovim") then
  xy(2881, 0);
  maximize();
end
