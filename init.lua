--
-- /notify <player> <message>
--
-- Sends a PM to an online player via a formspec (with the message) and an 'OK' button
-- Restricted to only moderators, due to the potential for abuse
--
minetest.register_chatcommand("notify", {
	params = "<player_name> <message>",
	description = "Shows a message to player, by means of a formspec. e.g. /notify rubenwardy Stop spamming!",
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
		minetest.show_formspec(player_name, "notify:msg",
			"size[8,4]" ..
			"label[0.5,0;" ..msg_header.. "]" ..
			"label[0.5,1;" ..msg.. "]" ..
			"button_exit[2,3;4,2;exit;OK]")
	end
})
