local M = {}

function M.renderTitleSeparator(num)
	local sep = ''
	for i=1, num, 1 do
		sep = sep .. "~"
	end
	return sep
end

function M.renderBody(obj, selection)
	local definitions = obj.def
	local synonyms = obj.syn
	local lines = {}
	if selection == 'def' then
		for _, def in ipairs(definitions) do
			local def_to_render = " - " .. def
			table.insert(lines, def_to_render)
		end
	elseif selection == 'syn' then
    for _, syn in ipairs(synonyms) do
      local syn_to_render = " - " .. syn
      table.insert(lines, syn_to_render)
    end
	end
	return lines
end

function M.CreateFloatingWindow(word_object, header, selection)
	local bufnr = vim.api.nvim_create_buf(false, true)
	local window_width = vim.api.nvim_win_get_width(0)
	local window_height = vim.api.nvim_win_get_height(0)
	--calculate floating window size
	local float_width = math.ceil(window_width * 0.4)
	local float_height = math.ceil(window_height * 0.2)
	--calculate starting position
	local col = math.ceil((window_width - float_width) / 2)
	local row = math.ceil((window_height - float_height) / 2)
	--set opts
	local ui_opts = {
		relative = 'editor',
		width = float_width,
		height = float_height,
		col = col,
		row = row,
		style = 'minimal',
		border= {
		  {"╭", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╮", "FloatBorder"},
      {"│", "FloatBorder"},
      {"╯", "FloatBorder"},
      {"─", "FloatBorder"},
      {"╰", "FloatBorder"},
      {"│", "FloatBorder"}
		},
	}
	vim.cmd("highlight FloatBorder guifg=white")
	--create floating window
	vim.api.nvim_open_win(bufnr, true, ui_opts)
	-- create separator
	local header_separator = M.renderTitleSeparator(float_width)
	local body = M.renderBody(word_object, selection)
	vim.api.nvim_buf_set_lines(bufnr, 0, -1, false,
		{header, header_separator, word_object.word, unpack(body)}
	)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'q', '<cmd>bd!<CR>', {noremap=true,
		silent=true}
	)
end

return M
