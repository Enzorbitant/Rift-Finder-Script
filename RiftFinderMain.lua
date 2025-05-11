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
local RbxAnalyticsService = (game and game:GetService("RbxAnalyticsService")) or {GetClientId = function() return "fallback_hwid" end}

-- Charger la configuration
local CONFIG = getgenv().RiftFindersConfig
local cle_script = CONFIG.CLE_SCRIPT

-- Système de clés
local CLES_VALABLES = {
    ["XK3L9-VT72D-WP5QZ-8MNC4-RY1TB"] = {HWID = nil, Comptes = {}},
    ["92JFQ-MCN28-WQ9DK-LZX18-YT2RF"] = {HWID = nil, Comptes = {}},
    ["LMN2X-Z6P7D-92JKL-MC3W8-RTYQ1"] = {HWID = nil, Comptes = {}},
    ["FJQ93-MZKLP-WR7X2-CN1VD-80TYZ"] = {HWID = nil, Comptes = {}},
    ["PQ8WN-RMCL2-ZX10B-YKFQ9-71EDP"] = {HWID = nil, Comptes = {}},
    ["N3VXC-K8J2W-Q4PLD-9TZQM-YF7AR"] = {HWID = nil, Comptes = {}},
    ["WRX8P-2TQL9-ZNM4D-JCQ71-YF56B"] = {HWID = nil, Comptes = {}},
    ["B7MQL-WPQZ9-TY1ED-KXMC2-VQ03N"] = {HWID = nil, Comptes = {}},
    ["KCX12-WFQMB-R79DZ-LPXT3-NQ84E"] = {HWID = nil, Comptes = {}},
    ["TY7CZ-81MNP-XKWQ2-FQ90B-LMRD4"] = {HWID = nil, Comptes = {}}
}

-- Vérification de la clé
local function verifierCle()
    local hwid = RbxAnalyticsService.GetClientId and RbxAnalyticsService:GetClientId() or "fallback_hwid"
    local userId = Players.LocalPlayer and Players.LocalPlayer.UserId or 0
    local donneesCle = CLES_VALABLES[cle_script]

    if not donneesCle then
        error("Clé invalide. Exécution du script arrêtée.")
    end

    if not donneesCle.HWID then
        donneesCle.HWID = hwid
    end

    if donneesCle.HWID ~= hwid then
        error("Clé liée à un autre HWID. Exécution du script arrêtée.")
    end

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
end

-- Exécuter la vérification de la clé
verifierCle()

-- Définitions des failles
local CHEMINS_FAILLES = {
    ROYAL_CHEST = {
        Chemin = function()
            local rift = Workspace.Rendered.Rifts:FindFirstChild("royal-chest")
            if rift and rift:FindFirstChild("Decoration") then
                local model = rift.Decoration:FindFirstChild("Model")
                if model and model:FindFirstChild("islandbottom_collision") then
                    return model.islandbottom_collision.MeshPart
                end
            end
            return nil
        end,
        Minuteur = function()
            local rift = Workspace.Rendered.Rifts:FindFirstChild("royal-chest")
            if rift and rift:FindFirstChild("Display") then
                return rift.Display.SurfaceGui.Timer
            end
            return nil
        end,
        Hauteur = function()
            local rift = Workspace.Rendered.Rifts:FindFirstChild("royal-chest")
            if rift and rift:FindFirstChild("Decoration") then
                return rift.Decoration.Position.Y
            end
            return nil
        end
    },
    GOLDEN_CHEST = {
        Chemin = function()
            local rift = Workspace.Rendered.Rifts:FindFirstChild("golden-chest")
            if rift and rift:FindFirstChild("Decoration") then
                return rift.Decoration
            end
            return nil
        end,
        Minuteur = function()
            local rift = Workspace.Rendered.Rifts:FindFirstChild("golden-chest")
            if rift and rift:FindFirstChild("Display") then
                return rift.Display.SurfaceGui.Timer
            end
            return nil
        end,
        Hauteur = function()
            local rift = Workspace.Rendered.Rifts:FindFirstChild("golden-chest")
            if rift and rift:FindFirstChild("Decoration") then
                return rift.Decoration.Position.Y
            end
            return nil
        end
    },
    DICE_CHEST = {
        Chemin = function()
            local rift = Workspace.Rendered.Rifts:FindFirstChild("dice-rift")
            if rift and rift:FindFirstChild("Decoration") then
                return rift.Decoration
            end
            return nil
        end,
        Minuteur = function()
            local rift = Workspace.Rendered.Rifts:FindFirstChild("dice-rift")
            if rift and rift:FindFirstChild("Display") then
                return rift.Display.SurfaceGui.Timer
            end
            return nil
        end,
        Hauteur = function()
            local rift = Workspace.Rendered.Rifts:FindFirstChild("dice-rift")
            if rift and rift:FindFirstChild("Decoration") then
                return rift.Decoration.Position.Y
            end
            return nil
        end
    },
    RAINBOW_EGG = {
        Chemin = function()
            local rift = Workspace.Rendered.Rifts:FindFirstChild("rainbow-egg")
            if rift and rift:FindFirstChild("Decoration") then
                return rift.Decoration
            end
            return nil
        end,
        Minuteur = function()
            local rift = Workspace.Rendered.Rifts:FindFirstChild("rainbow-egg")
            if rift and rift:FindFirstChild("Display") then
                return rift.Display.SurfaceGui.Timer
            end
            return nil
        end,
        Chance = function()
            local rift = Workspace.Rendered.Rifts:FindFirstChild("rainbow-egg")
            if rift and rift:FindFirstChild("Display") then
                return rift.Display.SurfaceGui.Icon.Luck
            end
            return nil
        end,
        Hauteur = function()
            local rift = Workspace.Rendered.Rifts:FindFirstChild("rainbow-egg")
            if rift and rift:FindFirstChild("Decoration") then
                return rift.Decoration.Position.Y
            end
            return nil
        end
    },
    VOID_EGG = {
        Chemin = function()
            local rift = Workspace.Rendered.Rifts:FindFirstChild("void-egg")
            if rift and rift:FindFirstChild("Decoration") then
                return rift.Decoration
            end
            return nil
        end,
        Minuteur = function()
            local rift = Workspace.Rendered.Rifts:FindFirstChild("void-egg")
            if rift and rift:FindFirstChild("Display") then
                return rift.Display.SurfaceGui.Timer
            end
            return nil
        end,
        Chance = function()
            local rift = Workspace.Rendered.Rifts:FindFirstChild("void-egg")
            if rift and rift:FindFirstChild("Display") then
                return rift.Display.SurfaceGui.Icon.Luck
            end
            return nil
        end,
        Hauteur = function()
            local rift = Workspace.Rendered.Rifts:FindFirstChild("void-egg")
            if rift and rift:FindFirstChild("Decoration") then
                return rift.Decoration.Position.Y
            end
            return nil
        end
    },
    NIGHTMARE_EGG = {
        Chemin = function()
            local rift = Workspace.Rendered.Rifts:FindFirstChild("nightmare-egg")
            if rift and rift:FindFirstChild("Decoration") then
                return rift.Decoration
            end
            return nil
        end,
        Minuteur = function()
            local rift = Workspace.Rendered.Rifts:FindFirstChild("nightmare-egg")
            if rift and rift:FindFirstChild("Display") then
                return rift.Display.SurfaceGui.Timer
            end
            return nil
        end,
        Chance = function()
            local rift = Workspace.Rendered.Rifts:FindFirstChild("nightmare-egg")
            if rift and rift:FindFirstChild("Display") then
                return rift.Display.SurfaceGui.Icon.Luck
            end
            return nil
        end,
        Hauteur = function()
            local rift = Workspace.Rendered.Rifts:FindFirstChild("nightmare-egg")
            if rift and rift:FindFirstChild("Decoration") then
                return rift.Decoration.Position.Y
            end
            return nil
        end
    },
    CYBER_EGG = {
        Chemin = function()
            local rift = Workspace.Rendered.Rifts:FindFirstChild("cyber-egg")
            if rift and rift:FindFirstChild("Decoration") then
                return rift.Decoration
            end
            return nil
        end,
        Minuteur = function()
            local rift = Workspace.Rendered.Rifts:FindFirstChild("cyber-egg")
            if rift and rift:FindFirstChild("Display") then
                return rift.Display.SurfaceGui.Timer
            end
            return nil
        end,
        Chance = function()
            local rift = Workspace.Rendered.Rifts:FindFirstChild("cyber-egg")
            if rift and rift:FindFirstChild("Display") then
                return rift.Display.SurfaceGui.Icon.Luck
            end
            return nil
        end,
        Hauteur = function()
            local rift = Workspace.Rendered.Rifts:FindFirstChild("cyber-egg")
            if rift and rift:FindFirstChild("Decoration") then
                return rift.Decoration.Position.Y
            end
            return nil
        end
    }
}

-- Fonction pour envoyer un webhook
local function envoyerWebhook(nomFaille, tempsRestant, chance, urlWebhook)
    local hauteur = CHEMINS_FAILLES[nomFaille].Hauteur()
    if not hauteur then return end
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
    for nomFaille, donneesFaille in pairs(CHEMINS_FAILLES) do
        local configFaille = CONFIG.FAILES[nomFaille]
        if configFaille and configFaille.ACTIVE then
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
                            end
                        end
                    end
                    envoyerWebhook(nomFaille, texteMinuteur, chance, configFaille.WEBHOOK_URL)
                end
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
                            end
                        end
                    end
                    envoyerWebhook(nomFaille, texteMinuteur, chance, configFaille.WEBHOOK_URL)
                    print("Initial detection of " .. nomFaille .. " with time: " .. texteMinuteur)
                end
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
