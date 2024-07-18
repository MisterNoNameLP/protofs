--[[
    UT Copyright (C) 2019-2020 MisterNoNameLP.
	
    This library is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this library.  If not, see <https://www.gnu.org/licenses/>.
]]

--[[UsefullThings libary
	
]]
local UT = {version = "v0.9"}

function UT.getVersion()
	return UT.version
end

function UT.parseArgs(...) --returns the first non nil parameter.
	for _, a in pairs({...}) do
		if a ~= nil then
			return a
		end
	end
end

function UT.seperatePath(path) --seperates a data path ["./DIR/FILE.ENDING"] into the dir path ["./DIR/"], the file name ["FILE"], and the file ending [".ENDING" or nil]
	if string.sub(path, #path) == "/" then
		return path
	end
	
	local dir, fileName, fileEnd = "", "", nil
	local tmpLatest = ""
	for s in string.gmatch(tostring(path), "[^/]+") do
		tmpLatest = s
	end
	dir = string.sub(path, 0, #path -#tmpLatest)
	for s in string.gmatch(tostring(tmpLatest), "[^.]+") do
		fileName = fileName .. s
		tmpLatest = s
	end
	if fileName == tmpLatest then
		fileName = tmpLatest
	else
		fileEnd = "." .. tmpLatest
		fileName = string.sub(fileName, 0, #fileName - #fileEnd +1)
	end
	
	return dir, fileName, fileEnd
end

function UT.getChars(s) --returns a array with the chars of the string.
	local chars = {}
	for c = 1, #s do
		chars[c] = string.sub(s, c, c)
	end
	return chars
end

function UT.makeString(c) --genetares a string from and array of chars/strings.
	local s = ""
	for c, v in ipairs(c) do
		s = s ..v
	end
	return s
end

function UT.inputCheck(m, c) --checks if a array (m) contains a value (c).
	for _, v in pairs(m) do
		if v == c then
			return true
		end
	end
	return false
end

function UT.fillString(s, amout, c) --fills a string (s) up with a (amout) of chars/strings (c).
	local s2 = s
	for c2 = 1, amout, 1 do
		s2 = s2 .. c
	end
	return s2
end

--[[Converts a table or an other variable type to a readable stirng.
	This is a modified "Universal tostring" routine from "lua-users.org".
	Original source code: <http://lua-users.org/wiki/TableSerialization>
]]
function UT.tostring(var, lineBreak, indent, serialize, done, internalRun) 
	if internalRun == false or internalRun == nil then
		if type(var) == "table" then
			UT.tostring(var, lineBreak, indent, serialize, done, true)
		else
			return tostring(var)
		end
	end
	
	done = done or {}
	indent = indent or 2
	local lbString
	if lineBreak or lineBreak == nil then
		lbString = "\n"
		lineBreak = true
	else
		lbString = " "
	end
	if type(var) == "table" then
		local sb = {}
		if not internalRun then
			table.insert(sb, "{" .. lbString)
		end
		for key, value in pairs (var) do
			if lineBreak then
				table.insert(sb, string.rep (" ", indent)) -- indent it
			end
			if type (value) == "table" and not done [value] then
				done [value] = true
				if type(key) == "string" then
					key = "'" .. key .. "'"
				end
				if lineBreak then
					table.insert(sb, "[" .. tostring(key) .. "] = {" .. lbString);
				else
					table.insert(sb, "[" .. tostring(key) .. "] = {");
				end
				table.insert(sb, UT.tostring(value, lineBreak, indent + 2, serialize, done, true))
				if lineBreak then
					table.insert(sb, string.rep (" ", indent)) -- indent it
					table.insert(sb, "}," .. lbString);
				else
					table.insert(sb, "},");
				end
			elseif "number" == type(key) then
				table.insert(sb, string.format("[%s] = ", tostring(key)))
				if type(value) ~= "boolean" and type(value) ~= "number" then
					table.insert(sb, string.format("\"%s\"," .. lbString, tostring(value)))
				else
					table.insert(sb, string.format("%s," .. lbString, tostring(value)))
				end
			else
				if sb[#sb] == "}," then
					table.insert(sb, " ")
				end
				if type(key) == "string" then
					key = "'" .. key .. "'"
				end
				if type(value) ~= "boolean" and type(value) ~= "number" then
					if serialize then
						value = value:gsub("\n", "\\n")
					end
					table.insert(sb, string.format("%s = \"%s\"," .. lbString, "[" .. tostring (key) .. "]", tostring(value)))
					
				else
					table.insert(sb, string.format("%s = %s," .. lbString, "[" .. tostring (key) .. "]", tostring(value)))
				end
			end
		end
		if not internalRun then
			if sb[#sb] == "}," then
				table.insert(sb, " }")
			else
				table.insert(sb, "}")
			end
		end
		return table.concat(sb)
	else
		return var .. lbString
	end
end

function UT.readFile(path)
	local file, err = io.open(path, "rb")
	
	if file == nil then 
		return nil, err 
	else
		local fileContent = file:read("*all")
		file:close()
		return fileContent
	end
end

function UT.randomString(length, charset)
    local randomTable = {}
    local charset = charset or "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
    math.randomseed(os.clock() * 1000000)

	if not length or length <= 0 then
		return ""
	end

    for i = 1, length do
        local randomNumber = math.random(1, #charset)
        local randomChar = string.sub(charset, randomNumber, randomNumber)

        table.insert(randomTable, randomChar)
    end

    return table.concat(randomTable)
end

function UT.exec(command)
	local outputStream = io.popen(command)
	local outputString = outputStream:read("*a"):sub(0, -2)
	outputStream:close()
	return outputString
end

return UT