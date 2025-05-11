-- Vérifier que la config existe
if not getgenv then getgenv = function() return _G end end -- Compatibility for some executors
if not getgenv().RiftFindersConfig then
    error("Configuration RiftFinders introuvable. Chargez d'abord le script de configuration.")
end

-- Services (with fallback for executor compatibility)
local HttpService = (game and game:GetService("HttpService")) or (syn and syn.request) or http_request or error("HttpService not found")
local TeleportService = (game and game:GetService("TeleportService")) or error("TeleportService not found")
local Workspace = (game and game:GetService("Workspace")) or error("Workspace not found")
local Players = (game and game:GetService("Players")) or error("Players not found")

-- Charger la configuration
local CONFIG = getgenv().RiftFindersConfig
local cle_script = CONFIG.CLE_SCRIPT

-- Limiter les FPS pour les performances
setfpscap(60) -- Ajustez selon vos besoins

-- Système de clés
local CLES_VALABLES = {
    ["XK3L9-VT72D-WP5QZ-8MNC4-RY1TB"] = {HWID = "fallback_hwid", Comptes = {}},
    ["92JFQ-MCN28-WQ9DK-LZX18-YT2RF"] = {HWID = "fallback_hwid", Comptes = {}},
    ["LMN2X-Z6P7D-92JKL-MC3W8-RTYQ1"] = {HWID = "fallback_hwid", Comptes = {}},
    ["FJQ93-MZKLP-WR7X2-CN1VD-80TYZ"] = {HWID = "fallback_hwid", Comptes = {}},
    ["PQ8WN-RMCL2-ZX10B-YKFQ9-71EDP"] = {HWID = "fallback_hwid", Comptes = {}},
    ["N3VXC-K8J2W-Q4PLD-9TZQM-YF7AR"] = {HWID = "fallback_hwid", Comptes = {}},
    ["WRX8P-2TQL9-ZNM4D-JCQ71-YF56B"] = {HWID = "fallback_hwid", Comptes = {}},
    ["B7MQL-WPQZ9-TY1ED-KXMC2-VQ03N"] = {HWID = "fallback_hwid", Comptes = {}},
    ["KCX12-WFQMB-R79DZ-LPXT3-NQ84E"] = {HWID = "fallback_hwid", Comptes = {}},
    ["TY7CZ-81MNP-XKWQ2-FQ90B-LMRD4"] = {HWID = "fallback_hwid", Comptes = {}}
}

-- Vérification de la clé
local function verifierCle()
    print("Starting key verification...")
    local userId = Players.LocalPlayer and Players.LocalPlayer.UserId or 0
    local donneesCle = CLES_VALABLES[cle_script]

    if not donneesCle then
        error("Clé invalide. Exécution du script arrêtée.")
    end

    print("Key HWID: " .. tostring(donneesCle.HWID))

    if not donneesCle.Comptes[userId] then
        donneesCle.Comptes[userId] = true
        local totalComptes = 0
        for _ in pairs(donneesCle.Comptes) do
            totalComptes = totalComptes + 1
        end
        if totalComptes > 90 then
            error("Limite de 90 comptes atteinte pour cette clé. Exécution du script arrêtée.")
        end
    end
    print("Key verification completed!")
end

-- Exécuter la vérification de la clé
verifierCle()

-- Définitions des failles (updated for better detection)
local CHEMINS_FAILLES = {
    ROYAL_CHEST = {
        Chemin = function()
            print("Checking Royal Chest path...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found in Workspace.Rendered"); return nil end
            local rift = rifts:FindFirstChild("royal-chest")
            if not rift then 
                local children = rifts:GetChildren()
                for i, child in ipairs(children) do
                    if child.Name:lower():find("royal-chest") then
                        rift = child
                        print("Found royal-chest at index " .. i)
                        break
                    end
                end
                if not rift then print("royal-chest not found in Rifts"); return nil end
            end
            local decoration = rift:FindFirstChild("Decoration")
            if not decoration then print("Decoration not found in royal-chest"); return nil end
            local model = decoration:FindFirstChild("Model")
            if not model then print("Model not found in Decoration"); return nil end
            local islandbottom = model:FindFirstChild("islandbottom_collision")
            if not islandbottom then print("islandbottom_collision not found in Model"); return nil end
            local meshPart = islandbottom:FindFirstChild("MeshPart")
            if not meshPart then print("MeshPart not found in islandbottom_collision"); return nil end
            print("Royal Chest path found!")
            return meshPart
        end,
        Minuteur = function()
            print("Checking Royal Chest timer...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found for timer"); return nil end
            local rift = rifts:FindFirstChild("royal-chest")
            if not rift then 
                local children = rifts:GetChildren()
                for i, child in ipairs(children) do
                    if child.Name:lower():find("royal-chest") then
                        rift = child
                        print("Found royal-chest at index " .. i)
                        break
                    end
                end
                if not rift then print("royal-chest not found for timer"); return nil end
            end
            local display = rift:FindFirstChild("Display")
            if not display then print("Display not found in royal-chest"); return nil end
            local surfaceGui = display:FindFirstChild("SurfaceGui")
            if not surfaceGui then print("SurfaceGui not found in Display"); return nil end
            local timer = surfaceGui:FindFirstChild("Timer")
            if not timer then print("Timer not found in SurfaceGui"); return nil end
            print("Royal Chest timer found!")
            return timer
        end
    },
    GOLDEN_CHEST = {
        Chemin = function()
            print("Checking Golden Chest path...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found in Workspace.Rendered"); return nil end
            local rift = rifts:FindFirstChild("golden-chest")
            if not rift then 
                local children = rifts:GetChildren()
                for i, child in ipairs(children) do
                    if child.Name:lower():find("golden-chest") then
                        rift = child
                        print("Found golden-chest at index " .. i)
                        break
                    end
                end
                if not rift then print("golden-chest not found in Rifts"); return nil end
            end
            local decoration = rift:FindFirstChild("Decoration")
            if not decoration then print("Decoration not found in golden-chest"); return nil end
            print("Golden Chest path found!")
            return decoration
        end,
        Minuteur = function()
            print("Checking Golden Chest timer...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found for timer"); return nil end
            local rift = rifts:FindFirstChild("golden-chest")
            if not rift then 
                local children = rifts:GetChildren()
                for i, child in ipairs(children) do
                    if child.Name:lower():find("golden-chest") then
                        rift = child
                        print("Found golden-chest at index " .. i)
                        break
                    end
                end
                if not rift then print("golden-chest not found for timer"); return nil end
            end
            local display = rift:FindFirstChild("Display")
            if not display then print("Display not found in golden-chest"); return nil end
            local surfaceGui = display:FindFirstChild("SurfaceGui")
            if not surfaceGui then print("SurfaceGui not found in Display"); return nil end
            local timer = surfaceGui:FindFirstChild("Timer")
            if not timer then print("Timer not found in SurfaceGui"); return nil end
            print("Golden Chest timer found!")
            return timer
        end
    },
    DICE_CHEST = {
        Chemin = function()
            print("Checking Dice Chest path...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found in Workspace.Rendered"); return nil end
            local rift = rifts:FindFirstChild("dice-rift")
            if not rift then 
                local children = rifts:GetChildren()
                for i, child in ipairs(children) do
                    if child.Name:lower():find("dice-rift") then
                        rift = child
                        print("Found dice-rift at index " .. i)
                        break
                    end
                end
                if not rift then print("dice-rift not found in Rifts"); return nil end
            end
            local decoration = rift:FindFirstChild("Decoration")
            if not decoration then print("Decoration not found in dice-rift"); return nil end
            print("Dice Chest path found!")
            return decoration
        end,
        Minuteur = function()
            print("Checking Dice Chest timer...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found for timer"); return nil end
            local rift = rifts:FindFirstChild("dice-rift")
            if not rift then 
                local children = rifts:GetChildren()
                for i, child in ipairs(children) do
                    if child.Name:lower():find("dice-rift") then
                        rift = child
                        print("Found dice-rift at index " .. i)
                        break
                    end
                end
                if not rift then print("dice-rift not found for timer"); return nil end
            end
            local display = rift:FindFirstChild("Display")
            if not display then print("Display not found in dice-rift"); return nil end
            local surfaceGui = display:FindFirstChild("SurfaceGui")
            if not surfaceGui then print("SurfaceGui not found in Display"); return nil end
            local timer = surfaceGui:FindFirstChild("Timer")
            if not timer then print("Timer not found in SurfaceGui"); return nil end
            print("Dice Chest timer found!")
            return timer
        end
    },
    RAINBOW_EGG = {
        Chemin = function()
            print("Checking Rainbow Egg path...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found in Workspace.Rendered"); return nil end
            local rift = rifts:FindFirstChild("rainbow-egg")
            if not rift then 
                local children = rifts:GetChildren()
                for i, child in ipairs(children) do
                    if child.Name:lower():find("rainbow-egg") then
                        rift = child
                        print("Found rainbow-egg at index " .. i)
                        break
                    end
                end
                if not rift then print("rainbow-egg not found in Rifts"); return nil end
            end
            local decoration = rift:FindFirstChild("Decoration")
            if not decoration then print("Decoration not found in rainbow-egg"); return nil end
            print("Rainbow Egg path found!")
            return decoration
        end,
        Minuteur = function()
            print("Checking Rainbow Egg timer...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found for timer"); return nil end
            local rift = rifts:FindFirstChild("rainbow-egg")
            if not rift then 
                local children = rifts:GetChildren()
                for i, child in ipairs(children) do
                    if child.Name:lower():find("rainbow-egg") then
                        rift = child
                        print("Found rainbow-egg at index " .. i)
                        break
                    end
                end
                if not rift then print("rainbow-egg not found for timer"); return nil end
            end
            local display = rift:FindFirstChild("Display")
            if not display then print("Display not found in rainbow-egg"); return nil end
            local surfaceGui = display:FindFirstChild("SurfaceGui")
            if not surfaceGui then print("SurfaceGui not found in Display"); return nil end
            local timer = surfaceGui:FindFirstChild("Timer")
            if not timer then print("Timer not found in SurfaceGui"); return nil end
            print("Rainbow Egg timer found!")
            return timer
        end,
        Chance = function()
            print("Checking Rainbow Egg luck...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found for luck"); return nil end
            local rift = rifts:FindFirstChild("rainbow-egg")
            if not rift then 
                local children = rifts:GetChildren()
                for i, child in ipairs(children) do
                    if child.Name:lower():find("rainbow-egg") then
                        rift = child
                        print("Found rainbow-egg at index " .. i)
                        break
                    end
                end
                if not rift then print("rainbow-egg not found for luck"); return nil end
            end
            local display = rift:FindFirstChild("Display")
            if not display then print("Display not found for luck"); return nil end
            local surfaceGui = display:FindFirstChild("SurfaceGui")
            if not surfaceGui then print("SurfaceGui not found for luck"); return nil end
            local icon = surfaceGui:FindFirstChild("Icon")
            if not icon then print("Icon not found in SurfaceGui"); return nil end
            local luck = icon:FindFirstChild("Luck")
            if not luck then print("Luck not found in Icon"); return nil end
            print("Rainbow Egg luck found: " .. tostring(luck.Text))
            return luck
        end
    },
    VOID_EGG = {
        Chemin = function()
            print("Checking Void Egg path...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found in Workspace.Rendered"); return nil end
            local rift = rifts:FindFirstChild("void-egg")
            if not rift then 
                local children = rifts:GetChildren()
                for i, child in ipairs(children) do
                    if child.Name:lower():find("void-egg") then
                        rift = child
                        print("Found void-egg at index " .. i)
                        break
                    end
                end
                if not rift then print("void-egg not found in Rifts"); return nil end
            end
            local decoration = rift:FindFirstChild("Decoration")
            if not decoration then print("Decoration not found in void-egg"); return nil end
            print("Void Egg path found!")
            return decoration
        end,
        Minuteur = function()
            print("Checking Void Egg timer...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found for timer"); return nil end
            local rift = rifts:FindFirstChild("void-egg")
            if not rift then 
                local children = rifts:GetChildren()
                for i, child in ipairs(children) do
                    if child.Name:lower():find("void-egg") then
                        rift = child
                        print("Found void-egg at index " .. i)
                        break
                    end
                end
                if not rift then print("void-egg not found for timer"); return nil end
            end
            local display = rift:FindFirstChild("Display")
            if not display then print("Display not found in void-egg"); return nil end
            local surfaceGui = display:FindFirstChild("SurfaceGui")
            if not surfaceGui then print("SurfaceGui not found in Display"); return nil end
            local timer = surfaceGui:FindFirstChild("Timer")
            if not timer then print("Timer not found in SurfaceGui"); return nil end
            print("Void Egg timer found!")
            return timer
        end,
        Chance = function()
            print("Checking Void Egg luck...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found for luck"); return nil end
            local rift = rifts:FindFirstChild("void-egg")
            if not rift then 
                local children = rifts:GetChildren()
                for i, child in ipairs(children) do
                    if child.Name:lower():find("void-egg") then
                        rift = child
                        print("Found void-egg at index " .. i)
                        break
                    end
                end
                if not rift then print("void-egg not found for luck"); return nil end
            end
            local display = rift:FindFirstChild("Display")
            if not display then print("Display not found for luck"); return nil end
            local surfaceGui = display:FindFirstChild("SurfaceGui")
            if not surfaceGui then print("SurfaceGui not found for luck"); return nil end
            local icon = surfaceGui:FindFirstChild("Icon")
            if not icon then print("Icon not found in SurfaceGui"); return nil end
            local luck = icon:FindFirstChild("Luck")
            if not luck then print("Luck not found in Icon"); return nil end
            print("Void Egg luck found: " .. tostring(luck.Text))
            return luck
        end
    },
    NIGHTMARE_EGG = {
        Chemin = function()
            print("Checking Nightmare Egg path...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found in Workspace.Rendered"); return nil end
            local rift = rifts:FindFirstChild("nightmare-egg")
            if not rift then 
                local children = rifts:GetChildren()
                for i, child in ipairs(children) do
                    if child.Name:lower():find("nightmare-egg") then
                        rift = child
                        print("Found nightmare-egg at index " .. i)
                        break
                    end
                end
                if not rift then print("nightmare-egg not found in Rifts"); return nil end
            end
            local decoration = rift:FindFirstChild("Decoration")
            if not decoration then print("Decoration not found in nightmare-egg"); return nil end
            print("Nightmare Egg path found!")
            return decoration
        end,
        Minuteur = function()
            print("Checking Nightmare Egg timer...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found for timer"); return nil end
            local rift = rifts:FindFirstChild("nightmare-egg")
            if not rift then 
                local children = rifts:GetChildren()
                for i, child in ipairs(children) do
                    if child.Name:lower():find("nightmare-egg") then
                        rift = child
                        print("Found nightmare-egg at index " .. i)
                        break
                    end
                end
                if not rift then print("nightmare-egg not found for timer"); return nil end
            end
            local display = rift:FindFirstChild("Display")
            if not display then print("Display not found in nightmare-egg"); return nil end
            local surfaceGui = display:FindFirstChild("SurfaceGui")
            if not surfaceGui then print("SurfaceGui not found in Display"); return nil end
            local timer = surfaceGui:FindFirstChild("Timer")
            if not timer then print("Timer not found in SurfaceGui"); return nil end
            print("Nightmare Egg timer found!")
            return timer
        end,
        Chance = function()
            print("Checking Nightmare Egg luck...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found for luck"); return nil end
            local rift = rifts:FindFirstChild("nightmare-egg")
            if not rift then 
                local children = rifts:GetChildren()
                for i, child in ipairs(children) do
                    if child.Name:lower():find("nightmare-egg") then
                        rift = child
                        print("Found nightmare-egg at index " .. i)
                        break
                    end
                end
                if not rift then print("nightmare-egg not found for luck"); return nil end
            end
            local display = rift:FindFirstChild("Display")
            if not display then print("Display not found for luck"); return nil end
            local surfaceGui = display:FindFirstChild("SurfaceGui")
            if not surfaceGui then print("SurfaceGui not found for luck"); return nil end
            local icon = surfaceGui:FindFirstChild("Icon")
            if not icon then print("Icon not found in SurfaceGui"); return nil end
            local luck = icon:FindFirstChild("Luck")
            if not luck then print("Luck not found in Icon"); return nil end
            print("Nightmare Egg luck found: " .. tostring(luck.Text))
            return luck
        end
    },
    CYBER_EGG = {
        Chemin = function()
            print("Checking Cyber Egg path...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found in Workspace.Rendered"); return nil end
            local rift = rifts:FindFirstChild("cyber-egg")
            if not rift then 
                local children = rifts:GetChildren()
                for i, child in ipairs(children) do
                    if child.Name:lower():find("cyber-egg") then
                        rift = child
                        print("Found cyber-egg at index " .. i)
                        break
                    end
                end
                if not rift then print("cyber-egg not found in Rifts"); return nil end
            end
            local decoration = rift:FindFirstChild("Decoration")
            if not decoration then print("Decoration not found in cyber-egg"); return nil end
            print("Cyber Egg path found!")
            return decoration
        end,
        Minuteur = function()
            print("Checking Cyber Egg timer...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found for timer"); return nil end
            local rift = rifts:FindFirstChild("cyber-egg")
            if not rift then 
                local children = rifts:GetChildren()
                for i, child in ipairs(children) do
                    if child.Name:lower():find("cyber-egg") then
                        rift = child
                        print("Found cyber-egg at index " .. i)
                        break
                    end
                end
                if not rift then print("cyber-egg not found for timer"); return nil end
            end
            local display = rift:FindFirstChild("Display")
            if not display then print("Display not found in cyber-egg"); return nil end
            local surfaceGui = display:FindFirstChild("SurfaceGui")
            if not surfaceGui then print("SurfaceGui not found in Display"); return nil end
            local timer = surfaceGui:FindFirstChild("Timer")
            if not timer then print("Timer not found in SurfaceGui"); return nil end
            print("Cyber Egg timer found!")
            return timer
        end,
        Chance = function()
            print("Checking Cyber Egg luck...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found for luck"); return nil end
            local rift = rifts:FindFirstChild("cyber-egg")
            if not rift then 
                local children = rifts:GetChildren()
                for i, child in ipairs(children) do
                    if child.Name:lower():find("cyber-egg") then
                        rift = child
                        print("Found cyber-egg at index " .. i)
                        break
                    end
                end
                if not rift then print("cyber-egg not found for luck"); return nil end
            end
            local display = rift:FindFirstChild("Display")
            if not display then print("Display not found for luck"); return nil end
            local surfaceGui = display:FindFirstChild("SurfaceGui")
            if not surfaceGui then print("SurfaceGui not found for luck"); return nil end
            local icon = surfaceGui:FindFirstChild("Icon")
            if not icon then print("Icon not found in SurfaceGui"); return nil end
            local luck = icon:FindFirstChild("Luck")
            if not luck then print("Luck not found in Icon"); return nil end
            print("Cyber Egg luck found: " .. tostring(luck.Text))
            return luck
        end
    }
}

-- Fonction pour envoyer un webhook (corrigée pour la hauteur)
local function envoyerWebhook(nomFaille, tempsRestant, chance, urlWebhook)
    print("Attempting to send webhook for " .. nomFaille .. " to " .. tostring(urlWebhook))
    local multiplicateur = chance or "Unknown"
    local playerCount = #Players:GetPlayers()
    local maxPlayers = Players.MaxPlayers or 100
    local joueurs = tostring(playerCount) .. "/" .. tostring(maxPlayers)
    local jobId = game.JobId or "unknown_jobid"
    local joinUrl = "https://joinbgsi.shop/?placeID=85896571713843&gameInstanceId=" .. jobId

    -- Get height from the first BasePart in Decoration
    local chemin = CHEMINS_FAILLES[nomFaille].Chemin()
    local hauteur = "N/A"
    if chemin then
        local basePart = chemin:FindFirstChildWhichIsA("BasePart")
        if basePart then
            hauteur = math.floor(basePart.Position.Y)
        end
    end

    -- Simplified embed to avoid compatibility issues
    local embed = {
        title = nomFaille .. " Trouvé !",
        color = 16777023, -- Light purple as requested
        fields = {
            {name = "⏱️ Temps Restant", value = tostring(tempsRestant), inline = true},
            {name = "📏 Hauteur", value = tostring(hauteur), inline = true},
            {name = "🍀 Multiplicateur", value = tostring(multiplicateur), inline = true},
            {name = "👤 Nombre de Joueurs", value = joueurs, inline = true},
            {
                name = "🌌 Téléportation",
                value = "JobId: " .. jobId .. "\n[REJOINDRE SERVEUR](" .. joinUrl .. ")",
                inline = false
            }
        },
        footer = {
            text = "BGSI FR | .gg/pVaaDtxkUe - " .. os.date("%Y-%m-%d - %I:%M:%S %p")
        },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ") -- Simplified ISO 8601 format
    }
    
    if CONFIG.ID_DISCORD and CONFIG.ID_DISCORD ~= "" then
        embed.content = "<@" .. CONFIG.ID_DISCORD .. ">"
    end
    
    if CONFIG.AFFICHER_ID_SERVEUR and jobId ~= "unknown_jobid" then
        table.insert(embed.fields, {name = "ID Serveur", value = jobId, inline = true})
    end
    
    local payload = {
        embeds = {embed}
    }
    
    local cibleWebhook = urlWebhook
    if not cibleWebhook or cibleWebhook == "" or cibleWebhook == "VOTRE_WEBHOOK_" .. nomFaille .. "_ICI" then
        warn("No valid webhook URL for " .. nomFaille .. ", you fucked up! Set a proper URL in RiftFindersConfig.lua")
        return
    end
    
    local encodedPayload = HttpService:JSONEncode(payload)
    print("Webhook payload: " .. encodedPayload)

    -- Try exploit-specific HTTP functions first
    local succes = false
    local erreur = nil

    -- Attempt 1: syn.request (Synapse-specific)
    if syn and syn.request then
        print("Trying syn.request...")
        succes, erreur = pcall(function()
            local response = syn.request({
                Url = cibleWebhook,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = encodedPayload
            })
            print("syn.request response: " .. tostring(response.Success) .. " - " .. tostring(response.StatusCode) .. " - " .. tostring(response.Body))
            if not response.Success then
                error("syn.request failed with status " .. tostring(response.StatusCode) .. ": " .. tostring(response.Body))
            end
        end)
    end

    -- Attempt 2: http_request (generic exploit function)
    if not succes and http_request then
        print("Trying http_request...")
        succes, erreur = pcall(function()
            local response = http_request({
                Url = cibleWebhook,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = encodedPayload
            })
            print("http_request response: " .. tostring(response.Success) .. " - " .. tostring(response.StatusCode) .. " - " .. tostring(response.Body))
            if not response.Success then
                error("http_request failed with status " .. tostring(response.StatusCode) .. ": " .. tostring(response.Body))
            end
        end)
    end

    -- Attempt 3: HttpService (will likely fail, but let's try for completeness)
    if not succes then
        print("Trying HttpService...")
        succes, erreur = pcall(function()
            if HttpService.PostAsync then
                local response = HttpService:PostAsync(cibleWebhook, encodedPayload, Enum.HttpContentType.ApplicationJson)
                print("HttpService response: " .. tostring(response))
            elseif HttpService.request then
                local response = HttpService:request({
                    Url = cibleWebhook,
                    Method = "POST",
                    Headers = {["Content-Type"] = "application/json"},
                    Body = encodedPayload
                })
                print("HttpService response: " .. tostring(response.Success) .. " - " .. tostring(response.StatusCode) .. " - " .. tostring(response.Body))
                if not response.Success then
                    error("HttpService failed with status " .. tostring(response.StatusCode) .. ": " .. tostring(response.Body))
                end
            else
                error("HttpService not supported by this executor")
            end
        end)
    end

    -- If all attempts fail, log the payload for manual sending
    if not succes then
        warn("Échec de l'envoi du webhook pour " .. nomFaille .. " : " .. tostring(erreur))
        print("Since direct HTTP failed, here’s the payload to send manually to " .. cibleWebhook .. ":")
        print(encodedPayload)
        print("Copy the above payload, go to your webhook URL, and send it via a tool like Postman or a browser extension.")
        print("Also, check the error above for details. Common issues: invalid webhook URL, rate limits, or payload format errors.")
    else
        print("Webhook sent for " .. nomFaille .. " successfully!")
    end
end

-- Fonction pour vérifier les failles et envoyer immédiatement
local detectedRifts = {} -- Table to track detected rifts to avoid spamming webhooks
local function verifierFailles()
    print("Checking for rifts...")
    
    for nomFaille, donneesFaille in pairs(CHEMINS_FAILLES) do
        local configFaille = CONFIG.FAILES[nomFaille]
        if configFaille and configFaille.ACTIVE then
            print("Verifying " .. nomFaille .. "...")
            local chemin = donneesFaille.Chemin()
            if chemin and chemin.Parent then
                print(nomFaille .. " path exists!")
                local minuteur = donneesFaille.Minuteur()
                if minuteur then
                    print(nomFaille .. " timer exists!")
                    local texteMinuteur = minuteur.Text or "N/A"
                    local chance = nil
                    if donneesFaille.Chance then
                        local chanceObj = donneesFaille.Chance()
                        if chanceObj then
                            local texteChance = (chanceObj.Text or ""):upper()
                            if table.find(CONFIG.SNIPE_LUCK, texteChance) then
                                chance = texteChance
                                print(nomFaille .. " luck matches: " .. texteChance)
                            else
                                print(nomFaille .. " luck does not match: " .. texteChance)
                            end
                        else
                            print(nomFaille .. " luck object not found")
                        end
                    end
                    -- Check if we've already detected this rift to avoid spamming
                    if not detectedRifts[nomFaille] then
                        detectedRifts[nomFaille] = true
                        -- Send webhook immediately
                        envoyerWebhook(nomFaille, texteMinuteur, chance, configFaille.WEBHOOK_URL)
                    else
                        print(nomFaille .. " already detected, skipping webhook")
                    end
                else
                    print(nomFaille .. " timer not found")
                    detectedRifts[nomFaille] = nil -- Reset if the rift disappears
                end
            else
                print(nomFaille .. " path does not exist")
                detectedRifts[nomFaille] = nil -- Reset if the rift disappears
            end
        end
    end
end

-- Fonction pour initial scan (immediate webhook on detection)
local function initialScan()
    print("Starting initial scan of rifts...")
    verifierFailles() -- Use the same logic as the main loop
    print("Initial scan completed!")
end

-- Fonction pour changer de serveur
local function changerServeur()
    if CONFIG.HOP_SERVER then
        local succes, erreur = pcall(function()
            if TeleportService.TeleportToPlaceInstance then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
            else
                error("Server hop not supported by this executor")
            end
        end)
        if not succes then
            warn("Hop failed, you dumbass: " .. tostring(erreur))
            wait(10)
            changerServeur()
        end
    else
        local succes, erreur = pcall(function()
            if TeleportService.Teleport then
                TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
            else
                error("Teleport not supported by this executor")
            end
        end)
        if not succes then
            warn("Teleport failed, shithead: " .. tostring(erreur))
            wait(10)
            changerServeur()
        end
    end
end

-- Exécuter un scan initial au démarrage
initialScan()

-- Boucle principale (continuous scanning)
while true do
    verifierFailles()
    wait(CONFIG.INTERVALLE_VERIFICATION or 1) -- 5 secondes selon ta config
    
    -- Changer de serveur après l'intervalle
    if os.time() % (CONFIG.INTERVALLE_CHANGEMENT_SERVEUR or 300) < (CONFIG.INTERVALLE_VERIFICATION or 1) then
        -- Reset detected rifts on server change
        detectedRifts = {}
        changerServeur()
    end
end
