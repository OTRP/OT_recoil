local Recoilmultiplier = 0.0
local maxmovementspeed = 69

Citizen.CreateThread(function()

    while true do

        if IsPedArmed(PlayerPedId(), 6) then
            Citizen.Wait(1)
        else
            Citizen.Wait(1500)
        end

        if IsPedShooting(PlayerPedId()) then
            local playerped = PlayerPedId()
            local GamePlayCam = GetFollowPedCamViewMode()
            local Vehicled = IsPedInAnyVehicle(playerped, false)
            local MovementSpeed = math.ceil(GetEntitySpeed(playerped))
            local k, wep = GetCurrentPedWeapon(playerped)
            local wepgroup = GetWeapontypeGroup(wep)
            local verticalpitch = GetGameplayCamRelativePitch()
            local cameraDistance = #(GetGameplayCamCoord() - GetEntityCoords(playerped))

            if MovementSpeed > maxmovementspeed then
                MovementSpeed = maxmovementspeed
            end

            local recoil = math.random(100, 140 + MovementSpeed) / 100
            local rifle = false

            if group == 970310034 then
                rifle = true
            end

            if cameraDistance < 5.3 then
                cameraDistance = 1.5
            else
                if cameraDistance < 8.0 then
                    cameraDistance = 4.0
                else
                    cameraDistance = 7.0
                end
            end

            if Vehicled then
                recoil = recoil + (recoil * cameraDistance)
            else
                recoil = recoil * 0.8
            end

            if GamePlayCam == 4 then

                recoil = recoil * 0.7
                if rifle then
                    recoil = recoil * 0.1
                end

            end

            if rifle then
                recoil = recoil * 0.7
            end

            local Xaxisvariation = math.random(4)
            local cameraHeading = GetGameplayCamRelativeHeading()
            local hf = math.random(10, 40 + MovementSpeed) / 100

            if Vehicled then
                hf = hf * 2.0

            end

            if Xaxisvariation == 1 then
                SetGameplayCamRelativeHeading(cameraHeading + hf)
            elseif Xaxisvariation == 2 then
                SetGameplayCamRelativeHeading(cameraHeading - hf)
            end

            local set = verticalpitch + recoil

            SetGameplayCamRelativePitch(set, 0.8)
        end
    end

end)
