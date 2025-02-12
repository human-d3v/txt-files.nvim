local M = {}

function M.LineBreak()
	local line_num = vim.api.nvim_win_get_cursor(0)[1]
	local win = vim.api.nvim_get_current_win()
	local br = string.rep("~", 79) --color line value
	vim.api.nvim_buf_set_lines(0, line_num, line_num, false, {br})
	vim.api.nvim_win_set_cursor(win, {line_num + 1, 0})
end

function M.WordCount() --counts words from visual selection
	vim.cmd('normal! gv"xy')
	local block = vim.fn.getreg('x')
	local word_count = 0
	for _ in string.gmatch(block, "%S+") do 
		word_count = word_count + 1
	end
	print("Word Count: " .. word_count)
end

return M
