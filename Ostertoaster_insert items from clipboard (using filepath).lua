-- @description Insert items from clipboard (using filepath)
-- @author Ostertoaster
-- @version 1.2
-- @provides clipboard_lib.lua
-- @about
--   Inserts media items from comma-separated file paths in the clipboard.
--   Requires SWS extension.

local lib = dofile(({reaper.get_action_context()})[2]:match("^(.*[/\\])") .. "clipboard_lib.lua")
local paths = lib.split_str(reaper.CF_GetClipboard(), ",")
for _, path in ipairs(paths) do
  reaper.InsertMedia(path, 1)
end
