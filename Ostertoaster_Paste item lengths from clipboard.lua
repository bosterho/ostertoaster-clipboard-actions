-- @description Paste item lengths from clipboard
-- @author Ostertoaster
-- @version 1.0
-- @about
--   Pastes lengths from clipboard (one per line) onto selected items. Values wrap if more items than lines.
--   Requires SWS extension.

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

name = ""
for i = 0, reaper.CountSelectedMediaItems(0) - 1 do
  item = reaper.GetSelectedMediaItem(0, i)
  line_index = (i % #clipboard_lines) + 1
  length = tonumber(clipboard_lines[line_index])
  if length ~= nil then
    reaper.SetMediaItemInfo_Value(item, "D_LENGTH", length)
  end
end

reaper.Undo_EndBlock("Paste item lengths from clipboard", 0)
