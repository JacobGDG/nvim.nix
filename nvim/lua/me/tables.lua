local M = {}

M.merge = function(...)
  local result = {}
  -- For each source table
  for _, t in ipairs { ... } do
    -- For each pair in t
    for k, v in pairs(t) do
      result[k] = v
    end
  end
  return result
end

return M
