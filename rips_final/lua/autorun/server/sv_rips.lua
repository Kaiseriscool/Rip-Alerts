RipAddon = RipAddon or {}

local Gun_1 = {"weapon_pistol", "weapon_357"}

local vs_suit = {
    ["testsuit"] = "Test Suit!",
}

RipAddon.UseVS_Suit = false -- true means we use it

local armor6 = {
    ["Name of suit1"] = "Suit 1",
    ["Name of suit2"] = "Suit 2",
}

RipAddon.UseArmor6 = false -- true means we use it

local vnp_suits = {
    ["Name of suit1"] = "Print name!",
    ["Name of suit2"] = "Print name2!",
}

RipAddon.UseVNP = false -- true means we use it
util.AddNetworkString("RipAddonTXT")

hook.Add("DoPlayerDeath", "RipAddon:RIPDamage", function(deadperson, attacker, dmginfo)
    if not deadperson or not IsValid(deadperson) or not deadperson:IsPlayer() then return end -- if player not player stop
    if not attacker or not IsValid(attacker) or not attacker:IsPlayer() then return end -- if attacker is not player stop
    local ripped = ""
    local amt = 0

    for k, v in ipairs(deadperson:GetWeapons()) do
        if table.HasValue(deadperson:getJobTable().weapons, v:GetClass()) then continue end

        if table.HasValue(Gun_1, v:GetClass()) then
            local name_wep = v:GetPrintName()

            if name_wep == "Scripted Weapon" then
                name_Wep = v:GetClass()
            end

            if ripped ~= "" then
                amt = 2
            end

            if ripped == "" then
                ripped = name_wep
                amt = 1
            end

            if amt > 1 then
                ripped = ripped .. ", " .. name_wep
            end
        end
    end

    if ripped ~= "" then
        RipAddon.MsgSV("Weapon Rips", Color(255, 0, 0), attacker:Nick() .. " ripped " .. deadperson:Nick() .. "'s " .. ripped)

        sendDiscordMessage(tostring(attacker:Nick() .. "(" .. attacker:SteamID() .. ")"), tostring(deadperson:Nick() .. "(" .. deadperson:SteamID() .. ")"), tostring(ripped))
    end
end)

function RipAddon.MsgSV(tag, col, msg, ply)
    net.Start("RipAddonTXT")
    net.WriteString(tag)
    net.WriteColor(col)
    net.WriteString(msg)

    if ply then
        net.Send(ply)
    else
        net.Broadcast()
    end
end

hook.Add("PlayerDeath", "VS_SUIT_RIPS", function(deadperson, attacker, dmginfo)
    if not RipAddon.UseVS_Suit then return end
    local txt = ""
    if not deadperson or not IsValid(deadperson) or not deadperson:IsPlayer() then return end -- if player not player stop
    if not attacker or not IsValid(attacker) or not attacker:IsPlayer() then return end -- if attacker is not player stop
    if not VectivusSuits:GetPlayerSuit(deadperson, true) then return end

    if vs_suit[VectivusSuits:GetPlayerSuit(deadperson)] then
        txt = VectivusSuits:GetPlayerSuit(deadperson)

        if txt ~= "" then
            RipAddon.MsgSV("Suit Rips", Color(255, 0, 0), attacker:Nick() .. " ripped " .. deadperson:Nick() .. "'s " .. vs_suit[txt])

            sendDiscordMessage(tostring(attacker:Nick() .. "(" .. attacker:SteamID() .. ")"), tostring(deadperson:Nick() .. "(" .. deadperson:SteamID() .. ")"), tostring(vs_suit[txt]))
        end
    end
end)

hook.Add("PlayerDeath", "Armor_6_Rips", function(deadperson, attacker, dmginfo)
    if not RipAddon.UseArmor6 then return end
    local txt = ""
    if not deadperson or not IsValid(deadperson) or not deadperson:IsPlayer() then return end -- if player not player stop
    if not attacker or not IsValid(attacker) or not attacker:IsPlayer() then return end -- if attacker is not player stop
    local d = Armor:Get(deadperson.armorSuit)
    if not d then return end

    if armor6[d.Name] then
        txt = armor6[d.Name] or d.Name

        if txt ~= "" then
            RipAddon.MsgSV("Suit Rips", Color(255, 0, 0), attacker:Nick() .. " ripped " .. deadperson:Nick() .. "'s " .. txt)

            sendDiscordMessage(tostring(attacker:Nick() .. "(" .. attacker:SteamID() .. ")"), tostring(deadperson:Nick() .. "(" .. deadperson:SteamID() .. ")"), tostring(txt))
        end
    end
end)

hook.Add("PlayerDeath", "VNP_SUITS", function(deadperson, attacker, dmginfo)
    if not RipAddon.UseVNP then return end
    local d = deadperson:GetSuit()
    local txt = ""
    if not deadperson or not IsValid(deadperson) or not deadperson:IsPlayer() then return end -- if player not player stop
    if not attacker or not IsValid(attacker) or not attacker:IsPlayer() then return end -- if attacker is not player stop
    if not d then return end

    if vnp_suits[d.Name] then
        txt = vnp_suits[d.Name] or d.Name

        if txt ~= "" then
            RipAddon.MsgSV("Suit Rips", Color(255, 0, 0), attacker:Nick() .. " ripped " .. deadperson:Nick() .. "'s " .. txt)

            sendDiscordMessage(tostring(attacker:Nick() .. "(" .. attacker:SteamID() .. ")"), tostring(deadperson:Nick() .. "(" .. deadperson:SteamID() .. ")"), tostring(txt))
        end
    end
end)

RipAddon.Version = "5.1"

hook.Add("Think", "RipAddon.VersionChecker", function()
    hook.Remove("Think", "RipAddon.VersionChecker")

    http.Fetch("https://raw.githubusercontent.com/Kaiseriscool/Rip-Alerts/main/VERSION", function(body)
        if RipAddon.Version ~= string.Trim(body) then
            local red = color_red
            MsgC(red, "[Rip Tracker] There is an update available, please download it at: https://github.com/Kaiseriscool/Rip-Alerts\n")
            MsgC(red, "\nYour version: " .. RipAddon.Version .. "\n")
            MsgC(red, "New  version: " .. body .. "\n")

            return
        end
    end)
end)
