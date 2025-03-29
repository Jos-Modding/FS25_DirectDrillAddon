SowingMachineDirectPlantingEvent = {}
local SowingMachineDirectPlantingEvent_mt = Class(SowingMachineDirectPlantingEvent, Event)

function SowingMachineDirectPlantingEvent.emptyNew()
    return Event.new(SowingMachineDirectPlantingEvent_mt)
end

function SowingMachineDirectPlantingEvent.new(object, useDirectPlanting)
    local self = SowingMachineDirectPlantingEvent.emptyNew()

    self.object = object
    self.useDirectPlanting = useDirectPlanting

    return self
end

function SowingMachineDirectPlantingEvent:readStream(streamId, connection)
    self.object = NetworkUtil.readNodeObject(streamId)
    self.useDirectPlanting = streamReadBool(streamId)
    self:run(connection)
end

function SowingMachineDirectPlantingEvent:writeStream(streamId, connection)
    NetworkUtil.writeNodeObject(streamId, self.object)
    streamWriteBool(streamId, self.useDirectPlanting)
end

function SowingMachineDirectPlantingEvent:run(connection)
    if not connection:getIsServer() then
        g_server:broadcastEvent(self, false, connection, self.object)
    end

    if self.object ~= nil and self.object:getIsSynchronized() then
        self.object:toggleDirectDrilling(self.useDirectPlanting, true)
    end
end

function SowingMachineDirectPlantingEvent.sendEvent(object, useDirectPlanting, noEventSend)
    if noEventSend == nil or noEventSend == false then
        if g_server ~= nil then
            g_server:broadcastEvent(SowingMachineDirectPlantingEvent.new(object, useDirectPlanting), nil, nil, object)
            return
        end

        g_client:getServerConnection():sendEvent(SowingMachineDirectPlantingEvent.new(object, useDirectPlanting))
    end
end
