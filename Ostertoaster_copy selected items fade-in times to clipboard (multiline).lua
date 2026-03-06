-- @description Copy selected items fade-in times to clipboard (multiline)
-- @author Ostertoaster
-- @version 1.0
-- @about
--   Copies the fade-in length of all selected media items to the clipboard, one per line.
--   Requires SWS extension.

script_name = 'copy selected items fade-in times to clipboard (multiline)'
reaper.Undo_BeginBlock();
selected_items = {}
num_selected_items = reaper.CountSelectedMediaItems(-1)
for i = 0, num_selected_items-1 do
  selected_items[i] = reaper.GetSelectedMediaItem(-1, i)
end

clipboard_str = ""
for i = 0, num_selected_items-1 do
  local value = reaper.GetMediaItemInfo_Value(selected_items[i], "D_FADEINLEN")
  clipboard_str = clipboard_str .. value .. "\n"
end
reaper.CF_SetClipboard(clipboard_str)
reaper.Undo_EndBlock(script_name,-1);

