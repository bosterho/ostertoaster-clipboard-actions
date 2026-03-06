-- @description Paste take markers from clipboard
-- @author Ostertoaster
-- @version 1.1
-- @provides clipboard_lib.lua
-- @about
--   Pastes take marker positions from clipboard onto the first selected item's active take.
--   Requires SWS extension.

local lib = dofile(({reaper.get_action_context()})[2]:match("^(.*[/\\])") .. "clipboard_lib.lua")
reaper.Undo_BeginBlock()
local lines = lib.split_str(reaper.CF_GetClipboard(), "\n")
local take = reaper.GetActiveTake(reaper.GetSelectedMediaItem(0, 0))
for m = 0, #lines - 1 do
  local pos = tonumber(lines[(m % #lines) + 1])
  if pos ~= nil then
    reaper.SetTakeMarker(take, m, "", pos)
  end
end
reaper.Undo_EndBlock("Paste take markers from clipboard", 0)
