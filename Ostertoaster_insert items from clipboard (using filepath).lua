-- @description Insert items from clipboard (using filepath)
-- @author Ostertoaster
-- @version 1.0
-- @about
--   Inserts media items from comma-separated file paths in the clipboard.
--   Requires SWS extension.

-- for some reason the newline character seems to mess things up. 
-- if you separate all the paths in the clipboard with commas, it works
reaper.ClearConsole()

-- https://helloacm.com/split-a-string-in-lua/
function split(s, delimiter, preserve)
  local result = {}
  local i = 0
  for match in (s..delimiter):gmatch("(.-)"..delimiter) do
    if preserve and i > 0 then
      table.insert(result, delimiter .. match)
    else
      table.insert(result, match)
    end
    i = i + 1
  end
  return result
end

clipBoard = reaper.CF_GetClipboard()
filePaths = split(clipBoard, ",", false)

for f = 1, #filePaths do
  reaper.InsertMedia(filePaths[f], 1)
end


--reaper.InsertMedia("E:/Polyverse Dropbox/SampleMaking/Bass From Space/Samples (final)/04_BASSICK/2/SYN 120-17-49.wav", 1)




