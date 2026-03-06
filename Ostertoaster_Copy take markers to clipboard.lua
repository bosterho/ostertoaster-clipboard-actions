-- @description Copy take markers to clipboard
-- @author Ostertoaster
-- @version 1.0
-- @about
--   Copies the positions of all take markers from the first selected item to the clipboard.
--   Requires SWS extension.

script_name = 'copy selected items take markers to clipboard (multiline)'
reaper.Undo_BeginBlock();

item = reaper.GetSelectedMediaItem(0, 0)
take = reaper.GetActiveTake(item)
clipboard_str = ""
for m = 0, reaper.GetNumTakeMarkers(take) - 1 do
  retval, name, color = reaper.GetTakeMarker(take, m)
  clipboard_str = clipboard_str .. retval .. "\n"
end
reaper.CF_SetClipboard(clipboard_str)
reaper.Undo_EndBlock(script_name,-1);

