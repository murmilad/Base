local coverart_nf
function coverart_show()
    -- destroy old popup, needed when bound to a key
    coverart_hide()
    local img = awful.util.pread("/home/alex/.config/awesome/cover_art/coverart.sh")
    local ico = img
    local txt = awful.util.pread("/home/alex/.config/awesome/cover_art/musicinfo.sh")
    -- set desired position of popup during creation
    coverart_nf = naughty.notify({icon = ico, icon_size = 100, text = txt, position = "top_right", opacity = 0.6})
end

function coverart_hide()
    if coverart_nf ~= nil then
	    naughty.destroy(coverart_nf)
    end
end
