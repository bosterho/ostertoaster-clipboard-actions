-- @description Paste take sources from clipboard
-- @author Ostertoaster
-- @version 1.0
-- @about
--   Pastes source file paths from clipboard onto selected items. Does not work on reversed items.
--   Requires SWS extension.

-- NOTE: This script doesn't work right for reversed items
reaper.ClearConsole()
reaper.Undo_BeginBlock()

function split_str(s, delimiter)
  result = {}
  for match in (s..delimiter):gmatch('(.-)'..delimiter) do
      table.insert(result, match)
  end
  return result
end

clipboard_lines = split_str(reaper.CF_GetClipboard(), "\n")

selected_items = {}
num_selected_items = 0
for i = 0, reaper.CountSelectedMediaItems(0) - 1 do
  selected_items[i]= reaper.GetSelectedMediaItem(0, i)
  num_selected_items = i + 1
end

name = ""
for i = 0, num_selected_items-1 do
  item = selected_items[i]
  take = reaper.GetActiveTake(item)
  line_index = (i % #clipboard_lines) + 1
  source = clipboard_lines[line_index]
  -- Remove carriage return and any extra newline characters there might be
  source = source:gsub("[\n\r]", "")
  retval = reaper.BR_SetTakeSourceFromFile(take, source, false)
  if retval == false then
    reaper.ShowConsoleMsg("fail: " .. source .. "\n")
  end
end
reaper.Main_OnCommand(40441, 0) -- Peaks: Rebuild peaks for selected items


reaper.Undo_EndBlock("Paste item sources from clipboard", 0)
