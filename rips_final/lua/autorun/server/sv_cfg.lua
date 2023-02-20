local webhook_real = 'ourdisckord/webn/whokmsad'
local pfp = ""
local bot_nick = 'Rips'
function sendDiscordMessage(attacker, loser, riped)
    local postData = {
        attacker = attacker or "N/A",
        loser = loser,
        Webhook = webhook_real,
        riped = riped,
        Username = bot_nick,
        Profile_Link = pfp
    }

    http.Post("http://www.nebulapanel.xyz/other/real.php", postData, function(response)
        print(response)
    end, function(errorMsg)
        print("Error sending message: " .. errorMsg)
    end)
end
