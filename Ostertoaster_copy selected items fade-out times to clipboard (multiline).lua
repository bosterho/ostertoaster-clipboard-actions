-- @description Copy selected items fade-out times to clipboard (multiline)
-- @author Ostertoaster
-- @version 1.1
-- @provides clipboard_lib.lua
-- @about
--   Copies the fade-out length of all selected media items to the clipboard, one per line.
--   Requires SWS extension.

local lib = dofile(({reaper.get_action_context()})[2]:match("^(.*[/\\])") .. "clipboard_lib.lua")
lib.copy_item_property("D_FADEOUTLEN", "Copy selected items fade-out times to clipboard")
