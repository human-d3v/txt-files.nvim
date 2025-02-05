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
	vim.api.nvim_create_autocmd('FileType', {
		pattern = {'txt', 'text'},
		callback = function()
			vim.schedule(function()
				vim.keymap.set('n', '<leader>br>', function() funcs.LineBreak() end, 
					keymap_opts)
				vim.keymap.set("v", "<leader>wc", function() funcs.WordCount() end,
					keymap_opts)
				vim.keymap.set("v", "<leader>def", function() 
					caller.GetDefOrSyn('def') end, keymap_opts) 
				vim.keymap.set("v", "<leader>syn", function()
					caller.GetDefOrSyn('syn') end, keymap_opts)
				vim.opt_local.spell = true
			end)
		end
	})
end

return M
