# HUD Notify [hud_notify]

### Dependencies: None

HUD Notify is a very simple mod that comprises of just one command `/notify`, which is _very_ similar to the builtin `/msg` command, except for the fact that /notify displays a message using HUD elements (instead of displaying via chat) for better noticeability. Due to the higher potential for abuse, the use of this command is restricted to moderators and above.

### Usage
`/notify <player_name> <msg>`

### Example
`/notify LegendaryGriefer Stop griefing or face a ban!`

### minetest.conf
- `notify.hud_duration`

Stores a numeric value (10 by default) which represents the duration of the message visibility in seconds.

### Screenshot
![screenshot](https://raw.githubusercontent.com/ClobberXD/hud_notify/master/screenshot.png)

### TODO
- [x] Re-Implement using HUD element to get rid of it's [disadvantages](https://forum.minetest.net/viewtopic.php?p=317428#p317428). (Fixed with [3e34a4b](https://github.com/ClobberXD/hud_notify/commit/3e34a4b7ce640f8e739979c472be47a3a352fae0))
- [ ] Add automatic line-break if `msg` too long.
