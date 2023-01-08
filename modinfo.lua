local function en_zh(en, zh)
    return (locale == "zh" or locale == "zhr" or locale == "zht") and zh or en
end

name = en_zh("Terrible Slotmachine", "恐怖抽奖机")
description = en_zh("Random Terrible Slotmachine!\nIt needs to be used with Island Adventures and Gem Core.", "恐怖抽奖机！\n需要与岛屿冒险一起开启")
author = "亚丹,每年睡8760小时"
version = "0.1.5.6"
forumthread = "https://steamcommunity.com/sharedfiles/filedetails/?id=2866709098"
api_version = 10
api_version_dst = 10
priority = -22

dst_compatible = true
dont_starve_compatible = false
all_clients_require_mod = true
client_only_mod = false
reign_of_giants_compatible = false

icon_atlas = "modicon.xml"
icon = "modicon.tex"

configuration_options  = {
    {
        name = "MOREDUBLOON",
        label = "更多的金币!",
        hover = "更多的金币!",
        options =
        {{description = "默认",hover = "默认数量,适合多人",data = 1
        },
        {description = "较多",hover = "较多",data = 2
        },
        {description = "很多",hover = "很多",data = 3
        },
        {description = "非常多！",hover = "???单人玩家???",data = 4
        },},
    default = 1
    },
    {
        name = "ANCIENT_HULKHEALTH",
        label = "远古巨人血量",
        hover = "远古巨人血量",
        options = {
        {description = "默认的血量",hover = "9000血",data = 9000
        },
        {description = "较少的血量",hover = "6000血",data = 6000
        },
        {description = "很少的血量",hover = "???单人玩家???",data = 4500
        }},
    default = 9000
    },
    {
        name = "DRAGONFLY_HEALTH",
        label = "龙蝇的血量",
        hover = "龙蝇的血量",
        options = {
        {description = "默认的血量",hover = "27500血",data = 27500
        },
        {description = "较少的血量",hover = "6000血",data = 15000
        },
        {description = "很少的血量",hover = "???单人玩家???",data = 4000
        }},
    default = 27500
    },
}
