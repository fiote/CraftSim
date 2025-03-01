 _, CraftSim = ...

 
 ---@class CraftSim.JSONBuilder
 CraftSim.JSONBuilder = CraftSim.Object:extend()
 
 ---@param indent number?
 function CraftSim.JSONBuilder:new(indent)
    self.indent = indent or 0
    self.json = ""
 end

function CraftSim.JSONBuilder:Begin()
   self.json = self:GetIndent() .. "{\n"
end

function CraftSim.JSONBuilder:End(sep)
   sep = sep or ""
   self.json = self.json .. "\n" .. self:GetIndent() .. "}" .. sep
end

---@return string indentSpaces
function CraftSim.JSONBuilder:GetIndent(extra)
   extra = extra or 0
   local int = self.indent + extra
   local spaces = ""
   for i = 1, int, 1 do
      spaces = spaces .. " "
   end
   return spaces
end

function CraftSim.JSONBuilder:AddList(name, list, last)
      local sep = (not last and ",\n") or ""
      local jsonList = self:GetIndent(1) .. "\"" .. name .. "\": [\n"
  
      for index, listItem in pairs(list) do
          local subSep = (index == #list and "") or ",\n"
          if type(listItem) == 'table' and listItem.GetJSON then
              jsonList = jsonList .. self:GetIndent(2) .. listItem:GetJSON(self.indent + 3) .. subSep
          else
               local strEncase = (type(listItem) == 'string' and "\"") or ""
              jsonList = jsonList .. self:GetIndent(2) .. strEncase .. tostring(listItem) .. strEncase ..subSep
          end
      end
  
      jsonList = jsonList .. "\n" .. self:GetIndent(1) .. "]" .. sep
  
      self.json = self.json .. jsonList
end

function CraftSim.JSONBuilder:Add(name, data, last)
   local strEncase = (type(data) == 'string' and "\"") or ""
   local sep = (not last and ",\n") or ""
   if type(data) == 'table' and data.GetJSON then
      self.json = self.json .. self:GetIndent(1) .. "\"" .. name .. "\": " .. strEncase .. data:GetJSON(self.indent + 1) .. strEncase .. sep
   elseif type(data) == 'table' then
      self.json = self.json .. self:GetIndent(1) .. "\"" .. name .. '\": {\n'
      for key, value in pairs(data) do
         local strEncase = (type(value) == 'string' and "\"") or ""
         local valueText = (type(value) == 'table' and 'Table') or tostring(value)
         self.json = self.json .. self:GetIndent(3) .. "\"" .. key .. "\": " .. strEncase .. valueText .. strEncase .. sep
      end
      self.json = self.json .. self:GetIndent(2) .. ' }' .. sep

   else
      self.json = self.json .. self:GetIndent(1) .. "\"" .. name .. "\": " .. strEncase .. tostring(data) .. strEncase .. sep
   end
end
