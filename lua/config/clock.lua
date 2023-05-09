local status_ok, clock = pcall(require, "pommodoro-clock")
if not status_ok then
	return
end

clock.setup({
	-- 倒计时时长，单位：分钟
	modes = {
		["work"] = { "番茄钟", 25 },
		["short_break"] = { "SHORT BREAK", 5 },
		["long_break"] = { "LONG BREAK", 30 },
	},
	animation_duration = 300,
	animation_fps = 30,
	-- say_command = "spd-say -l en -t female3",
	say_command = "say",
	sound = "voice", -- set to "none" to disable
})
