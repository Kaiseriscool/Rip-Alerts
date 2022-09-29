local Gun_1 = {
    ["weapon_pistol"] = "9mm Pistol",
    ["weapon_rpg"] = "Rocket Propelled Grenade ",
}

local Guns_2 = {
    ["weapon_glock2"] = "Glock",
}

util.AddNetworkString("RipAddon:RIPMessage")
hook.Add("DoPlayerDeath", "RipAddon:RIPDamage", function(deadperson, attacker, dmginfo)
    if not deadperson or not IsValid(deadperson) or not deadperson:IsPlayer() then return end -- if player not player stop
    if not attacker or not IsValid(attacker) or not attacker:IsPlayer() then return end -- if attacker is not player stop

    for k, v in ipairs(deadperson:GetWeapons()) do
        local class = v:GetClass()
        if Gun_1[class] then
            local msg = "[ Normal Weapon ] "..attacker:Nick().." ripped "..deadperson:Nick().."'s "..Gun_1[class]
            local msg2 = "Attacker: "..attacker:Nick().." \n Loser: "..deadperson:Nick().." \n Weapon Lost: "..Gun_1[class]
            net.Start("RipAddon:RIPMessage")
            net.WriteString(msg)
            net.Broadcast()
            DiscordMessage("**__Normal Weapon__**", msg2)
            return
        end

        if Guns_2[class] then
            local msg = "[ DarkRP Weapons ] "..attacker:Nick().." ripped "..deadperson:Nick().."'s "..Guns_2[class]
            local msg2 = "Attacker: "..attacker:Nick().." \n Loser: "..deadperson:Nick().." \n Weapon Lost: "..Guns_2[class]
            net.Start("RipAddon:RIPMessage")
            net.WriteString(msg)
            net.Broadcast()
            DiscordMessage("**__DarkRP Weapon__**", msg2)
            return
        end
    end
end)


