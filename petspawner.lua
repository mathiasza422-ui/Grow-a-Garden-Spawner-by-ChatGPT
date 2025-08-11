local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local SpawnPetEvent = ReplicatedStorage:WaitForChild("SpawnPet")
local player = Players.LocalPlayer

local petsToSpawn = {
    "Raccoon",
    "RedFox",
    "QueenBee",
    "Dragonfly"
}

local spawnEnabled = false

local function createGUI()
    local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
    screenGui.Name = "PetSpawnerGUI"

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 250, 0, 150)
    frame.Position = UDim2.new(0.5, -125, 0.5, -75)
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    frame.BackgroundTransparency = 0.1
    frame.Parent = screenGui
    frame.Active = true
    frame.Draggable = true

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "Pet Spawner"
    title.TextColor3 = Color3.fromRGB(180, 180, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.Parent = frame

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 100, 0, 40)
    toggleBtn.Position = UDim2.new(0.5, -50, 1, -50)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 100)
    toggleBtn.TextColor3 = Color3.fromRGB(220, 220, 255)
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.TextSize = 18
    toggleBtn.Text = "Start Spawning"
    toggleBtn.Parent = frame

    toggleBtn.MouseButton1Click:Connect(function()
        spawnEnabled = not spawnEnabled
        if spawnEnabled then
            toggleBtn.Text = "Stop Spawning"
        else
            toggleBtn.Text = "Start Spawning"
        end
    end)
end

createGUI()

spawn(function()
    while true do
        if spawnEnabled then
            for _, petName in ipairs(petsToSpawn) do
                SpawnPetEvent:FireServer(petName)
                wait(0.5)
            end
        end
        wait(1)
    end
end)
