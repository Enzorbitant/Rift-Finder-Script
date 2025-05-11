local function envoyerWebhook(nomFaille, tempsRestant, chance, urlWebhook)
    print("Attempting to send webhook for " .. nomFaille .. " to " .. tostring(urlWebhook))
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
    if not cibleWebhook or cibleWebhook == "" or cibleWebhook == "VOTRE_WEBHOOK_" .. nomFaille .. "_ICI" then
        warn("No valid webhook URL for " .. nomFaille .. ", you fucked up! Set a proper URL in RiftFindersConfig.lua")
        return
    end
    
    local encodedPayload = HttpService:JSONEncode(payload)
    print("Webhook payload: " .. encodedPayload)

    local succes, erreur = pcall(function()
        if HttpService.PostAsync then
            local response = HttpService:PostAsync(cibleWebhook, encodedPayload, Enum.HttpContentType.ApplicationJson)
            print("Webhook response: " .. tostring(response))
        elseif HttpService.request then
            local response = HttpService:request({
                Url = cibleWebhook,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = encodedPayload
            })
            print("Webhook response: " .. tostring(response.Success) .. " - " .. tostring(response.StatusCode) .. " - " .. tostring(response.Body))
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
