RipAddon = RipAddon or {}
function RipAddon.Msg(tag, col, msg)
  chat.AddText(col, tag .. " | ", color_white, msg)
end


net.Receive("RipAddonTXT", function()
  local tag = net.ReadString()
  local col = net.ReadColor()
  local msg = net.ReadString()

  RipAddon.Msg(tag, col, msg)
end)

