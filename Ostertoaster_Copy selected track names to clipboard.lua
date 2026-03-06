-- @description Copy selected track names to clipboard
-- @author Ostertoaster
-- @version 1.2
-- @about
--   Copies the names of all selected tracks to the clipboard, one per line.
--   Requires SWS extension.

local str = ""
for t = 0, reaper.CountSelectedTracks(0) - 1 do
  local tr = reaper.GetSelectedTrack(0, t)
  local _, name = reaper.GetSetMediaTrackInfo_String(tr, 'P_NAME', '', false)
  str = str .. name .. "\n"
end
reaper.CF_SetClipboard(str)
