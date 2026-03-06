-- Shared clipboard utilities for Ostertoaster Clipboard Actions
local lib = {}

function lib.split_str(s, delimiter)
  local result = {}
  for match in (s..delimiter):gmatch('(.-)'..delimiter) do
    table.insert(result, match)
  end
  return result
end

-- Copy a simple item property (D_POSITION, D_LENGTH, D_VOL, D_FADEINLEN, D_FADEOUTLEN, D_SNAPOFFSET)
function lib.copy_item_property(key, script_name)
  reaper.Undo_BeginBlock()
  local str = ""
  for i = 0, reaper.CountSelectedMediaItems(-1) - 1 do
    local item = reaper.GetSelectedMediaItem(-1, i)
    str = str .. reaper.GetMediaItemInfo_Value(item, key) .. "\n"
  end
  reaper.CF_SetClipboard(str)
  reaper.Undo_EndBlock(script_name, -1)
end

-- Copy a take-level property (D_PAN, etc.)
function lib.copy_take_property(key, script_name)
  reaper.Undo_BeginBlock()
  local str = ""
  for i = 0, reaper.CountSelectedMediaItems(-1) - 1 do
    local item = reaper.GetSelectedMediaItem(-1, i)
    local take = reaper.GetActiveTake(item)
    str = str .. reaper.GetMediaItemTakeInfo_Value(take, key) .. "\n"
  end
  reaper.CF_SetClipboard(str)
  reaper.Undo_EndBlock(script_name, -1)
end

-- Copy take names (uses GetSetMediaItemTakeInfo_String)
function lib.copy_take_names(script_name)
  reaper.Undo_BeginBlock()
  local str = ""
  for i = 0, reaper.CountSelectedMediaItems(-1) - 1 do
    local item = reaper.GetSelectedMediaItem(-1, i)
    local take = reaper.GetActiveTake(item)
    local _, name = reaper.GetSetMediaItemTakeInfo_String(take, "P_NAME", "", 0)
    str = str .. name .. "\n"
  end
  reaper.CF_SetClipboard(str)
  reaper.Undo_EndBlock(script_name, -1)
end

-- Paste a simple item property from clipboard
function lib.paste_item_property(key, script_name)
  reaper.Undo_BeginBlock()
  local lines = lib.split_str(reaper.CF_GetClipboard(), "\n")
  for i = 0, reaper.CountSelectedMediaItems(0) - 1 do
    local item = reaper.GetSelectedMediaItem(0, i)
    local val = tonumber(lines[(i % #lines) + 1])
    if val ~= nil then
      reaper.SetMediaItemInfo_Value(item, key, val)
    end
  end
  reaper.Undo_EndBlock(script_name, 0)
end

-- Paste a take-level property from clipboard
function lib.paste_take_property(key, script_name)
  reaper.Undo_BeginBlock()
  local lines = lib.split_str(reaper.CF_GetClipboard(), "\n")
  for i = 0, reaper.CountSelectedMediaItems(0) - 1 do
    local item = reaper.GetSelectedMediaItem(0, i)
    local take = reaper.GetActiveTake(item)
    local val = tonumber(lines[(i % #lines) + 1])
    if val ~= nil then
      reaper.SetMediaItemTakeInfo_Value(take, key, val)
    end
  end
  reaper.Undo_EndBlock(script_name, 0)
end

return lib
