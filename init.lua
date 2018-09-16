--
-- /notify <player> <message>
--
-- Sends a PM to an online player using HUD elements
-- Restricted to only moderators, due to the potential for abuse
--

local players = {}
local duration = tonumber(minetest.settings:get("hud_notify.duration")) or 10
local hide_sender = minetest.settings:get_bool("hud_notify.hide_sender") or false

local function notify(name, param)
	local pname, msg = param:trim():match("^(%S+)%s(.+)$")
	if not pname or not msg then
		return false, "Invalid usage, see /help notify."
	end
	if not core.get_player_by_name(pname) then
		return false, "The player " .. pname .. " is not online."
	end

	local player = minetest.get_player_by_name(pname)
	players[pname] = {time = os.time() + duration}
	players[pname].bg = player:hud_add({
		hud_elem_type = "image",
		position = {x = 0, y = 0},
		offset = {x = 50, y = 300},
		scale = {x = -30, y = -30},
		alignment = {x = 1, y = 0},
		text = "hud_notify_bg.png"
	})
	players[pname].msg = player:hud_add({
		hud_elem_type = "text",
		position = {x = 0, y = 0},
		offset = {x = 70, y = 230},
		alignment = {x = 1, y = 0},
		number = 0xFFFFFF,
		text = msg
	})

	if not hide_sender then
		local msg_header = "Notification from " .. name .. ": "
		players[pname].header = player:hud_add({
			hud_elem_type = "text",
			position = {x = 0, y = 0},
			offset = {x = 70, y = 200},
			alignment = {x = 1, y = 0},
			number = 0x3399FF,
			text = msg_header,
			text = "hud_notify_bg.png"
		})
	end

	return true, "Notification sent to " .. pname .. ": \"" .. msg .. "\""
end

local function update()
	for name, hud in pairs(players) do
		if hud and os.time() > hud.time then
			local player = minetest.get_player_by_name(name)
			player:hud_remove(hud.bg)
			player:hud_remove(hud.msg)
			if not hide_sender then
				player:hud_remove(hud.header)
			end

			players[name] = nil
		end
	end
end

minetest.register_chatcommand("notify", {
	params = "<pname> <message>",
	description = "Shows a message to player using HUD elements. e.g. "
					.. "/notify LegendaryGriefer Stop griefing or face a ban!",
	privs = {kick = true, ban = true},
	func = notify
})

minetest.register_globalstep(update)
