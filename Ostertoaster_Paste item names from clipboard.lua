-- @description Paste item names from clipboard
-- @author Ostertoaster
-- @version 1.2
-- @provides clipboard_lib.lua
-- @about
--   Pastes names from clipboard (one per line) onto selected items' active takes.
--   Values wrap if more items than lines. Requires SWS extension.

local lib = dofile(({reaper.get_action_context()})[2]:match("^(.*[/\\])") .. "clipboard_lib.lua")
lib.paste_take_names("Paste item names from clipboard")
