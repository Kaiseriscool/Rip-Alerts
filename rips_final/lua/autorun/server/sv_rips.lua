
RipAddon = RipAddon or {}

local Gun_1 = {
  "weapon_pistol",
  "weapon_357"
}

local vs_suit = {
    ["testsuit"] = "Test Suit!",
}


RipAddon.UseVS_Suit = false -- true means we use it

local armor6 = {
    "Name of suit1",
    "Name of suit2"
}

RipAddon.UseArmor6 = false -- true means we use it

local vnp_suits = {
    "Name of suit1",
    "Name of suit2"
}

RipAddon.UseVNP = false -- true means we use it


util.AddNetworkString("RipAddonTXT")
hook.Add("DoPlayerDeath", "RipAddon:RIPDamage", function(deadperson, attacker, dmginfo)
    if not deadperson or not IsValid(deadperson) or not deadperson:IsPlayer() then return end -- if player not player stop
    if not attacker or not IsValid(attacker) or not attacker:IsPlayer() then return end -- if attacker is not player stop
    local ripped = ""
    local amt = 0

    for k, v in ipairs(deadperson:GetWeapons()) do
        if table.HasValue(deadperson:getJobTable().weapons, v:GetClass()) then
            continue
        end

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
        for _, all in pairs(player.GetAll()) do
            RipAddon.MsgSV("Weapon Rips", Color(255, 0, 0), attacker:Nick() .. " ripped " .. deadperson:Nick() .. "'s " .. ripped)
        end

        local msg2 = "Attacker: " .. attacker:Nick() .. " \n Loser: " .. deadperson:Nick() .. " \n Weapon Lost: " .. ripped
        DiscordMessage("**__Normal Weapon__**", msg2)
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

hook.Add("PlayerDeath" , "VS_SUIT_RIPS" , function(deadperson, attacker, dmginfo)
    if !RipAddon.UseVS_Suit then return end
    local txt = ""
    if not deadperson or not IsValid(deadperson) or not deadperson:IsPlayer() then return end -- if player not player stop
    if not attacker or not IsValid(attacker) or not attacker:IsPlayer() then return end -- if attacker is not player stop
    if !VectivusSuits:GetPlayerSuit( deadperson, true ) then return end
    if vs_suit[ VectivusSuits:GetPlayerSuit(deadperson) ] then
    txt = VectivusSuits:GetPlayerSuit(deadperson)
    if txt ~= "" then
        for _, all in pairs(player.GetAll()) do
            RipAddon.MsgSV("Suit Rips", Color(255, 0, 0), attacker:Nick() .. " ripped " .. deadperson:Nick() .. "'s " .. vs_suit[txt])
        end

        --local msg3 = "Attacker: " .. attacker:Nick() .. " \n Loser: " .. deadperson:Nick() .. " \n Suit Lost: " .. vs_suit[txt]
       sendDiscordMessage(tostring(attacker:Nick().."("..attacker:SteamID()..")"), tostring(deadperson:Nick().."("..deadperson:SteamID()..")"), totring(vs_suit[txt]))
    end
    end
end)


hook.Add("PlayerDeath" , "Armor_6_Rips" , function(deadperson, attacker, dmginfo)
    if !RipAddon.UseArmor6 then return end
    local d = Armor:Get(deadperson.armorSuit)
    local txt = ""
    if not deadperson or not IsValid(deadperson) or not deadperson:IsPlayer() then return end -- if player not player stop
    if not attacker or not IsValid(attacker) or not attacker:IsPlayer() then return end -- if attacker is not player stop
    if !d then return end
    if table.HasValue(armor6 , d.Name) then
    txt = d.Name
    if txt ~= "" then
        RipAddon.MsgSV("Suit Rips", Color(255, 0, 0), attacker:Nick() .. " ripped " .. deadperson:Nick() .. "'s " .. txt)

        local msg3 = "Attacker: " .. attacker:Nick() .. " \n Loser: " .. deadperson:Nick() .. " \n Suit Lost: " .. txt
        DiscordMessage("**__Suit Rips__**", msg3)
    end
    end

end)

hook.Add("PlayerDeath" , "VNP_SUITS" , function(deadperson, attacker, dmginfo)
    if !RipAddon.UseVNP then return end
    local d = deadperson:GetSuit()
    local txt = ""
    if not deadperson or not IsValid(deadperson) or not deadperson:IsPlayer() then return end -- if player not player stop
    if not attacker or not IsValid(attacker) or not attacker:IsPlayer() then return end -- if attacker is not player stop
    if !d then return end
    if table.HasValue(vnp_suits , d.Name) then
    txt = d.Name
    if txt ~= "" then
        RipAddon.MsgSV("Suit Rips", Color(255, 0, 0), attacker:Nick() .. " ripped " .. deadperson:Nick() .. "'s " .. txt)

        local msg3 = "Attacker: " .. attacker:Nick() .. " \n Loser: " .. deadperson:Nick() .. " \n Suit Lost: " .. txt
        DiscordMessage("**__Suit Rips__**", msg3)
    end
    end

end)

hook.Remove("Think", "RipAddon.VersionChecker")
RipAddon.Version = "4.2"
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



