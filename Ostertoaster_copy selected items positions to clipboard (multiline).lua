-- @description Copy selected items positions to clipboard (multiline)
-- @author Ostertoaster
-- @version 1.2
-- @provides clipboard_lib.lua
-- @about
--   Copies the position (in seconds) of all selected media items to the clipboard, one per line.
--   Requires SWS extension.

local lib = dofile(debug.getinfo(1, 'S').source:match[[^@?(.*[\/])[^\/]-$]] .. 'clipboard_lib.lua')
lib.copy_item_property("D_POSITION", "Copy selected items positions to clipboard")
