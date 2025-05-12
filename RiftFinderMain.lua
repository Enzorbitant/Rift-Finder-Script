-- RiftFindersMain.lua
-- Vérifier que la config existe
if not getgenv then getgenv = function() return _G end end
if not getgenv().RiftFindersConfig then
    error("RiftFindersConfig introuvable. Exécutez RiftFindersConfig.lua d'abord.")
end

-- Services
local HttpService = game:GetService("HttpService") or (syn and syn.request) or http_request or error("HttpService not found")
local TeleportService = game:GetService("TeleportService") or error("TeleportService not found")
local Workspace = game:GetService("Workspace") or error("Workspace not found")
local Players = game:GetService("Players") or error("Players not found")

-- Charger la configuration
local CONFIG = getgenv().RiftFindersConfig

-- Luarmor Authentication
local function verifyLuarmor()
    print("Verifying Luarmor key...")
    local luarmor = require(game:GetService("ReplicatedStorage").Luarmor) -- Adjust based on your Luarmor setup
    if not luarmor then
        error("Luarmor module not found. Ensure Luarmor is properly set up.")
    end

    local success, result = pcall(function()
        return luarmor.verify(CONFIG.LUARMOR_KEY, CONFIG.LUARMOR_SCRIPT_ID)
    end)

    if not success or not result then
        warn("Luarmor verification failed: " .. tostring(result))
        if Players.LocalPlayer then
            Players.LocalPlayer:Kick("Clé Luarmor invalide ou erreur de vérification.")
        else
            error("Cannot kick: LocalPlayer is nil. Luarmor verification failed.")
        end
    end
    print("Luarmor verification successful!")
end

-- Attendre que LocalPlayer soit chargé
while not Players.LocalPlayer do
    wait(0.1)
    print("Waiting for LocalPlayer...")
end

-- Vérifier Luarmor
verifyLuarmor()

-- Définitions des failles
local CHEMINS_FAILLES = {
    ROYAL_CHEST = {
        Chemin = function()
            print("Checking Royal Chest path...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found"); return nil end
            local rift = rifts:FindFirstChild("royal-chest") or rifts:FindFirstChildWhichIsA("Model", true, function(obj) return obj.Name:lower():find("royal-chest") end)
            if not rift then print("royal-chest not found"); return nil end
            local decoration = rift:FindFirstChild("Decoration")
            if not decoration then print("Decoration not found"); return nil end
            local model = decoration:FindFirstChild("Model")
            if not model then print("Model not found"); return nil end
            local islandbottom = model:FindFirstChild("islandbottom_collision")
            if not islandbottom then print("islandbottom_collision not found"); return nil end
            local meshPart = islandbottom:FindFirstChild("MeshPart")
            if not meshPart then print("MeshPart not found"); return nil end
            print("Royal Chest path found!")
            return meshPart
        end,
        Minuteur = function()
            print("Checking Royal Chest timer...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found"); return nil end
            local rift = rifts:FindFirstChild("royal-chest") or rifts:FindFirstChildWhichIsA("Model", true, function(obj) return obj.Name:lower():find("royal-chest") end)
            if not rift then print("royal-chest not found"); return nil end
            local display = rift:FindFirstChild("Display")
            if not display then print("Display not found"); return nil end
            local surfaceGui = display:FindFirstChild("SurfaceGui")
            if not surfaceGui then print("SurfaceGui not found"); return nil end
            local timer = surfaceGui:FindFirstChild("Timer")
            if not timer then print("Timer not found"); return nil end
            print("Royal Chest timer found!")
            return timer
        end
    },
    GOLDEN_CHEST = {
        Chemin = function()
            print("Checking Golden Chest path...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found"); return nil end
            local rift = rifts:FindFirstChild("golden-chest") or rifts:FindFirstChildWhichIsA("Model", true, function(obj) return obj.Name:lower():find("golden-chest") end)
            if not rift then print("golden-chest not found"); return nil end
            local decoration = rift:FindFirstChild("Decoration")
            if not decoration then print("Decoration not found"); return nil end
            print("Golden Chest path found!")
            return decoration
        end,
        Minuteur = function()
            print("Checking Golden Chest timer...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found"); return nil end
            local rift = rifts:FindFirstChild("golden-chest") or rifts:FindFirstChildWhichIsA("Model", true, function(obj) return obj.Name:lower():find("golden-chest") end)
            if not rift then print("golden-chest not found"); return nil end
            local display = rift:FindFirstChild("Display")
            if not display then print("Display not found"); return nil end
            local surfaceGui = display:FindFirstChild("SurfaceGui")
            if not surfaceGui then print("SurfaceGui not found"); return nil end
            local timer = surfaceGui:FindFirstChild("Timer")
            if not timer then print("Timer not found"); return nil end
            print("Golden Chest timer found!")
            return timer
        end
    },
    DICE_CHEST = {
        Chemin = function()
            print("Checking Dice Chest path...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found"); return nil end
            local rift = rifts:FindFirstChild("dice-rift") or rifts:FindFirstChildWhichIsA("Model", true, function(obj) return obj.Name:lower():find("dice-rift") end)
            if not rift then print("dice-rift not found"); return nil end
            local decoration = rift:FindFirstChild("Decoration")
            if not decoration then print("Decoration not found"); return nil end
            print("Dice Chest path found!")
            return decoration
        end,
        Minuteur = function()
            print("Checking Dice Chest timer...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found"); return nil end
            local rift = rifts:FindFirstChild("dice-rift") or rifts:FindFirstChildWhichIsA("Model", true, function(obj) return obj.Name:lower():find("dice-rift") end)
            if not rift then print("dice-rift not found"); return nil end
            local display = rift:FindFirstChild("Display")
            if not display then print("Display not found"); return nil end
            local surfaceGui = display:FindFirstChild("SurfaceGui")
            if not surfaceGui then print("SurfaceGui not found"); return nil end
            local timer = surfaceGui:FindFirstChild("Timer")
            if not timer then print("Timer not found"); return nil end
            print("Dice Chest timer found!")
            return timer
        end
    },
    RAINBOW_EGG = {
        Chemin = function()
            print("Checking Rainbow Egg path...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found"); return nil end
            local rift = rifts:FindFirstChild("rainbow-egg") or rifts:FindFirstChildWhichIsA("Model", true, function(obj) return obj.Name:lower():find("rainbow-egg") end)
            if not rift then print("rainbow-egg not found"); return nil end
            local decoration = rift:FindFirstChild("Decoration")
            if not decoration then print("Decoration not found"); return nil end
            print("Rainbow Egg path found!")
            return decoration
        end,
        Minuteur = function()
            print("Checking Rainbow Egg timer...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
 at not rifts then print("Rifts not found"); return nil end
            local rift = rifts:FindFirstChild("rainbow-egg") or rifts:FindFirstChildWhichIsA("Model", true, function(obj) return obj.Name:lower():find("rainbow-egg") end)
            if not rift then print("rainbow-egg not found"); return nil end
            local display = rift:FindFirstChild("Display")
            if not display then print("Display not found"); return nil end
            local surfaceGui = display:FindFirstChild("SurfaceGui")
            if not surfaceGui then print("SurfaceGui not found"); return nil end
            local timer = surfaceGui:FindFirstChild("Timer")
            if not timer then print("Timer not found"); return nil end
            print("Rainbow Egg timer found!")
            return timer
        end,
        Chance = function()
            print("Checking Rainbow Egg luck...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found"); return nil end
            local rift = rifts:FindFirstChild("rainbow-egg") or rifts:FindFirstChildWhichIsA("Model", true, function(obj) return obj.Name:lower():find("rainbow-egg") end)
            if not rift then print("rainbow-egg not found"); return nil end
            local display = rift:FindFirstChild("Display")
            if not display then print("Display not found"); return nil end
            local surfaceGui = display:FindFirstChild("SurfaceGui")
            if not surfaceGui then print("SurfaceGui not found"); return nil end
            local icon = surfaceGui:FindFirstChild("Icon")
            if not icon then print("Icon not found"); return nil end
            local luck = icon:FindFirstChild("Luck")
            if not luck then print("Luck not found"); return nil end
            print("Rainbow Egg luck found: " .. tostring(luck.Text))
            return luck
        end
    },
    VOID_EGG = {
        Chemin = function()
            print("Checking Void Egg path...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found"); return nil end
            local rift = rifts:FindFirstChild("void-egg") or rifts:FindFirstChildWhichIsA("Model", true, function(obj) return obj.Name:lower():find("void-egg") end)
            if not rift then print("void-egg not found"); return nil end
            local decoration = rift:FindFirstChild("Decoration")
            if not decoration then print("Decoration not found"); return nil end
            print("Void Egg path found!")
            return decoration
        end,
        Minuteur = function()
            print("Checking Void Egg timer...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found"); return nil end
            local rift = rifts:FindFirstChild("void-egg") or rifts:FindFirstChildWhichIsA("Model", true, function(obj) return obj.Name:lower():find("void-egg") end)
            if not rift then print("void-egg not found"); return nil end
            local display = rift:FindFirstChild("Display")
            if not display then print("Display not found"); return nil end
            local surfaceGui = display:FindFirstChild("SurfaceGui")
            if not surfaceGui then print("SurfaceGui not found"); return nil end
            local timer = surfaceGui:FindFirstChild("Timer")
            if not timer then print("Timer not found"); return nil end
            print("Void Egg timer found!")
            return timer
        end,
        Chance = function()
            print("Checking Void Egg luck...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found"); return nil end
            local rift = rifts:FindFirstChild("void-egg") or rifts:FindFirstChildWhichIsA("Model", true, function(obj) return obj.Name:lower():find("void-egg") end)
            if not rift then print("void-egg not found"); return nil end
            local display = rift:FindFirstChild("Display")
            if not display then print("Display not found"); return nil end
            local surfaceGui = display:FindFirstChild("SurfaceGui")
            if not surfaceGui then print("SurfaceGui not found"); return nil end
            local icon = surfaceGui:FindFirstChild("Icon")
            if not icon then print("Icon not found"); return nil end
            local luck = icon:FindFirstChild("Luck")
            if not luck then print("Luck not found"); return nil end
            print("Void Egg luck found: " .. tostring(luck.Text))
            return luck
        end
    },
    NIGHTMARE_EGG = {
        Chemin = function()
            print("Checking Nightmare Egg path...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found"); return nil end
            local rift = rifts:FindFirstChild("nightmare-egg") or rifts:FindFirstChildWhichIsA("Model", true, function(obj) return obj.Name:lower():find("nightmare-egg") end)
            if not rift then print("nightmare-egg not found"); return nil end
            local decoration = rift:FindFirstChild("Decoration")
            if not decoration then print("Decoration not found"); return nil end
            print("Nightmare Egg path found!")
            return decoration
        end,
        Minuteur = function()
            print("Checking Nightmare Egg timer...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found"); return nil end
            local rift = rifts:FindFirstChild("nightmare-egg") or rifts:FindFirstChildWhichIsA("Model", true, function(obj) return obj.Name:lower():find("nightmare-egg") end)
            if not rift then print("nightmare-egg not found"); return nil end
            local display = rift:FindFirstChild("Display")
            if not display then print("Display not found"); return nil end
            local surfaceGui = display:FindFirstChild("SurfaceGui")
            if not surfaceGui then print("SurfaceGui not found"); return nil end
            local timer = surfaceGui:FindFirstChild("Timer")
            if not timer then print("Timer not found"); return nil end
            print("Nightmare Egg timer found!")
            return timer
        end,
        Chance = function()
            print("Checking Nightmare Egg luck...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found"); return nil end
            local rift = rifts:FindFirstChild("nightmare-egg") or rifts:FindFirstChildWhichIsA("Model", true, function(obj) return obj.Name:lower():find("nightmare-egg") end)
            if not rift then print("nightmare-egg not found"); return nil end
            local display = rift:FindFirstChild("Display")
            if not display then print("Display not found"); return nil end
            local surfaceGui = display:FindFirstChild("SurfaceGui")
            if not surfaceGui then print("SurfaceGui not found"); return nil end
            local icon = surfaceGui:FindFirstChild("Icon")
            if not icon then print("Icon not found"); return nil end
            local luck = icon:FindFirstChild("Luck")
            if not luck then print("Luck not found"); return nil end
            print("Nightmare Egg luck found: " .. tostring(luck.Text))
            return luck
        end
    },
    CYBER_EGG = {
        Chemin = function()
            print("Checking Cyber Egg path...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found"); return nil end
            local rift = rifts:FindFirstChild("cyber-egg") or rifts:FindFirstChildWhichIsA("Model", true, function(obj) return obj.Name:lower():find("cyber-egg") end)
            if not rift then print("cyber-egg not found"); return nil end
            local decoration = rift:FindFirstChild("Decoration")
            if not decoration then print("Decoration not found"); return nil end
            print("Cyber Egg path found!")
            return decoration
        end,
        Minuteur = function()
            print("Checking Cyber Egg timer...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found"); return nil end
            local rift = rifts:FindFirstChild("cyber-egg") or rifts:FindFirstChildWhichIsA("Model", true, function(obj) return obj.Name:lower():find("cyber-egg") end)
            if not rift then print("cyber-egg not found"); return nil end
            local display = rift:FindFirstChild("Display")
            if not display then print("Display not found"); return nil end
            local surfaceGui = display:FindFirstChild("SurfaceGui")
            if not surfaceGui then print("SurfaceGui not found"); return nil end
            local timer = surfaceGui:FindFirstChild("Timer")
            if not timer then print("Timer not found"); return nil end
            print("Cyber Egg timer found!")
            return timer
        end,
        Chance = function()
            print("Checking Cyber Egg luck...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found"); return nil end
            local rift = rifts:FindFirstChild("cyber-egg") or rifts:FindFirstChildWhichIsA("Model", true, function(obj) return obj.Name:lower():find("cyber-egg") end)
            if not rift then print("cyber-egg not found"); return nil end
            local display = rift:FindFirstChild("Display")
            if not display then print("Display not found"); return nil end
            local surfaceGui = display:FindFirstChild("SurfaceGui")
            if not surfaceGui then print("SurfaceGui not found"); return nil end
            local icon = surfaceGui:FindFirstChild("Icon")
            if not icon then print("Icon not found"); return nil end
            local luck = icon:FindFirstChild("Luck")
            if not luck then print("Luck not found"); return nil end
            print("Cyber Egg luck found: " .. tostring(luck.Text))
            return luck
        end
    },
    UNDERWORLD_EGG = {
        Chemin = function()
            print("Checking Underworld Egg path...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found"); return nil end
            local rift = rifts:FindFirstChild("underworld-1") or rifts:FindFirstChild("underworld-2")
            if not rift then print("underworld-1 or underworld-2 not found"); return nil end
            local decoration = rift:FindFirstChild("Decoration")
            if not decoration then print("Decoration not found"); return nil end
            print("Underworld Egg path found for " .. rift.Name .. "!")
            return decoration
        end,
        Minuteur = function()
            print("Checking Underworld Egg timer...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found"); return nil end
            local rift = rifts:FindFirstChild("underworld-1") or rifts:FindFirstChild("underworld-2")
            if not rift then print("underworld-1 or underworld-2 not found"); return nil end
            local display = rift:FindFirstChild("Display")
            if not display then print("Display not found"); return nil end
            local surfaceGui = display:FindFirstChild("SurfaceGui")
            if not surfaceGui then print("SurfaceGui not found"); return nil end
            local timer = surfaceGui:FindFirstChild("Timer")
            if not timer then print("Timer not found"); return nil end
            print("Underworld Egg timer found for " .. rift.Name .. "!")
            return timer
        end,
        Chance = function()
            print("Checking Underworld Egg luck...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found"); return nil end
            local rift = rifts:FindFirstChild("underworld-1") or rifts:FindFirstChild("underworld-2")
            if not rift then print("underworld-1 or underworld-2 not found"); return nil end
            local display = rift:FindFirstChild("Display")
            if not display then print("Display not found"); return nil end
            local surfaceGui = display:FindFirstChild("SurfaceGui")
            if not surfaceGui then print("SurfaceGui not found"); return nil end
            local icon = surfaceGui:FindFirstChild("Icon")
            if not icon then print("Icon not found"); return nil end
            local luck = icon:FindFirstChild("Luck")
            if not luck then print("Luck not found"); return nil end
            print("Underworld Egg luck found for " .. rift.Name .. ": " .. tostring(luck.Text))
            return luck
        end
    }
}

-- Fonction pour envoyer un webhook
local function envoyerWebhook(nomFaille, tempsRestant, chance, urlWebhook)
    print("Sending webhook for " .. nomFaille .. " to " .. tostring(urlWebhook))
    local multiplicateur = chance or "Unknown"
    local playerCount = #Players:GetPlayers()
    local maxPlayers = Players.MaxPlayers or 100
    local joueurs = tostring(playerCount) .. "/" .. tostring(maxPlayers)
    local jobId = game.JobId or "unknown_jobid"
    local joinUrl = "https://joinbgsi.shop/?placeID=85896571713843&gameInstanceId=" .. jobId

    local chemin = CHEMINS_FAILLES[nomFaille].Chemin()
    local hauteur = "N/A"
    if chemin then
        local basePart = chemin:FindFirstChildWhichIsA("BasePart")
        if basePart then
            hauteur = math.floor(basePart.Position.Y)
        end
    end

    local embed = {
        title = nomFaille:gsub("_", " "):gsub("(%a)([%w']*)", function(first, rest) return first:upper() .. rest:lower() end) .. " Trouvé !",
        color = 16777023,
        fields = {
            {name = "⏱️ Temps Restant", value = tostring(tempsRestant), inline = true},
            {name = "📏 Hauteur", value = tostring(hauteur), inline = true},
            {name = "🍀 Multiplicateur", value = tostring(multiplicateur), inline = true},
            {name = "👤 Nombre de Joueurs", value = joueurs, inline = true},
            {name = "🌌 Téléportation", value = "JobId: `" .. jobId .. "`\n🔗 **[REJOINDRE SERVEUR](" .. joinUrl .. ")**", inline = false}
        },
        footer = {text = os.date("%Y-%m-%d - %I:%M:%S %p")},
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }

    if CONFIG.ID_DISCORD and CONFIG.ID_DISCORD ~= "" then
        embed.content = "<@" .. CONFIG.ID_DISCORD .. ">"
    end

    local payload = {embeds = {embed}}
    local cibleWebhook = urlWebhook
    if not cibleWebhook or cibleWebhook == "" then
        warn("Invalid webhook URL for " .. nomFaille)
        return
    end

    local encodedPayload = HttpService:JSONEncode(payload)
    print("Webhook payload: " .. encodedPayload)

    local succes, erreur = false, nil
    if syn and syn.request then
        print("Trying syn.request...")
        succes, erreur = pcall(function()
            local response = syn.request({
                Url = cibleWebhook,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = encodedPayload
            })
            if not response.Success then
                error("syn.request failed: " .. tostring(response.StatusCode))
            end
        end)
    elseif http_request then
        print("Trying http_request...")
        succes, erreur = pcall(function()
            local response = http_request({
                Url = cibleWebhook,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = encodedPayload
            })
            if not response.Success then
                error("http_request failed: " .. tostring(response.StatusCode))
            end
        end)
    elseif HttpService.PostAsync then
        print("Trying HttpService...")
        succes, erreur = pcall(function()
            HttpService:PostAsync(cibleWebhook, encodedPayload, Enum.HttpContentType.ApplicationJson)
        end)
    end

    if not succes then
        warn("Webhook failed for " .. nomFaille .. ": " .. tostring(erreur))
        print("Manual payload: " .. encodedPayload)
    else
        print("Webhook sent for " .. nomFaille)
    end
end

-- Vérifier les failles
local detectedRifts = {}
local function verifierFailles()
    print("Checking rifts...")
    for nomFaille, donneesFaille in pairs(CHEMINS_FAILLES) do
        local configFaille = CONFIG.FAILES[nomFaille]
        if configFaille and configFaille.ACTIVE then
            print("Verifying " .. nomFaille .. "...")
            local chemin = donneesFaille.Chemin()
            if chemin and chemin.Parent then
                local minuteur = donneesFaille.Minuteur()
                if minuteur then
                    local texteMinuteur = minuteur.Text or "N/A"
                    local chance = nil
                    if donneesFaille.Chance then
                        local chanceObj = donneesFaille.Chance()
                        if chanceObj then
                            local texteChance = (chanceObj.Text or ""):upper()
                            if table.find(CONFIG.SNIPE_LUCK, texteChance) then
                                chance = texteChance
                                print(nomFaille .. " luck matches: " .. texteChance)
                            end
                        end
                    end
                    if not detectedRifts[nomFaille] then
                        detectedRifts[nomFaille] = true
                        envoyerWebhook(nomFaille, texteMinuteur, chance, configFaille.WEBHOOK_URL)
                    end
                else
                    detectedRifts[nomFaille] = nil
                end
            else
                detectedRifts[nomFaille] = nil
            end
        end
    end
end

-- Scan initial
local function initialScan()
    print("Starting initial scan...")
    verifierFailles()
    print("Initial scan done!")
end

-- Changer de serveur
local function changerServeur()
    local succes, erreur = pcall(function()
        if CONFIG.HOP_SERVER and TeleportService.TeleportToPlaceInstance then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
        elseif TeleportService.Teleport then
            TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
        else
            error("Teleport not supported")
        end
    end)
    if not succes then
        warn("Teleport failed: " .. tostring(erreur))
        wait(10)
        changerServeur()
    end
end

-- Exécuter
initialScan()
while true do
    verifierFailles()
    wait(CONFIG.INTERVALLE_VERIFICATION)
    if os.time() % CONFIG.INTERVALLE_CHANGEMENT_SERVEUR < CONFIG.INTERVALLE_VERIFICATION then
        detectedRifts = {}
        changerServeur()
    end
end
