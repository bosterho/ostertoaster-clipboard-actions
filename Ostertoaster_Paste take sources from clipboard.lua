-- @description Paste take sources from clipboard
-- @author Ostertoaster
-- @version 1.2
-- @provides clipboard_lib.lua
-- @about
--   Pastes source file paths from clipboard onto selected items. Does not work on reversed items.
--   Requires SWS extension.

local lib = dofile(debug.getinfo(1, 'S').source:match[[^@?(.*[\/])[^\/]-$]] .. 'clipboard_lib.lua')
reaper.Undo_BeginBlock()
local lines = lib.get_clipboard_lines()
local num_items = reaper.CountSelectedMediaItems(0)
lib.log_mismatch(#lines, num_items, "Paste take sources from clipboard")
for i = 0, num_items - 1 do
  local item = reaper.GetSelectedMediaItem(0, i)
  local take = reaper.GetActiveTake(item)
  local source = lines[(i % #lines) + 1]
  local ok = reaper.BR_SetTakeSourceFromFile(take, source, false)
  if not ok then
    reaper.ShowConsoleMsg("fail: " .. source .. "\n")
  end
end
reaper.Main_OnCommand(40441, 0) -- Rebuild peaks for selected items
reaper.Undo_EndBlock("Paste take sources from clipboard", 0)
