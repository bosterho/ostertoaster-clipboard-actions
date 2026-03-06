-- @description Copy selected items pans to clipboard (multiline)
-- @author Ostertoaster
-- @version 1.2
-- @provides clipboard_lib.lua
-- @about
--   Copies the pan value of all selected media item takes to the clipboard, one per line.
--   Requires SWS extension.

local lib = dofile(debug.getinfo(1, 'S').source:match[[^@?(.*[\/])[^\/]-$]] .. 'clipboard_lib.lua')
lib.copy_take_property("D_PAN", "Copy selected items pans to clipboard")
