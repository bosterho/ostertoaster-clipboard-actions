-- @description Copy selected track names to clipboard
-- @author Ostertoaster
-- @version 1.0
-- @about
--   Copies the names of all selected tracks to the clipboard, one per line.
--   Requires SWS extension.

str = ""
for t = 0, reaper.CountSelectedTracks(0) - 1 do
  tr = reaper.GetSelectedTrack(0, t)
  _, name = reaper.GetSetMediaTrackInfo_String(tr, 'P_NAME', str, false)
  str = str .. name .. "\n"
end
reaper.CF_SetClipboard(str)
