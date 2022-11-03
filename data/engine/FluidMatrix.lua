local args = ...

local FluidMatrix = {}
local FluidCell = args.FluidCell

--===== class functions =====--
function FluidMatrix.getNewCell(cellValues)
    local cell = setmetatable({
        substance = 0, 
        amount = 0,
        gotModified = false,
        flowSpeed = {0, 0, 0, 0, 0, 0, 0, 0}
    }, {__index = FluidCell})
    
    if type(cellValues) ~= "table" then
        cellValues = {}
    end

    for i, v in pairs(cellValues) do
        cell[i] = v
    end

    return cell
end

function FluidMatrix.new(sizeX, sizeY)
    local self = setmetatable({}, {__index = FluidMatrix})

    self.sizeX, self.sizeY = sizeX, sizeY

    self.matrix1, self.matrix2 = {}, {}
    self.currentMatrix, self.otherMatrix = self.matrix1, self.matrix2

    for x = 1, sizeY do
        self.matrix1[x] = {}
        self.matrix2[x] = {}
        for y = 1, sizeY do
            self.matrix1[x][y] = FluidMatrix.getNewCell()
            self.matrix2[x][y] = FluidMatrix.getNewCell()
        end

        --[[
        self.matrix[x] = {}
        for y = 1, sizeY do
            self.matrix[x][y] = FluidCell.new()
        end
        ]]
    end

    self.currentMatrix = self.matrix1

    return self
end

--===== object functions =====--
function FluidMatrix:update(dt)
    if self.currentMatrix == self.matrix1 then
        self.currentMatrix = self.matrix2
        self.otherMatrix = self.matrix1
    else
        self.currentMatrix = self.matrix1
        self.otherMatrix = self.matrix2
    end

    local currentMatrix = self.currentMatrix

    for x = 1, self.sizeX do
        for y = 1, self.sizeY do
            currentMatrix[x][y]:update(self.otherMatrix)
        end
    end
end

function FluidMatrix:draw(offsetX, offsetY, scale, gab)
    local currentMatrix = self.currentMatrix

    for x = 1, self.sizeX do
        for y = 1, self.sizeY do
            currentMatrix[x][y]:draw(x, y, offsetX, offsetY, scale, gab)
        end
    end
end

function FluidMatrix:setCell(x, y, cell)
    self.otherMatrix[x][y] = cell
end

return FluidMatrix