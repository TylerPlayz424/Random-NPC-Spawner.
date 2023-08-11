local spawnedNPC = nil

-- List of NPC models that you can choose from
local npcModels = {
    "a_f_m_beach_01",
    "a_m_m_bevhills_01",
    "a_m_m_eastsa_01",
    -- Add more NPC model names here
}

RegisterCommand("spawnnpc", function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    local randomModel = npcModels[math.random(#npcModels)]

    RequestModel(randomModel)
    while not HasModelLoaded(randomModel) do
        Citizen.Wait(0)
    end

    if spawnedNPC ~= nil then
        DeleteEntity(spawnedNPC)
    end

    spawnedNPC = CreatePed(4, randomModel, playerCoords.x, playerCoords.y, playerCoords.z, 0.0, false, true)
    SetEntityAsMissionEntity(spawnedNPC, true, true)
    SetEntityHeading(spawnedNPC, GetEntityHeading(playerPed))
    TaskStandStill(spawnedNPC, -1)

    SetModelAsNoLongerNeeded(randomModel)
end, false)
