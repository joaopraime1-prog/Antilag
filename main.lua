repeat task.wait() until game:IsLoaded()

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Anti-Lag Mobile Δ",
   Icon = 0,
   LoadingTitle = "Anti-Lag Interface",
   LoadingSubtitle = "by Delta Mobile",
   ShowText = "Anti-Lag",
   Theme = "Default",

   ToggleUIKeybind = "K",

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,

   ConfigurationSaving = {
      Enabled = true,
      FolderName = "AntiLagDelta",
      FileName = "ConfigMobile"
   },

   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },

   KeySystem = false,
   KeySettings = {
      Title = "Anti-Lag",
      Subtitle = "Key System",
      Note = "Sem sistema de key ativado",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"antilag2025"}
   }
})

-- ============ TABS ============ --
local TabPrincipal = Window:CreateTab("🔥 Anti-Lag", 4483362458)
local TabExtra = Window:CreateTab("⚙️ Extra", 4483362458)

-- ============ FUNÇÕES ============ --
local function MaxAntiLag()
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    end)

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
            pcall(function()
                if state then
                    v.Material = Enum.Material.Plastic
                    v.Color = Color3.fromRGB(163, 162, 165)
                end
            end)
        end
    end
end

local function ClearVisuals()
    for _, v in pairs(workspace:GetDescendants()) do
        pcall(function()
            if v:IsA("ParticleEmitter") or
               v:IsA("Trail") or
               v:IsA("Beam") or
               v:IsA("Smoke") or
               v:IsA("Fire") or
               v:IsA("Sparkles") or
               v:IsA("Decal") or
               v:IsA("Texture") then
                v:Destroy()
            end
        end)
    end
end

local function DesativarSombras(state)
    game:GetService("Lighting").GlobalShadows = not state
    for _, v in pairs(game:GetService("Lighting"):GetChildren()) do
        if v:IsA("PostEffect") then
            v.Enabled = not state
        end
    end
end

-- ============ TAB PRINCIPAL ============ --

TabPrincipal:CreateSection("Otimização Geral")

TabPrincipal:CreateButton({
    Name = "🔥 Aplicar Anti-Lag Máximo",
    Callback = function()
        MaxAntiLag()
        PlasticMode(true)
        ClearVisuals()
        Rayfield:Notify({
            Title = "Anti-Lag Ativado!",
            Content = "Lag reduzido ao máximo possível no mobile.",
            Duration = 4,
            Image = 4483362458,
        })
    end
})

TabPrincipal:CreateSection("Toggles de FPS")

TabPrincipal:CreateToggle({
    Name = "Modo Plástico (FPS Boost Forte)",
    CurrentValue = false,
    Flag = "PlasticToggle",
    Callback = function(Value)
        PlasticMode(Value)
    end
})

TabPrincipal:CreateToggle({
    Name = "Desativar Sombras e Efeitos de Luz",
    CurrentValue = false,
    Flag = "SombrasToggle",
    Callback = function(Value)
        DesativarSombras(Value)
    end
})

TabPrincipal:CreateToggle({
    Name = "Limpeza Automática (A cada 4s)",
    CurrentValue = false,
    Flag = "AutoCleanToggle",
    Callback = function(Value)
        getgenv().AutoCleanAtivo = Value
        if Value then
            task.spawn(function()
                while getgenv().AutoCleanAtivo do
                    ClearVisuals()
                    task.wait(4)
                end
            end)
        end
    end
})

TabPrincipal:CreateSection("Limpeza Manual")

TabPrincipal:CreateButton({
    Name = "🗑️ Limpar Partículas e Efeitos Agora",
    Callback = function()
        ClearVisuals()
        Rayfield:Notify({
            Title = "Limpeza Feita!",
            Content = "Todas partículas e efeitos removidos.",
            Duration = 3,
            Image = 4483362458,
        })
    end
})

-- ============ TAB EXTRA ============ --

TabExtra:CreateSection("Configurações Avançadas")

TabExtra:CreateSlider({
    Name = "Distância de Renderização (FogEnd)",
    Range = {50, 500},
    Increment = 25,
    Suffix = "u",
    CurrentValue = 200,
    Flag = "FogSlider",
    Callback = function(Value)
        game:GetService("Lighting").FogEnd = Value
    end
})

TabExtra:CreateToggle({
    Name = "Desativar Animações de Água (Terrain)",
    CurrentValue = false,
    Flag = "WaterToggle",
    Callback = function(Value)
        local Terrain = workspace:FindFirstChildOfClass("Terrain")
        if Terrain then
            Terrain.WaterWaveSize = Value and 0 or 1
            Terrain.WaterWaveSpeed = Value and 0 or 1
            Terrain.WaterReflectance = Value and 0 or 0.5
            Terrain.WaterTransparency = Value and 1 or 0
        end
    end
})

TabExtra:CreateToggle({
    Name = "Baixar Qualidade Gráfica ao Mínimo",
    CurrentValue = false,
    Flag = "QualityToggle",
    Callback = function(Value)
        pcall(function()
            if Value then
                settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            else
                settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
            end
        end)
    end
})

TabExtra:CreateSection("Info")

TabExtra:CreateLabel("Script by Anti-Lag Delta Mobile")
TabExtra:CreateLabel("Use o botão Anti-Lag Máximo primeiro!")

-- ============ NOTIFY INICIAL ============ --
Rayfield:Notify({
    Title = "Script Carregado!",
    Content = "Clique em 'Anti-Lag Máximo' para melhor resultado.",
    Duration = 5,
    Image = 4483362458,
})
