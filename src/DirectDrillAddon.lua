DirectDrillAddon = {}

function DirectDrillAddon.prerequisitesPresent(specializations)
    return SpecializationUtil.hasSpecialization(SowingMachine, specializations)
end

function DirectDrillAddon.registerEventListeners(vehicleType)
    SpecializationUtil.registerEventListener(vehicleType, "onLoadFinished", DirectDrillAddon)
end

function DirectDrillAddon:onLoadFinished()
    if self.spec_sowingMachine then
        self.spec_sowingMachine.useDirectPlanting = true
    end
end
