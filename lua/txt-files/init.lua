local M = {}

local default_opts = {default = true}

function M.setup(opts)
	opts = vim.tbl_deep_extend("force", default_opts, opts or {})
	local caller = require('txt-files.caller')
	local funcs = require('txt-files.funcs')
	if opts.default ~= true then
		return
	end
	local keymap_opts = {noremap = true, silent = true}
	vim.api.nvim_create_autocmd('filetype', {
		pattern = {'txt', 'text'},
		callback = function()
			vim.schedule(function()
				vim.keymap.set('n', '<leader>br', function() funcs.linebreak() end,
					keymap_opts)
				vim.keymap.set("v", "<leader>wc", function() funcs.wordcount() end,
					keymap_opts)
				vim.keymap.set("v", "<leader>def", function()
					caller.getdeforsyn('def') end, keymap_opts)
				vim.keymap.set("v", "<leader>syn", function()
					caller.getdeforsyn('syn') end, keymap_opts)
				vim.opt_local.spell = true
			end)
		end
	})
end

return M
