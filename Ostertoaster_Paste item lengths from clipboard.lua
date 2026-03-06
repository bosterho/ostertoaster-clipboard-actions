-- @description Paste item lengths from clipboard
-- @author Ostertoaster
-- @version 1.2
-- @provides clipboard_lib.lua
-- @about
--   Pastes lengths from clipboard (one per line) onto selected items. Values wrap if more items than lines.
--   Requires SWS extension.

local lib = dofile(({reaper.get_action_context()})[2]:match("^(.*[/\\])") .. "clipboard_lib.lua")
lib.paste_item_property("D_LENGTH", "Paste item lengths from clipboard")
