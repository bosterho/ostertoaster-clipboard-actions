-- @description Paste take markers from clipboard
-- @author Ostertoaster
-- @version 1.0
-- @about
--   Pastes take marker positions from clipboard onto the first selected item's active take.
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
take = reaper.GetActiveTake(reaper.GetSelectedMediaItem(0, 0))
for m = 0, #clipboard_lines - 1 do
  line_index = (m % #clipboard_lines) + 1
  pos = tonumber(clipboard_lines[line_index])
  if pos ~= nil then
    retval, name, color = reaper.SetTakeMarker(take, m, "", pos)
    -- reaper.SetMediaItemInfo_Value(item, "D_LENGTH", length)
  end
end

reaper.Undo_EndBlock("Paste item markers from clipboard", 0)
