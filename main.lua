repeat task.wait() until game:IsLoaded()

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source"))()

local Window = Rayfield:CreateWindow({
   Name = "Anti-Lag Mobile Δ",
   Icon = 0,
   LoadingTitle = "Anti-Lag Delta",
   LoadingSubtitle = "Carregando Interface...",
   ShowText = "Anti-Lag",
   Theme = "Default",
   ToggleUIKeybind = "K",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,

   ConfigurationSaving = {
      Enabled = true,
      FolderName = "AntiLagDelta",
      FileName = "Config"
   },

   Discord = { Enabled = false },
   KeySystem = false
})

local Tab = Window:CreateTab("🔥 Anti-Lag", 4483362458)

-- Funções
local function MaxAntiLag()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    local l = game:GetService("Lighting")
    l.GlobalShadows = false
    l.FogEnd = 999999
    l.Brightness = 1
    l.Technology = Enum.Technology.Compatibility
    
    for _, v in pairs(l:GetChildren()) do
        if v:IsA("PostEffect") then v.Enabled = false end
    end
    
    local t = workspace:FindFirstChildOfClass("Terrain")
    if t then
        t.WaterWaveSize = 0
        t.WaterWaveSpeed = 0
        t.WaterReflectance = 0
        t.WaterTransparency = 1
    end
end

local function Plastic(state)
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and not v:IsA("Terrain") then
            if state then
                v.Material = Enum.Material.Plastic
                v.Color = Color3.fromRGB(163,162,165)
            end
        end
    end
end

local function ClearVisuals()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") or v:IsA("Smoke") or 
           v:IsA("Fire") or v:IsA("Sparkles") or v:IsA("Decal") or v:IsA("Texture") then
            pcall(function() v:Destroy() end)
        end
    end
end

-- Interface
Tab:CreateButton({
    Name = "🔥 Anti-Lag Máximo (Recomendado)",
    Callback = function()
        MaxAntiLag()
        Plastic(true)
        ClearVisuals()
        Rayfield:Notify({Title = "Sucesso", Content = "Anti-Lag Máximo Aplicado!", Duration = 4})
    end
})

Tab:CreateToggle({
    Name = "Modo Plástico (Muito FPS)",
    CurrentValue = true,
    Callback = function(v) Plastic(v) end
})

Tab:CreateToggle({
    Name = "Limpeza Automática",
    CurrentValue = true,
    Callback = function(v)
        getgenv().AutoClean = v
        if v then
            task.spawn(function()
                while getgenv().AutoClean do
                    ClearVisuals()
                    task.wait(3.5)
                end
            end)
        end
    end
})

Tab:CreateToggle({
    Name = "Desativar Sombras e Post Effects",
    CurrentValue = true,
    Callback = function(v)
        game:GetService("Lighting").GlobalShadows = not v
        for _, obj in pairs(game:GetService("Lighting"):GetChildren()) do
            if obj:IsA("PostEffect") then obj.Enabled = not v end
        end
    end
})

Tab:CreateButton({
    Name = "Limpar Efeitos Agora",
    Callback = function() ClearVisuals() end
})

Tab:CreateSlider({
    Name = "Distância de Render (Fog)",
    Range = {50, 500},
    Increment = 25,
    CurrentValue = 150,
    Callback = function(v)
        game:GetService("Lighting").FogEnd = v
    end
})

Rayfield:Notify({Title = "Rayfield Carregado", Content = "Use o botão Anti-Lag Máximo primeiro", Duration = 6})
