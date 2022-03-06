--Please note this is for the QBCore Framework


-- add above ["smokeweed"] in scenarios dpemotes/client/AnimationList.lua
-- allows females to smoke a blunt

["weed"] = {"Scenario", "WORLD_HUMAN_SMOKING_POT", "Joint"},


--Replace for the UseJoint event in qb-smallresources/client/consumables
--Function to have 4 joints to gain full armour
--possibility to relieve stress from the joint effect function
--you need the lighter item to light the blunt

RegisterNetEvent('consumables:client:UseJoint', function()
    local playerPed = GetPlayerPed(-1)
    QBCore.Functions.TriggerCallback('QBCore:HasItem', function(item)
        if item then
            QBCore.Functions.Progressbar("smoke_joint", "Lighting a blunt..", 9500, false, true, {
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
            }, {}, {}, {}, function() -- Done
                TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["joint"], "remove")
                if IsPedInAnyVehicle(PlayerPedId(), false) then
                    TriggerEvent('animations:client:EmoteCommandStart', {"weed"})
                else
                    TriggerEvent('animations:client:EmoteCommandStart', {"weed"})
                end
                JointEffect()
                Armour(10,2.5)
                TriggerEvent("evidence:client:SetStatus", "weedsmell", 3000)
            end, function() -- Cancel
                QBCore.Functions.Notify("Canceled..", "error")
            end)
        else
            QBCore.Functions.Notify("You don't have a lighter", "error")
        end
    end, "lighter")
end)

function Armour(EffectTime, Multiplier)
    while EffectTime > 0 do
      Citizen.Wait(1000)
      EffectTime = EffectTime - 1
        local armor = GetPedArmour(PlayerPedId())
        SetPedArmour(PlayerPedId(), math.ceil(armor + Multiplier))
    end
    EffectTime = 0
end
