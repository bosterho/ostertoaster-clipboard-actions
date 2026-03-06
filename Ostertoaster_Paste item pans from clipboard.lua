-- @description Paste item pans from clipboard
-- @author Ostertoaster
-- @version 1.2
-- @provides clipboard_lib.lua
-- @about
--   Pastes pan values from clipboard (one per line) onto selected items' active takes.
--   Requires SWS extension.

local lib = dofile(debug.getinfo(1, 'S').source:match[[^@?(.*[\/])[^\/]-$]] .. 'clipboard_lib.lua')
lib.paste_take_property("D_PAN", "Paste item pans from clipboard")
