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
