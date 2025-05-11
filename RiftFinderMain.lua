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

-- Définitions des failles
local CHEMINS_FAILLES = {
    ROYAL_CHEST = {
        Chemin = function()
            print("Checking Royal Chest path...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found in Workspace.Rendered"); return nil end
            local rift = rifts:FindFirstChild("royal-chest")
            if not rift then print("royal-chest not found in Rifts"); return nil end
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
            if not rift then print("royal-chest not found for timer"); return nil end
            local display = rift:FindFirstChild("Display")
            if not display then print("Display not found in royal-chest"); return nil end
            local surfaceGui = display:FindFirstChild("SurfaceGui")
            if not surfaceGui then print("SurfaceGui not found in Display"); return nil end
            local timer = surfaceGui:FindFirstChild("Timer")
            if not timer then print("Timer not found in SurfaceGui"); return nil end
            print("Royal Chest timer found!")
            return timer
        end,
        Hauteur = function()
            print("Checking Royal Chest height...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found for height"); return nil end
            local rift = rifts:FindFirstChild("royal-chest")
            if not rift then print("royal-chest not found for height"); return nil end
            local decoration = rift:FindFirstChild("Decoration")
            if not decoration then print("Decoration not found for height"); return nil end
            print("Royal Chest height found: " .. tostring(decoration.Position.Y))
            return decoration.Position.Y
        end
    },
    GOLDEN_CHEST = {
        Chemin = function()
            print("Checking Golden Chest path...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found in Workspace.Rendered"); return nil end
            local rift = rifts:FindFirstChild("golden-chest")
            if not rift then print("golden-chest not found in Rifts"); return nil end
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
            if not rift then print("golden-chest not found for timer"); return nil end
            local display = rift:FindFirstChild("Display")
            if not display then print("Display not found in golden-chest"); return nil end
            local surfaceGui = display:FindFirstChild("SurfaceGui")
            if not surfaceGui then print("SurfaceGui not found in Display"); return nil end
            local timer = surfaceGui:FindFirstChild("Timer")
            if not timer then print("Timer not found in SurfaceGui"); return nil end
            print("Golden Chest timer found!")
            return timer
        end,
        Hauteur = function()
            print("Checking Golden Chest height...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found for height"); return nil end
            local rift = rifts:FindFirstChild("golden-chest")
            if not rift then print("golden-chest not found for height"); return nil end
            local decoration = rift:FindFirstChild("Decoration")
            if not decoration then print("Decoration not found for height"); return nil end
            print("Golden Chest height found: " .. tostring(decoration.Position.Y))
            return decoration.Position.Y
        end
    },
    DICE_CHEST = {
        Chemin = function()
            print("Checking Dice Chest path...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found in Workspace.Rendered"); return nil end
            local rift = rifts:FindFirstChild("dice-rift")
            if not rift then print("dice-rift not found in Rifts"); return nil end
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
            if not rift then print("dice-rift not found for timer"); return nil end
            local display = rift:FindFirstChild("Display")
            if not display then print("Display not found in dice-rift"); return nil end
            local surfaceGui = display:FindFirstChild("SurfaceGui")
            if not surfaceGui then print("SurfaceGui not found in Display"); return nil end
            local timer = surfaceGui:FindFirstChild("Timer")
            if not timer then print("Timer not found in SurfaceGui"); return nil end
            print("Dice Chest timer found!")
            return timer
        end,
        Hauteur = function()
            print("Checking Dice Chest height...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found for height"); return nil end
            local rift = rifts:FindFirstChild("dice-rift")
            if not rift then print("dice-rift not found for height"); return nil end
            local decoration = rift:FindFirstChild("Decoration")
            if not decoration then print("Decoration not found for height"); return nil end
            print("Dice Chest height found: " .. tostring(decoration.Position.Y))
            return decoration.Position.Y
        end
    },
    RAINBOW_EGG = {
        Chemin = function()
            print("Checking Rainbow Egg path...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found in Workspace.Rendered"); return nil end
            local rift = rifts:FindFirstChild("rainbow-egg")
            if not rift then print("rainbow-egg not found in Rifts"); return nil end
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
            if not rift then print("rainbow-egg not found for timer"); return nil end
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
            if not rift then print("rainbow-egg not found for luck"); return nil end
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
        end,
        Hauteur = function()
            print("Checking Rainbow Egg height...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found for height"); return nil end
            local rift = rifts:FindFirstChild("rainbow-egg")
            if not rift then print("rainbow-egg not found for height"); return nil end
            local decoration = rift:FindFirstChild("Decoration")
            if not decoration then print("Decoration not found for height"); return nil end
            print("Rainbow Egg height found: " .. tostring(decoration.Position.Y))
            return decoration.Position.Y
        end
    },
    VOID_EGG = {
        Chemin = function()
            print("Checking Void Egg path...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found in Workspace.Rendered"); return nil end
            local rift = rifts:FindFirstChild("void-egg")
            if not rift then print("void-egg not found in Rifts"); return nil end
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
            if not rift then print("void-egg not found for timer"); return nil end
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
            if not rift then print("void-egg not found for luck"); return nil end
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
        end,
        Hauteur = function()
            print("Checking Void Egg height...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found for height"); return nil end
            local rift = rifts:FindFirstChild("void-egg")
            if not rift then print("void-egg not found for height"); return nil end
            local decoration = rift:FindFirstChild("Decoration")
            if not decoration then print("Decoration not found for height"); return nil end
            print("Void Egg height found: " .. tostring(decoration.Position.Y))
            return decoration.Position.Y
        end
    },
    NIGHTMARE_EGG = {
        Chemin = function()
            print("Checking Nightmare Egg path...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found in Workspace.Rendered"); return nil end
            local rift = rifts:FindFirstChild("nightmare-egg")
            if not rift then print("nightmare-egg not found in Rifts"); return nil end
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
            if not rift then print("nightmare-egg not found for timer"); return nil end
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
            if not rift then print("nightmare-egg not found for luck"); return nil end
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
        end,
        Hauteur = function()
            print("Checking Nightmare Egg height...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found for height"); return nil end
            local rift = rifts:FindFirstChild("nightmare-egg")
            if not rift then print("nightmare-egg not found for height"); return nil end
            local decoration = rift:FindFirstChild("Decoration")
            if not decoration then print("Decoration not found for height"); return nil end
            print("Nightmare Egg height found: " .. tostring(decoration.Position.Y))
            return decoration.Position.Y
        end
    },
    CYBER_EGG = {
        Chemin = function()
            print("Checking Cyber Egg path...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found in Workspace.Rendered"); return nil end
            local rift = rifts:FindFirstChild("cyber-egg")
            if not rift then print("cyber-egg not found in Rifts"); return nil end
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
            if not rift then print("cyber-egg not found for timer"); return nil end
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
            if not rift then print("cyber-egg not found for luck"); return nil end
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
        end,
        Hauteur = function()
            print("Checking Cyber Egg height...")
            local rifts = Workspace.Rendered:FindFirstChild("Rifts")
            if not rifts then print("Rifts not found for height"); return nil end
            local rift = rifts:FindFirstChild("cyber-egg")
            if not rift then print("cyber-egg not found for height"); return nil end
            local decoration = rift:FindFirstChild("Decoration")
            if not decoration then print("Decoration not found for height"); return nil end
            print("Cyber Egg height found: " .. tostring(decoration.Position.Y))
            return decoration.Position.Y
        end
    }
}

-- Fonction pour envoyer un webhook
local function envoyerWebhook(nomFaille, tempsRestant, chance, urlWebhook)
    print("Attempting to send webhook for " .. nomFaille)
    local hauteur = CHEMINS_FAILLES[nomFaille].Hauteur()
    if not hauteur then
        print("Failed to get hauteur for " .. nomFaille)
        return
    end
    local multiplicateur = chance or "Unknown"
    local joueurs = tostring(#Players:GetPlayers()) .. "/" .. tostring(Players.MaxPlayers or 100)
    local jobId = game.JobId or "unknown_jobid"
    local joinUrl = "https://joinbgsi.shop/?placeID=85896571713843&gameInstanceId=" .. jobId

    local embed = {
        title = nomFaille .. " Trouvé !",
        color = 0x00FF00,
        fields = {
            {name = "Type de Faille", value = nomFaille, inline = true},
            {name = "Temps Restant", value = tempsRestant, inline = true},
            {name = "Hauteur", value = tostring(math.floor(hauteur)), inline = true},
            {name = "Multiplicateur", value = multiplicateur, inline = true},
            {name = "Nombre de Joueurs", value = joueurs, inline = true},
            {name = "Téléportation", value = "[Rejoindre Serveur](" .. joinUrl .. ")", inline = true},
            {name = "JobID", value = jobId, inline = true}
        },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }
    
    if CONFIG.ID_DISCORD and CONFIG.ID_DISCORD ~= "" then
        embed.content = "<@" .. CONFIG.ID_DISCORD .. ">"
    end
    
    local payload = {
        embeds = {embed}
    }
    
    local cibleWebhook = urlWebhook
    if not cibleWebhook or cibleWebhook == "" then
        error("No valid webhook URL for " .. nomFaille .. ", you fucked up!")
        return
    end
    
    local succes, erreur = pcall(function()
        if HttpService.PostAsync then
            HttpService:PostAsync(cibleWebhook, HttpService:JSONEncode(payload), Enum.HttpContentType.ApplicationJson)
        elseif HttpService.request then
            HttpService:request({Url = cibleWebhook, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = HttpService:JSONEncode(payload)})
        else
            error("Webhook sending not supported by this executor")
        end
    end)
    
    if not succes then
        warn("Échec de l'envoi du webhook pour " .. nomFaille .. " : " .. tostring(erreur))
    else
        print("Webhook sent for " .. nomFaille .. " successfully!")
    end
end

-- Fonction pour vérifier les failles
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
                    envoyerWebhook(nomFaille, texteMinuteur, chance, configFaille.WEBHOOK_URL)
                else
                    print(nomFaille .. " timer not found")
                end
            else
                print(nomFaille .. " path does not exist")
            end
        end
    end
end

-- Fonction pour initial scan
local function initialScan()
    print("Starting initial scan of rifts...")
    for nomFaille, donneesFaille in pairs(CHEMINS_FAILLES) do
        local configFaille = CONFIG.FAILES[nomFaille]
        if configFaille and configFaille.ACTIVE then
            print("Initial scan for " .. nomFaille .. "...")
            local chemin = donneesFaille.Chemin()
            if chemin and chemin.Parent then
                print(nomFaille .. " path exists in initial scan!")
                local minuteur = donneesFaille.Minuteur()
                if minuteur then
                    print(nomFaille .. " timer exists in initial scan!")
                    local texteMinuteur = minuteur.Text or "N/A"
                    local chance = nil
                    if donneesFaille.Chance then
                        local chanceObj = donneesFaille.Chance()
                        if chanceObj then
                            local texteChance = (chanceObj.Text or ""):upper()
                            if table.find(CONFIG.SNIPE_LUCK, texteChance) then
                                chance = texteChance
                                print(nomFaille .. " luck matches in initial scan: " .. texteChance)
                            else
                                print(nomFaille .. " luck does not match in initial scan: " .. texteChance)
                            end
                        else
                            print(nomFaille .. " luck object not found in initial scan")
                        end
                    end
                    envoyerWebhook(nomFaille, texteMinuteur, chance, configFaille.WEBHOOK_URL)
                    print("Initial detection of " .. nomFaille .. " with time: " .. texteMinuteur)
                else
                    print(nomFaille .. " timer not found in initial scan")
                end
            else
                print(nomFaille .. " path does not exist in initial scan")
            end
        end
    end
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

-- Boucle principale
while true do
    verifierFailles()
    wait(CONFIG.INTERVALLE_VERIFICATION or 5)
    
    -- Changer de serveur après l'intervalle
    if os.time() % (CONFIG.INTERVALLE_CHANGEMENT_SERVEUR or 300) < (CONFIG.INTERVALLE_VERIFICATION or 5) then
        changerServeur()
    end
end
