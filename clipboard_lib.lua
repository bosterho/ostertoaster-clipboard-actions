-- Shared clipboard utilities for Ostertoaster Clipboard Actions
local lib = {}

function lib.split_str(s, delimiter)
  local result = {}
  for match in (s..delimiter):gmatch('(.-)'..delimiter) do
    table.insert(result, match)
  end
  return result
end

-- Get clipboard lines, filtering out empty trailing entries
function lib.get_clipboard_lines(delimiter)
  delimiter = delimiter or "\n"
  local raw = lib.split_str(reaper.CF_GetClipboard(), delimiter)
  local lines = {}
  for _, v in ipairs(raw) do
    local trimmed = v:gsub("[\n\r]", "")
    if trimmed ~= "" then
      table.insert(lines, trimmed)
    end
  end
  return lines
end

-- Log a warning if clipboard line count doesn't match target count
function lib.log_mismatch(clipboard_count, target_count, script_name)
  if clipboard_count ~= target_count then
    reaper.ShowConsoleMsg(script_name .. ": clipboard has " .. clipboard_count
      .. " values, but " .. target_count .. " items are selected.")
    if target_count > clipboard_count then
      reaper.ShowConsoleMsg(" Values will repeat (wrapping).")
    else
      reaper.ShowConsoleMsg(" Only the first " .. target_count .. " values will be used.")
    end
    reaper.ShowConsoleMsg("\n")
  end
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
  local lines = lib.get_clipboard_lines()
  if #lines == 0 then
    reaper.ShowConsoleMsg(script_name .. ": clipboard is empty.\n")
    reaper.Undo_EndBlock(script_name, -1)
    return
  end
  local num_items = reaper.CountSelectedMediaItems(0)
  lib.log_mismatch(#lines, num_items, script_name)
  for i = 0, num_items - 1 do
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
  local lines = lib.get_clipboard_lines()
  if #lines == 0 then
    reaper.ShowConsoleMsg(script_name .. ": clipboard is empty.\n")
    reaper.Undo_EndBlock(script_name, -1)
    return
  end
  local num_items = reaper.CountSelectedMediaItems(0)
  lib.log_mismatch(#lines, num_items, script_name)
  for i = 0, num_items - 1 do
    local item = reaper.GetSelectedMediaItem(0, i)
    local take = reaper.GetActiveTake(item)
    local val = tonumber(lines[(i % #lines) + 1])
    if val ~= nil then
      reaper.SetMediaItemTakeInfo_Value(take, key, val)
    end
  end
  reaper.Undo_EndBlock(script_name, 0)
end

-- Paste take names from clipboard
function lib.paste_take_names(script_name)
  reaper.Undo_BeginBlock()
  local lines = lib.get_clipboard_lines()
  if #lines == 0 then
    reaper.ShowConsoleMsg(script_name .. ": clipboard is empty.\n")
    reaper.Undo_EndBlock(script_name, -1)
    return
  end
  local num_items = reaper.CountSelectedMediaItems(0)
  lib.log_mismatch(#lines, num_items, script_name)
  for i = 0, num_items - 1 do
    local item = reaper.GetSelectedMediaItem(0, i)
    local take = reaper.GetActiveTake(item)
    local name = lines[(i % #lines) + 1]
    reaper.GetSetMediaItemTakeInfo_String(take, "P_NAME", name, true)
  end
  reaper.Undo_EndBlock(script_name, 0)
end

return lib
