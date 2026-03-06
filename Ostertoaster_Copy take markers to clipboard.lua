-- @description Copy take markers to clipboard
-- @author Ostertoaster
-- @version 1.1
-- @about
--   Copies the positions of all take markers from the first selected item to the clipboard.
--   Requires SWS extension.

reaper.Undo_BeginBlock()
local item = reaper.GetSelectedMediaItem(0, 0)
local take = reaper.GetActiveTake(item)
local str = ""
for m = 0, reaper.GetNumTakeMarkers(take) - 1 do
  local pos = reaper.GetTakeMarker(take, m)
  str = str .. pos .. "\n"
end
reaper.CF_SetClipboard(str)
reaper.Undo_EndBlock("Copy take markers to clipboard", -1)
