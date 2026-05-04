-- // Anti-Lag Mobile Rayfield - Delta Executor
-- // Versão Raw - Otimizada para Mobile

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Anti-Lag Δ Mobile",
    LoadingTitle = "Anti-Lag Mobile",
    LoadingSubtitle = "Carregando...",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "AntiLagDelta",
        FileName = "Config"
    }
})

local Tab = Window:CreateTab("Principal", 4483362458)

-- Funções Anti-Lag
local function MaxAntiLag()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    settings().Network.IncomingReplicationLag = 0
    
    local Lighting = game:GetService("Lighting")
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 999999
    Lighting.Brightness = 1
    Lighting.ClockTime = 12
    Lighting.Technology = Enum.Technology.Compatibility
    
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect") then
            v.Enabled = false
        end
    end
    
    local Terrain = workspace:FindFirstChildOfClass("Terrain")
    if Terrain then
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 1
    end
end

local function PlasticMode(state)
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and not v:IsA("Terrain") then
            if state then
                v.Material = Enum.Material.Plastic
                v.Color = Color3.fromRGB(140, 140, 140)
                pcall(function() if v:FindFirstChild("Mesh") then v.Mesh:Destroy() end end)
            end
        end
    end
end

local function ClearVisuals()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") or v:IsA("Smoke") or 
           v:IsA("Fire") or v:IsA("Sparkles") or v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        end
    end
end

-- Interface
Tab:CreateButton({
    Name = "🔥 Aplicar Anti-Lag Máximo",
    Callback = function()
        MaxAntiLag()
        PlasticMode(true)
        ClearVisuals()
        Rayfield:Notify("Anti-Lag Máximo Ativado", "Lag reduzido ao máximo possível no mobile", 4483362458)
    end
})

Tab:CreateToggle({
    Name = "Modo Plástico (Muito Forte)",
    CurrentValue = true,
    Callback = function(Value)
        PlasticMode(Value)
    end
})

Tab:CreateToggle({
    Name = "Limpeza Automática",
    CurrentValue = true,
    Callback = function(Value)
        getgenv().AutoClean = Value
        while getgenv().AutoClean do
            ClearVisuals()
            task.wait(3.5)
        end
    end
})

Tab:CreateToggle({
    Name = "Desativar Sombras e Efeitos",
    CurrentValue = true,
    Callback = function(Value)
        game:GetService("Lighting").GlobalShadows = not Value
        for _, v in pairs(game:GetService("Lighting"):GetChildren()) do
            if v:IsA("PostEffect") then
                v.Enabled = not Value
            end
        end
    end
})

Tab:CreateButton({
    Name = "Limpar Efeitos Agora",
    Callback = function()
        ClearVisuals()
        Rayfield:Notify("Limpeza Concluída", "Todos efeitos visuais removidos", 4483362458)
    end
})

Tab:CreateSlider({
    Name = "Distância de Render (Fog)",
    Range = {50, 400},
    Increment = 25,
    CurrentValue = 150,
    Callback = function(Value)
        game:GetService("Lighting").FogEnd = Value
    end
})

Rayfield:Notify("Script Carregado com Sucesso", "Clique em 'Anti-Lag Máximo' para melhor desempenho", 4483362458)
