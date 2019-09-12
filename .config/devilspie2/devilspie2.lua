-- the debug_print command does only print anything to stdout
-- if devilspie2 is run using the --debug option
-- debug_print("Window Name: " .. get_window_name());
-- debug_print("Application name: " .. get_application_name())

-- Needed to make switch on hostname
-- local socket = require "socket"
-- local hostname = socket.dns.gethostname();

-- setup. (String comparison are case sensitive, please note this when
-- creating rule scripts.)
if (get_application_name() == "neovim") then
  set_window_geometry2(1720, 0, 1720, 1440)
end

if (get_application_name() == "termite") then
  set_window_geometry2(0, 0, 1720, 1440)
end

if (get_application_name() == "Firefox" and get_window_type() ~= "WINDOW_TYPE_DIALOG") then
  set_window_geometry2(0, 0, 1720, 1440)
end
