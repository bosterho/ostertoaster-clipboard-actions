-- @description Copy selected items names to clipboard (multiline)
-- @author Ostertoaster
-- @version 1.2
-- @provides clipboard_lib.lua
-- @about
--   Copies the take names of all selected media items to the system clipboard, one per line.
--   Requires SWS extension.

local lib = dofile(debug.getinfo(1, 'S').source:match[[^@?(.*[\/])[^\/]-$]] .. 'clipboard_lib.lua')
lib.copy_take_names("Copy selected items names to clipboard")
