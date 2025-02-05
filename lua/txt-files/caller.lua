local M = {}

function M.MakeCall(word)
	local cmd = '~/.local/share/nvim/lazy/txt-files.nvim/api-caller/dict-api --word ' .. word
	local handle = io.popen(cmd,"w")
	if handle == nil then
		return error("error in making api call")
	end
	local result = handle:read("*a")
	if result == nil then
		return error("error in reading api call result")
	end
	handle:close()
	return result 
	-- returns a string representing an object 
	--{'word'=<wd>, 'def'=[<def1>, <def2>, ...], 'syn'=[<syn1>, <syn2>, ...]}
end

function M.GetDefOrSyn(selection)
	if selection ~= 'def' and selection ~= 'syn' then
		return error("opt mst be 'def' or 'syn', you passed " .. selection)
	end
	local header = (selection == 'def') and 'Dictionary' or 'Thesaurus'
	vim.cmd('normal! gv"xy')
	local word = vim.fn.getreg('x')
	word = string.gsub(word, '\n', "") --strip newline
	local word_object_string = M.MakeCall(word) -- returns string
	local table_func = load("return " .. word_object_string) 
	if table_func == nil then
		return error("error in building table object")
	end
	local word_object = table_func() -- returns table
	
	local ui = require('txt-files.ui')
	ui.CreateFloatingWindow(word_object, header, selection)
end

return M
