DirectDrillAddon = {}

function DirectDrillAddon.prerequisitesPresent(specializations)
    return SpecializationUtil.hasSpecialization(SowingMachine, specializations)
end

function DirectDrillAddon.registerFunctions(vehicleType)
    SpecializationUtil.registerFunction(vehicleType, "toggleDirectDrilling", DirectDrillAddon.toggleDirectDrilling)
end

function DirectDrillAddon.registerEventListeners(vehicleType)
    SpecializationUtil.registerEventListener(vehicleType, "onLoad", DirectDrillAddon)
    SpecializationUtil.registerEventListener(vehicleType, "onRegisterActionEvents", DirectDrillAddon)
end

function DirectDrillAddon:onLoad()
    local spec = self.spec_sowingMachine
    spec.text_directPlantingPos = g_i18n:getText("action_toggleDirectPlantingPos")
    spec.text_directPlantingNeg = g_i18n:getText("action_toggleDirectPlantingNeg")
end

function DirectDrillAddon:onRegisterActionEvents(isActiveForInput, isActiveForInputIgnoreSelection)
    if self.isClient then
        local spec = self.spec_sowingMachine

        if isActiveForInputIgnoreSelection then
            local _, actionEventId = self:addActionEvent(spec.actionEvents, InputAction.TOGGLE_DIRECT_DRILLING, self, DirectDrillAddon.actionEventToggleDirectDrilling, false, true, false, true, nil)
            g_inputBinding:setActionEventText(actionEventId, spec.useDirectPlanting and spec.text_directPlantingNeg or spec.text_directPlantingPos)
            g_inputBinding:setActionEventTextPriority(actionEventId, GS_PRIO_NORMAL)
        end
    end
end

function DirectDrillAddon:actionEventToggleDirectDrilling(...)
    self:toggleDirectDrilling()
end

function DirectDrillAddon:toggleDirectDrilling(state, noEventSend)
    local spec = self.spec_sowingMachine

    if state == nil then
        state = not spec.useDirectPlanting
    end

    spec.useDirectPlanting = state
    self:requestActionEventUpdate()
    SowingMachineDirectPlantingEvent.sendEvent(self, state, noEventSend)
end
