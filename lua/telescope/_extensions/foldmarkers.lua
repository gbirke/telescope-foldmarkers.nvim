local telescope = require('telescope')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local conf = require('telescope.config').values

local folding_marker_finder = function()
  local markers = {}
  local bufnr = vim.api.nvim_get_current_buf()
  local buffer_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for current_line, line in ipairs(buffer_lines) do
    if line:match("{{{") then
	  -- inserting at 1 to keep the order of markers in the buffer
      table.insert(markers, 1, { line, current_line })
    end
  end

  return finders.new_table {
    results = markers,
    entry_maker = function(entry)
		local display = entry[1]
        -- remove non-word characters from the beginning
		display = display:gsub("^%W+", "")

        -- indent by number of spaces according to the folding level (number after marker)
		local indent = display:match("{{{%d+")
		if indent then
			indent = tonumber(indent:match("%d+")) - 1
			display = string.rep(" ", indent*2) .. display
		end
        -- The following code could remove marker characters
		-- I don't like how that looks, so I commented it out
		-- But I could make it configurable	in the future
		-- display = display:gsub("{{{%d*", "")
		-- display = display:gsub("%d*}}}", "")
		--
		-- I could also optionally remove trailing non-word characters
      return { value = entry, display = display, ordinal = entry[1], lnum = entry[2]}
    end
  }
end


local folding_marker_picker = function(opts)
  pickers.new(opts, {
    prompt_title = 'Folding Markers',
    finder = folding_marker_finder(),
    sorter = conf.generic_sorter(opts),
	-- TODO: add previewer for the current buffer to show context
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.api.nvim_win_set_cursor(0, {selection.lnum, 0})
      end)
      return true
    end
  }):find()
end


return telescope.register_extension {
  exports = {
    foldmarkers = folding_marker_picker,
  },
}

