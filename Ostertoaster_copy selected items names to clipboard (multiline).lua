-- @description Copy selected items names to clipboard (multiline)
-- @author Ostertoaster
-- @version 1.1
-- @provides clipboard_lib.lua
-- @about
--   Copies the take names of all selected media items to the system clipboard, one per line.
--   Requires SWS extension.

local lib = dofile(({reaper.get_action_context()})[2]:match("^(.*[/\\])") .. "clipboard_lib.lua")
lib.copy_take_names("Copy selected items names to clipboard")
