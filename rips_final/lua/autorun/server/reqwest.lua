local webhook = "https://discord.com/api/webhooks/6942-/thisisarealwebhook!"

if pcall(require, "reqwest") and reqwest ~= nil then
    my_http = reqwest
else
    my_http = HTTP
end
require("reqwest")

function DiscordMessage(title, message)
    reqwest({
        method = "POST",
        url = webhook,
        timeout = 30,

        body = util.TableToJSON({
            avatar_url = "",
            username = " | Weapon Rips Bot | ",
            content = "",
            embeds = {
                {
                    title = title,
                    description = message,
                    color = 15158332,
                },
            },
        }),
        type = "application/json",

        headers = {
            ["User-Agent"] = "My User Agent",
        },

        success = function(status, body, headers) print("DONE") end,
        failed = function(err, errExt) 
            print(err, errExt)
        end
    })
end