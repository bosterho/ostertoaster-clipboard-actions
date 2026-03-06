-- @description Copy take sources to clipboard
-- @author Ostertoaster
-- @version 1.0
-- @about
--   Copies the source file paths of all selected items to the clipboard. Handles reversed takes.
--   Requires SWS extension.

-- Taken from Claudiohbsantos' script, "CS_Export item source list to clipboard.lua"
-- THIS DOESN'T WORK ON ITEMS THAT ARE LOOPED
reaper.ClearConsole()
local filelist = {}
num_files = 0
for i = 0, reaper.CountSelectedMediaItems(0) - 1 do
  item = reaper.GetSelectedMediaItem(0, i)
  take = reaper.GetActiveTake(item)
  if not take then break end
   
  -- GetMediaSourceFileName doesn't work for reversed takes, so we make it forward before getting the filename, if needed
  retval, boolean, start, length, fade, reverse = reaper.BR_GetMediaSourceProperties(take)
  if reverse == true then 
    retval = reaper.BR_SetMediaSourceProperties(take, false, start, length, fade, false)
  end
  source = reaper.GetMediaItemTake_Source(take)
  sourceName = reaper.GetMediaSourceFileName(source)
  -- reaper.ShowConsoleMsg("source name: " .. sourceName .. "\n")
  if reverse == true then
    retval = reaper.BR_SetMediaSourceProperties(take, false, start, length, fade, true)
  end

  if sourceName and sourceName ~= "" then
    table.insert(filelist,sourceName)
    num_files = num_files + 1
  end
end 
if num_files > 0 then reaper.CF_SetClipboard(table.concat(filelist,"\n")) end
