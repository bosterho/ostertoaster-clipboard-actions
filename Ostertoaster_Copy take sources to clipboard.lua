-- @description Copy take sources to clipboard
-- @author Ostertoaster
-- @version 1.1
-- @about
--   Copies the source file paths of all selected items to the clipboard. Handles reversed takes.
--   Does not work on looped items. Requires SWS extension.

local filelist = {}
for i = 0, reaper.CountSelectedMediaItems(0) - 1 do
  local item = reaper.GetSelectedMediaItem(0, i)
  local take = reaper.GetActiveTake(item)
  if not take then break end

  local retval, boolean, start, length, fade, reverse = reaper.BR_GetMediaSourceProperties(take)
  if reverse then
    reaper.BR_SetMediaSourceProperties(take, false, start, length, fade, false)
  end
  local source = reaper.GetMediaItemTake_Source(take)
  local sourceName = reaper.GetMediaSourceFileName(source)
  if reverse then
    reaper.BR_SetMediaSourceProperties(take, false, start, length, fade, true)
  end

  if sourceName and sourceName ~= "" then
    table.insert(filelist, sourceName)
  end
end
if #filelist > 0 then reaper.CF_SetClipboard(table.concat(filelist, "\n")) end
