-- Vérifier que la config existe
if not getgenv().RiftFindersConfig then
    error("Configuration RiftFinders introuvable. Chargez d'abord le script de configuration.")
end

-- Services
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

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
    local hwid = RbxAnalyticsService:GetClientId()
    local userId = Players.LocalPlayer.UserId
    local donneesCle = CLES_VALABLES[cle_script]

    if not donneesCle then
        error("Clé invalide. Exécution du script arrêtée.")
    end

    -- Si aucun HWID n'est associé, lier la clé à ce HWID
    if not donneesCle.HWID then
        donneesCle.HWID = hwid
    end

    -- Vérifier si le HWID correspond
    if donneesCle.HWID ~= hwid then
        error("Clé liée à un autre HWID. Exécution du script arrêtée.")
    end

    -- Vérifier le nombre de comptes
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
        Chemin = Workspace.Rendered.Rifts["royal-chest"].Decoration.Model.islandbottom_collision.MeshPart,
        Minuteur = Workspace.Rendered.Rifts["royal-chest"].Display.SurfaceGui.Timer,
        Hauteur = Workspace.Rendered.Rifts["royal-chest"].Decoration.Model.Position.Y
    },
    GOLDEN_CHEST = {
        Chemin = Workspace.Rendered.Rifts["golden-chest"].Decoration["Meshes/floatingisland1_Circle.002"],
        Minuteur = Workspace.Rendered.Rifts["golden-chest"].Display.SurfaceGui.Timer,
        Hauteur = Workspace.Rendered.Rifts["golden-chest"].Decoration.Model.Position.Y
    },
    DICE_CHEST = {
        Chemin = Workspace.Rendered.Rifts:GetChildren()[8].Decoration["Meshes/floatingisland1_Circle.002"],
        Minuteur = Workspace.Rendered.Rifts:GetChildren()[8].Display.SurfaceGui.Timer,
        Hauteur = Workspace.Rendered.Rifts:GetChildren()[8].Decoration.Model.Position.Y
    },
    RAINBOW_EGG = {
        Chemin = Workspace.Rendered.Rifts:GetChildren()[9].Decoration["Meshes/floatingisland1_Circle.002"],
        Minuteur = Workspace.Rendered.Rifts["rainbow-egg"].Display.SurfaceGui.Timer,
        Chance = Workspace.Rendered.Rifts["rainbow-egg"].Display.SurfaceGui.Icon.Luck,
        Hauteur = Workspace.Rendered.Rifts:GetChildren()[9].Decoration.Model.Position.Y
    },
    VOID_EGG = {
        Chemin = Workspace.Rendered.Rifts["void-egg"].Decoration["Meshes/floatingisland1_Circle.002"],
        Minuteur = Workspace.Rendered.Rifts["void-egg"].Display.SurfaceGui.Timer,
        Chance = Workspace.Rendered.Rifts["void-egg"].Display.SurfaceGui.Icon.Luck,
        Hauteur = Workspace.Rendered.Rifts["void-egg"].Decoration.Model.Position.Y
    },
    NIGHTMARE_EGG = {
        Chemin = Workspace.Rendered.Rifts["nightmare-egg"].Decoration["Meshes/floatingisland1_Circle.002"],
        Minuteur = Workspace.Rendered.Rifts["nightmare-egg"].Display.SurfaceGui.Timer,
        Chance = Workspace.Rendered.Rifts["nightmare-egg"].Display.SurfaceGui.Icon.Luck,
        Hauteur = Workspace.Rendered.Rifts["nightmare-egg"].Decoration.Model.Position.Y
    },
    CYBER_EGG = {
        Chemin = Workspace.Rendered.Rifts["cyber-egg"].Decoration.Model["Meshes/Floating Island_Circle.004 (2)"],
        Minuteur = Workspace.Rendered.Rifts["cyber-egg"].Display.SurfaceGui.Timer,
        Chance = Workspace.Rendered.Rifts["cyber-egg"].Display.SurfaceGui.Icon.Luck,
        Hauteur = Workspace.Rendered.Rifts["cyber-egg"].Decoration.Model.Position.Y
    }
}

-- Fonction pour envoyer un webhook
local function envoyerWebhook(nomFaille, tempsRestant, chance, urlWebhook)
    local hauteur = CHEMINS_FAILLES[nomFaille].Hauteur
    local multiplicateur = chance or "Unknown"
    local joueurs = tostring(#Players:GetPlayers()) .. "/" .. tostring(game.Players.MaxPlayers)
    local jobId = game.JobId
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
        HttpService:PostAsync(cibleWebhook, HttpService:JSONEncode(payload), Enum.HttpContentType.ApplicationJson)
    end)
    
    if not succes then
        warn("Échec de l'envoi du webhook pour " .. nomFaille .. " : " .. tostring(erreur))
    end
end

-- Fonction pour vérifier les failles
local function verifierFailles()
    for nomFaille, donneesFaille in pairs(CHEMINS_FAILLES) do
        local configFaille = CONFIG.FAILES[nomFaille]
        if configFaille and configFaille.ACTIVE then
            local existe = pcall(function()
                return donneesFaille.Chemin.Parent ~= nil
            end)
            
            if existe then
                local texteMinuteur = donneesFaille.Minuteur.Text
                local chance = nil
                if donneesFaille.Chance then
                    local texteChance = donneesFaille.Chance.Text:upper()
                    if table.find(CONFIG.CHANCE_CIBLE, texteChance) then
                        chance = texteChance
                    else
                        continue
                    end
                end
                envoyerWebhook(nomFaille, texteMinuteur, chance, configFaille.WEBHOOK_URL)
            end
        end
    end
end

-- Fonction pour changer de serveur
local function changerServeur()
    if CONFIG.HOP_SERVER then
        local succes, erreur = pcall(function()
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
        end)
        if not succes then
            warn("Hop failed, you dumbass: " .. tostring(erreur))
            wait(10)
            changerServeur()
        end
    else
        local succes, erreur = pcall(function()
            TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
        end)
        if not succes then
            warn("Teleport failed, shithead: " .. tostring(erreur))
            wait(10)
            changerServeur()
        end
    end
end

-- Boucle principale
while true do
    verifierFailles()
    wait(CONFIG.INTERVALLE_VERIFICATION)
    
    -- Changer de serveur après l'intervalle
    if os.time() % CONFIG.INTERVALLE_CHANGEMENT_SERVEUR < CONFIG.INTERVALLE_VERIFICATION then
        changerServeur()
    end
end
