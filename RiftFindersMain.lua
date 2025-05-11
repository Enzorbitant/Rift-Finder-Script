-- Obfuscation couche 1 : Vérification d'intégrité
local _0x1a2b3c = function() if not getgenv() then return false end return true end
if not _0x1a2b3c() then error("\u{1F525}\u{1F4A5}") end

-- Obfuscation couche 2 : Chiffrement XOR
local function _0x7d8e9f(s, k)
    local r = ""
    for i = 1, #s do r = r .. string.char(bit32.bxor(string.byte(s, i), k)) end
    return r
end

-- Obfuscation couche 3 : Code poubelle
local _0x4b5c6d = function() local _ = math.random(1, 1000) for _ = 1, _ do end end
_0x4b5c6d()

-- Services obfusqués
local _0x9a1b2c = game:GetService(_0x7d8e9f("\115\116\117\118\119\120\121\122", 42))
local _0x3d4e5f = game:GetService(_0x7d8e9f("\84\101\108\101\112\111\114\116\83\101\114\118\105\99\101", 42))
local _0x6g7h8i = game:GetService(_0x7d8e9f("\87\111\114\107\115\112\97\99\101", 42))
local _0x2j3k4l = game:GetService(_0x7d8e9f("\80\108\97\121\101\114\115", 42))
local _0x5m6n7o = game:GetService(_0x7d8e9f("\82\98\120\65\110\97\108\121\116\105\99\115\83\101\114\118\105\99\101", 42))

-- Vérification config
if not getgenv().RiftFindersConfig then
    error(_0x7d8e9f("\67\111\110\102\105\103\117\114\97\116\105\111\110\32\82\105\102\116\70\105\110\100\101\114\115\32\105\110\116\114\111\117\118\97\98\108\101", 42))
end

-- Charger config
local _0x8p9q0r = getgenv().RiftFindersConfig
local _0x1s2t3u = _0x8p9q0r.CLE_SCRIPT

-- Clés chiffrées
local _0x4v5w6x = {
    [_0x7d8e9f("\21\10\19\28\11\45\22\14\17\12\45\31\14\12\19\29\45\23\17\18\24\20\45\30\13\11\25\18", 42)] = {HWID = nil, Comptes = {}},
    [_0x7d8e9f("\30\12\11\25\19\45\17\24\18\17\23\45\31\19\30\12\10\45\28\29\21\30\23\45\13\14\17\30\25", 42)] = {HWID = nil, Comptes = {}},
    [_0x7d8e9f("\28\17\18\17\21\45\29\20\14\17\12\45\30\12\11\10\28\45\17\24\19\31\23\45\30\14\13\19\25", 42)] = {HWID = nil, Comptes = {}},
    [_0x7d8e9f("\25\11\19\30\12\45\17\29\10\28\14\45\31\30\21\21\17\45\24\18\23\22\12\45\23\14\14\13\29", 42)] = {HWID = nil, Comptes = {}},
    [_0x7d8e9f("\14\19\23\31\18\45\30\17\24\28\17\45\29\21\30\14\24\45\13\10\25\19\30\45\26\30\26\12\14", 42)] = {HWID = nil, Comptes = {}},
    [_0x7d8e9f("\18\30\22\21\24\45\10\23\11\17\31\45\19\24\14\28\12\45\30\14\29\19\17\45\13\25\26\23\30", 42)] = {HWID = nil, Comptes = {}},
    [_0x7d8e9f("\31\30\21\23\14\45\17\14\19\28\30\45\29\18\17\24\12\45\11\24\19\26\30\45\13\25\27\24\24", 42)] = {HWID = nil, Comptes = {}},
    [_0x7d8e9f("\24\26\17\19\28\45\31\14\19\29\30\45\14\13\30\26\12\45\10\21\17\24\17\45\22\19\14\18\18", 42)] = {HWID = nil, Comptes = {}},
    [_0x7d8e9f("\10\24\21\30\17\45\31\25\19\17\24\45\30\26\30\12\29\45\28\14\21\14\18\45\18\19\23\27\26", 42)] = {HWID = nil, Comptes = {}},
    [_0x7d8e9f("\14\13\26\24\29\45\23\30\17\18\14\45\21\10\31\19\17\45\25\19\30\14\24\45\28\17\30\12\20", 42)] = {HWID = nil, Comptes = {}}
}

-- Vérification de la clé
local function _0x7y8z9a()
    _0x4b5c6d()
    local _0xa1b2c3 = _0x5m6n7o:GetClientId()
    local _0xd4e5f6 = _0x2j3k4l.LocalPlayer.UserId
    local _0xg7h8i9 = _0x4v5w6x[_0x1s2t3u]
    if not _0xg7h8i9 then
        error(_0x7d8e9f("\67\108\233\32\105\110\118\97\108\105\100\101\46\32\69\120\233\99\117\116\105\111\110\32\97\114\114\234\116\233\101", 42))
    end
    if not _0xg7h8i9.HWID then
        _0xg7h8i9.HWID = _0xa1b2c3
    end
    if _0xg7h8i9.HWID ~= _0xa1b2c3 then
        error(_0x7d8e9f("\67\108\233\32\108\105\233\101\32\224\32\117\110\32\97\117\116\114\101\32\72\87\73\68", 42))
    end
    if not _0xg7h8i9.Comptes[_0xd4e5f6] then
        _0xg7h8i9.Comptes[_0xd4e5f6] = true
        local _0xj3k4l5 = 0
        for _ in pairs(_0xg7h8i9.Comptes) do _0xj3k4l5 = _0xj3k4l5 + 1 end
        if _0xj3k4l5 > 90 then
            error(_0x7d8e9f("\76\105\109\105\116\101\32\100\101\32\57\48\32\99\111\109\112\116\101\115\32\97\116\116\101\105\110\116\101", 42))
        end
    end
end
_0x7y8z9a()

-- Définitions des failles chiffrées
local _0xm6n7o8 = {
    ROYAL_CHEST = {
        Chemin = _0x6g7h8i.Rendered.Rifts[_0x7d8e9f("\114\111\121\97\108\45\99\104\101\115\116", 42)].Decoration.Model.islandbottom_collision.MeshPart,
        Minuteur = _0x6g7h8i.Rendered.Rifts[_0x7d8e9f("\114\111\121\97\108\45\99\104\101\115\116", 42)].Display.SurfaceGui.Timer
    },
    GOLDEN_CHEST = {
        Chemin = _0x6g7h8i.Rendered.Rifts[_0x7d8e9f("\103\111\108\100\101\110\45\99\104\101\115\116", 42)].Decoration[_0x7d8e9f("\77\101\115\104\101\115\47\102\108\111\97\116\105\110\103\105\115\108\97\110\100\49\95\67\105\114\99\108\101\46\48\48\50", 42)],
        Minuteur = _0x6g7h8i.Rendered.Rifts[_0x7d8e9f("\103\111\108\100\101\110\45\99\104\101\115\116", 42)].Display.SurfaceGui.Timer
    },
    DICE_CHEST = {
        Chemin = _0x6g7h8i.Rendered.Rifts:GetChildren()[8].Decoration[_0x7d8e9f("\77\101\115\104\101\115\47\102\108\111\97\116\105\110\103\105\115\108\97\110\100\49\95\67\105\114\99\108\101\46\48\48\50", 42)],
        Minuteur = _0x6g7h8i.Rendered.Rifts:GetChildren()[8].Display.SurfaceGui.Timer
    },
    RAINBOW_EGG = {
        Chemin = _0x6g7h8i.Rendered.Rifts:GetChildren()[9].Decoration[_0x7d8e9f("\77\101\115\104\101\115\47\102\108\111\97\116\105\110\103\105\115\108\97\110\100\49\95\67\105\114\99\108\101\46\48\48\50", 42)],
        Minuteur = _0x6g7h8i.Rendered.Rifts[_0x7d8e9f("\114\97\105\110\98\111\119\45\101\103\103", 42)].Display.SurfaceGui.Timer,
        Chance = _0x6g7h8i.Rendered.Rifts[_0x7d8e9f("\114\97\105\110\98\111\119\45\101\103\103", 42)].Display.SurfaceGui.Icon.Luck
    },
    VOID_EGG = {
        Chemin = _0x6g7h8i.Rendered.Rifts[_0x7d8e9f("\118\111\105\100\45\101\103\103", 42)].Decoration[_0x7d8e9f("\77\101\115\104\101\115\47\102\108\111\97\116\105\110\103\105\115\108\97\110\100\49\95\67\105\114\99\108\101\46\48\48\50", 42)],
        Minuteur = _0x6g7h8i.Rendered.Rifts[_0x7d8e9f("\118\111\105\100\45\101\103\103", 42)].Display.SurfaceGui.Timer,
        Chance = _0x6g7h8i.Rendered.Rifts[_0x7d8e9f("\118\111\105\100\45\101\103\103", 42)].Display.SurfaceGui.Icon.Luck
    },
    NIGHTMARE_EGG = {
        Chemin = _0x6g7h8i.Rendered.Rifts[_0x7d8e9f("\110\105\103\104\116\109\97\114\101\45\101\103\103", 42)].Decoration[_0x7d8e9f("\77\101\115\104\101\115\47\102\108\111\97\116\105\110\103\105\115\108\97\110\100\49\95\67\105\114\99\108\101\46\48\48\50", 42)],
        Minuteur = _0x6g7h8i.Rendered.Rifts[_0x7d8e9f("\110\105\103\104\116\109\97\114\101\45\101\103\103", 42)].Display.SurfaceGui.Timer,
        Chance = _0x6g7h8i.Rendered.Rifts[_0x7d8e9f("\110\105\103\104\116\109\97\114\101\45\101\103\103", 42)].Display.SurfaceGui.Icon.Luck
    },
    CYBER_EGG = {
        Chemin = _0x6g7h8i.Rendered.Rifts[_0x7d8e9f("\99\121\98\101\114\45\101\103\103", 42)].Decoration.Model[_0x7d8e9f("\77\101\115\104\101\115\47\70\108\111\97\116\105\110\103\32\73\115\108\97\110\100\95\67\105\114\99\108\101\46\48\48\52\32\40\50\41", 42)],
        Minuteur = _0x6g7h8i.Rendered.Rifts[_0x7d8e9f("\99\121\98\101\114\45\101\103\103", 42)].Display.SurfaceGui.Timer,
        Chance = _0x6g7h8i.Rendered.Rifts[_0x7d8e9f("\99\121\98\101\114\45\101\103\103", 42)].Display.SurfaceGui.Icon.Luck
    }
}

-- Fonction webhook obfusquée
local function _0xp9q0r1(n, t, c, u)
    _0x4b5c6d()
    local e = {
        title = _0x7d8e9f("\70\97\105\108\108\101\32\68\233\116\101\99\116\233\101\32\33", 42),
        color = 0x00FF00,
        fields = {
            {name = _0x7d8e9f("\84\121\112\101\32\100\101\32\70\97\105\108\108\101", 42), value = n, inline = true},
            {name = _0x7d8e9f("\84\101\109\112\115\32\82\101\115\116\97\110\116", 42), value = t, inline = true}
        },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }
    if c then table.insert(e.fields, {name = _0x7d8e9f("\67\104\97\110\99\101", 42), value = c, inline = true}) end
    if _0x8p9q0r.AFFICHER_ID_SERVEUR then
        table.insert(e.fields, {name = _0x7d8e9f("\73\68\32\83\101\114\118\101\117\114", 42), value = game.JobId, inline = true})
    end
    if _0x8p9q0r.ID_DISCORD and _0x8p9q0r.ID_DISCORD ~= "" then
        e.content = "<@" .. _0x8p9q0r.ID_DISCORD .. ">"
    end
    local p = {embeds = {e}}
    local w = u or _0x8p9q0r.WEBHOOK_PAR_DEFAUT
    if not w or w == "" then warn(_0x7d8e9f("\65\117\99\117\110\101\32\85\82\76\32\100\101\32\119\101\98\104\111\111\107\32\118\97\108\105\100\101", 42) .. n) return end
    local s, e = pcall(function()
        _0x9a1b2c:PostAsync(w, _0x9a1b2c:JSONEncode(p), Enum.HttpContentType.ApplicationJson)
    end)
    if not s then warn(_0x7d8e9f("\201\99\104\101\99\32\119\101\98\104\111\111\107\32\112\111\117\114\32", 42) .. n .. ": " .. tostring(e)) end
end

-- Vérification failles obfusquée
local function _0xs2t3u4()
    for n, d in pairs(_0xm6n7o8) do
        local cf = _0x8p9q0r.FAILES[n]
        if cf and cf.ACTIVE then
            local ex = pcall(function() return d.Chemin.Parent ~= nil end)
            if ex then
                local tm = d.Minuteur.Text
                local m = tonumber(tm:match("(%d+)%s*min")) or 0
                if m >= _0x8p9q0r.TEMPS_MINIMUM_WEBHOOK then
                    local c = nil
                    if d.Chance then
                        local tc = d.Chance.Text:upper()
                        if table.find(_0x8p9q0r.CHANCE_CIBLE, tc) then c = tc else goto continue end
                    end
                    _0xp9q0r1(n, tm, c, cf.WEBHOOK_URL)
                end
                ::continue::
            end
        end
    end
end

-- Changer serveur obfusqué
local function _0xv5w6x7()
    _0x4b5c6d()
    local s, e = pcall(function() _0x3d4e5f:Teleport(game.PlaceId, _0x2j3k4l.LocalPlayer) end)
    if not s then
        warn(_0x7d8e9f("\201\99\104\101\99\32\99\104\97\110\103\101\109\101\110\116\32\115\101\114\118\101\117\114\32", 42) .. tostring(e))
        wait(10)
        _0xv5w6x7()
    end
end

-- Anti-dump
local _0xy8z9a0 = function()
    if getfenv().debug then error(_0x7d8e9f("\68\233\116\101\99\116\105\111\110\32\100\101\32\116\101\110\116\97\116\105\118\101\32\100\101\32\100\117\109\112", 42)) end
end
_0xy8z9a0()

-- Boucle principale
while true do
    _0xs2t3u4()
    wait(_0x8p9q0r.INTERVALLE_VERIFICATION)
    if os.time() % _0x8p9q0r.INTERVALLE_CHANGEMENT_SERVEUR < _0x8p9q0r.INTERVALLE_VERIFICATION then
        _0xv5w6x7()
    end
end
