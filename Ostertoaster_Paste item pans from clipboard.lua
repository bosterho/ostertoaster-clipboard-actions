-- @description Paste item pans from clipboard
-- @author Ostertoaster
-- @version 1.0
-- @about
--   Pastes pan values from clipboard (one per line) onto selected items' active takes.
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
  take = reaper.GetActiveTake(item)
  line_index = (i % #clipboard_lines) + 1
  pan = tonumber(clipboard_lines[line_index])
  if pan ~= nil then
    reaper.SetMediaItemTakeInfo_Value(take, "D_PAN", pan)
    -- reaper.SetMediaItemInfo_Value(item, "D_PAN", length)
  end
end

reaper.Undo_EndBlock("Paste item lengths from clipboard", 0)
