local modDir = g_currentModDirectory
local modName = g_currentModDirectory or "unknown"

source(modDir .. "src/SowingMachineDirectPlantingEvent.lua")

g_specializationManager:addSpecialization("directDrillAddon", "DirectDrillAddon", Utils.getFilename("src/DirectDrillAddon.lua", modDir), nil)

local function init()
    for vehicleName, vehicleType in pairs(g_vehicleTypeManager.types) do
        if SpecializationUtil.hasSpecialization(SowingMachine, vehicleType.specializations) then
            g_vehicleTypeManager:addSpecialization(vehicleName, "directDrillAddon")
        end
    end
end

init()
