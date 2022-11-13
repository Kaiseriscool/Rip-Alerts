RipAddon = RipAddon or {}

local Gun_1 = {
  "weapon_supreme_badtime_bm_gblaster",
  "amr11"
}

local Guns_2 = {
  "weapon_glock2"
}


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
            RipAddon.MsgSV("Weapon Rips", Color(255, 0, 0), attacker:Nick() .. " ripped " .. deadperson:Nick() .. "'s " .. ripped, all)
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



hook.Remove("Think", "RipAddon.VersionChecker")
RipAddon.Version = "2.0"
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

