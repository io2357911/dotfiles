require("awful")

local function exec(cmd)
	fh = assert(io.popen(cmd, "r"))
	res = fh:read("*l")
	fh:close()
	return res
end

local function decorate(str)
	return "" .. str .. " | "
end

local function new_updatable_widget(timeout, fnupdate)
        local w = widget({ type = "textbox" })
        w.text = decorate(fnupdate())

        local wt = timer({ timeout = timeout })
        wt:add_signal("timeout", function() w.text = decorate(fnupdate()) end)
        wt:start()

        return w
end

tweaks = {}
tweaks.widget = {}

tweaks.widget.power = new_updatable_widget(30, function() 
	local acpi = exec('acpi')

        local state = ''
        if string.find(acpi, 'Charging') then state = '+'
        elseif string.find(acpi, 'Discharging') then state = '-' end

        local num = string.match(acpi, '[0-9]+%%')

	return state..num
end)

tweaks.widget.clock = new_updatable_widget(60, function() 
	return exec("date +'%a %d %b %H:%M'") 
end)

tweaks.widget.locale = new_updatable_widget(1, function() 
	local loc = exec("xset -q|grep LED| awk '{ print $10 }'")
	if loc == '00001004' then 	return 'ru'
	else 				return 'en' end
end)
