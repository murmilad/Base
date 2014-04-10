local io       = io 
local awful    = awful
local tonumber = tonumber
local naughty  = naughty

local current
local message_id

module("bridgeress")

function init()
	local f = io.popen("cat /sys/class/backlight/panasonic/brightness")
	awful.util.spawn("sudo chmod 666 /sys/class/backlight/panasonic/brightness")
	current = tonumber(f:read())
end

function bridgeressUp()
	if current < 100 then

		current = current + 10
		awful.util.spawn("/home/alex/.config/awesome/bash/change_brightness.sh " .. current)
		message_id = naughty.notify({
			text        = current,
			timeout     = 1,
   			replaces_id = message_id
		}).id
	end
end

function bridgeressDown()
	if current > 0 then
		current = current - 10
		awful.util.spawn("/home/alex/.config/awesome/bash/change_brightness.sh " .. current)
		message_id = naughty.notify({
			text        = current,
			timeout     = 1,
   			replaces_id = message_id
		}).id
	end
end

init();

