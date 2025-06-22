local task = require_shared("task")
local signal = {}

local signalmeta = {}
signalmeta.__index = signalmeta

function signal.new()
    local self = {}
    self.connections = {}

    return setmetatable(self, signalmeta)
end

function signalmeta:Connect(f)
    table.insert(self.connections, {func = f})
    local pos = #self.connections
    local connection_self = self
    return {
        Disconnect = function()
            if not pos then return end
            connection_self.connections[pos] = nil
            pos = nil
        end
    }
end

function signalmeta:ConnectOnce(f)
    table.insert(self.connections, {func = f, once = true})
    local pos = #self.connections
    local connection_self = self
    return {
        Disconnect = function()
            if not pos then return end
            connection_self.connections[pos] = nil
            pos = nil
        end
    }
end

function signalmeta:Fire(...)
    for i, v in pairs(self.connections) do
        task.spawn(v.func, ...)

        if v.once then
            self.connections[i] = nil
        end
    end
end

return signal
