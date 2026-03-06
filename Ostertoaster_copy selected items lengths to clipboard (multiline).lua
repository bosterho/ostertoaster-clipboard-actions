-- @description Copy selected items lengths to clipboard (multiline)
-- @author Ostertoaster
-- @version 1.1
-- @provides clipboard_lib.lua
-- @about
--   Copies the length (in seconds) of all selected media items to the clipboard, one per line.
--   Requires SWS extension.

local lib = dofile(({reaper.get_action_context()})[2]:match("^(.*[/\\])") .. "clipboard_lib.lua")
lib.copy_item_property("D_LENGTH", "Copy selected items lengths to clipboard")
