local plr = game:GetService("Players").LocalPlayer
local CameraShakerR = require(game.ReplicatedStorage.Util.CameraShaker)
local ShootGunEvent = game:GetService("ReplicatedStorage").Modules.Net["RE/ShootGunEvent"]

function getHead()
    local returntable = {}
    for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        if table.find(cl, v.Name) then
            if v:FindFirstChild("Body") then
                for i1, v1 in pairs(v.Body:GetChildren()) do
                    if (v1.Position - plr.Character.HumanoidRootPart.Position).Magnitude < 100 then
                        table.insert(returntable, v1)
                        return
                    end
                end
            end
        else
            if v:FindFirstChild("Humanoid") and v:FindFirstChild("Humanoid").Health > 0 then
                if (v.Head.Position - plr.Character.HumanoidRootPart.Position).Magnitude < 100 then
                    table.insert(returntable, v.HumanoidRootPart)
                end
            end
        end
    end
    if #returntable <= 0 then
        for i, v in pairs(game:GetService("Workspace").SeaBeasts:GetChildren()) do
            if v:FindFirstChild("RootPart") then
                if (v.RootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude < 500 then
                    table.insert(returntable, v.RootPart)
                end
            end
        end
    end
    return returntable
end

function FastShooted()
    local getHead = getHead()
    for i = 1, #getHead do
        if #getHead > 0 then
            pcall(function()
                local toolEquiped = plr.Character:FindFirstChildOfClass("Tool")
                if toolEquiped and toolEquiped.ToolTip == "Gun" then
                    ShootGunEvent:FireServer(Vector3.new(getHead[i].Position), { [1] = getHead[i] })
                    ShootGunEvent:FireServer(Vector3.new(getHead[i].Position), { [1] = getHead[i] })
                    sethiddenproperty(plr, "SimulationRadius", math.huge)
                end
            end)
        end
    end
end

function EquipGunAndShoot()
    -- Tìm và trang bị súng trong Backpack
    for i, v in pairs(plr.Backpack:GetChildren()) do
        if v.ToolTip == "Gun" then
            if plr.Backpack:FindFirstChild(tostring(v.Name)) then
                plr.Character.Humanoid:EquipTool(v) -- Trang bị súng
                break
            end
        end
    end
    -- Thực hiện bắn nhanh
    FastShooted()
end