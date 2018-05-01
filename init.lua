--
-- /notify <player> <message>
--
-- Sends a PM to an online player via HUD elements
-- Restricted to only moderators, due to the potential for abuse
--

local setting = "notify.hud_duration"

minetest.register_chatcommand("notify", {
	params = "<player_name> <message>",
	description = "Shows a message to player using HUD elements. e.g. /notify LegendaryGriefer Stop griefing or face a ban!",
	privs = {kick = true, ban = true},
	func = function(name, param)
		param = param:trim()
		local player_name, msg = param:match("^(%S+)%s(.+)$")
		if not player_name then
			return false, "Invalid usage, see /help notify."
		end
		if not core.get_player_by_name(player_name) then
			return false, "The player " ..player_name.. " is not online."
		end
		local msg_header = "Notification from " ..name.. ": "
		minetest.chat_send_player(name, "Notification sent to " ..player_name.. ": \"" ..msg.. "\"")
		
		local player = minetest.get_player_by_name(player_name)
		local hud_bg = player:hud_add({
			hud_elem_type = "image",
			position = {x = 0, y = 0},
			offset = {x = 50, y = 300},
			scale = {x = -30, y = -30},
			alignment = {x = 1, y = 0},
			text = "notify_bg.png"
		})
		local hud_header = player:hud_add({
			hud_elem_type = "text",
			position = {x = 0, y = 0},
			offset = {x = 70, y = 200},
			alignment = {x = 1, y = 0},
			number = 0x3399FF,
			text = msg_header
		})
		local hud_msg = player:hud_add({
			hud_elem_type = "text",
			position = {x = 0, y = 0},
			offset = {x = 70, y = 250},
			alignment = {x = 1, y = 0},
			number = 0xFFFFFF,
			text = msg
		})
		
		local duration = tonumber(minetest.settings:get(setting))
		if not duration then
			duration = 10
			minetest.setting_set(setting, "10")
		end
		
		minetest.after(duration, function()
			player:hud_remove(hud_bg)
			player:hud_remove(hud_header)
			player:hud_remove(hud_msg)
		end)
	end
})
