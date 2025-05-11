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

-- Définitions des failles (pas modifié car tout semble correct)
local CHEMINS_FAILLES = { ... } -- raccourci ici pour clarté (aucune erreur de structure détectée)

-- Fonction pour envoyer un webhook
local function envoyerWebhook(nomFaille, tempsRestant, chance, urlWebhook)
    local hauteur = CHEMINS_FAILLES[nomFaille].Hauteur()
    if not hauteur then return end
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

    if not urlWebhook or urlWebhook == "" then
        error("No valid webhook URL for " .. nomFaille)
        return
    end

    local succes, erreur = pcall(function()
        HttpService:PostAsync(urlWebhook, HttpService:JSONEncode(payload), Enum.HttpContentType.ApplicationJson)
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
            local succes, existe = pcall(function()
                local chemin = donneesFaille.Chemin()
                return chemin and chemin.Parent ~= nil
            end)

            if succes and existe then
                local minuteur = donneesFaille.Minuteur()
                if not minuteur then continue end

                local texteMinuteur = minuteur.Text
                local chance = nil

                if donneesFaille.Chance then
                    local chanceObj = donneesFaille.Chance()
                    if not chanceObj then continue end
                    local texteChance = chanceObj.Text:upper()
                    if table.find(CONFIG.SNIPE_LUCK, texteChance) then
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
            warn("Hop failed: " .. tostring(erreur))
            task.wait(10)
            changerServeur()
        end
    else
        local succes, erreur = pcall(function()
            TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
        end)
        if not succes then
            warn("Teleport failed: " .. tostring(erreur))
            task.wait(10)
            changerServeur()
        end
    end
end

-- Boucle principale
while true do
    verifierFailles()
    task.wait(CONFIG.INTERVALLE_VERIFICATION)

    if os.time() % CONFIG.INTERVALLE_CHANGEMENT_SERVEUR < CONFIG.INTERVALLE_VERIFICATION then
        changerServeur()
    end
end
