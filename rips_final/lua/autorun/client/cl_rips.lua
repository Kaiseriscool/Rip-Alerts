net.Receive("RipAddon:RIPMessage", function()
    local message = net.ReadString()
    chat.AddText(color_white, message)
end)