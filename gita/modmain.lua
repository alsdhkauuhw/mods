PrefabFiles = {
    "mygita" ,
    "boki" 
}
Asset = {
    Asset("IMAGE", "images/inventoryimages/mygita.tex") ,
    Asset("ATLAS", "images/inventoryimages/mygita.xml"),

    Asset( "IMAGE", "images/saveslot_portraits/saber.tex" ), --存档图片
    Asset( "ATLAS", "images/saveslot_portraits/saber.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/saber.tex" ), --单机选人界面
    Asset( "ATLAS", "images/selectscreen_portraits/saber.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/saber_silho.tex" ), --单机未解锁界面
    Asset( "ATLAS", "images/selectscreen_portraits/saber_silho.xml" ),

    Asset( "IMAGE", "images/map_icons/saber.tex"),
    Asset( "ATLAS", "images/map_icons/saber.xml")
}
local STRINGS = GLOBAL.STRINGS
local require = GLOBAL.require

STRINGS.CHARACTER_TITLES.boki = "一个阴暗的，潮湿的，孤独的，野椎蛇吉他手boki小姐"
STRINGS.CHARACTER_NAMES.boki = "boki"
STRINGS.CHARACTER_DESCRIPTIONS.boki = "*喜欢阴暗环境不喜欢光亮\n*喜欢一个人独处\n*弹吉他会增加勇气"
STRINGS.CHARACTER_QUOTES.boki = "\"BoKi\""
STRINGS.NAMES.BOKI = "boki"

AddMinimapAtlas("images/map_icons/saber.tex")
AddModCharacter("boki", "FEMALE")

TUNING.BOKI_HEALTH = 200
TUNING.BOKI_HUNGER = 150
TUNING.BOKI_SANITY = 100

STRINGS.CHARACTER_SURVIVABILITY.boki = "完全无法生存捏"

TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.BOKI = {"mygita"}
TUNING.STARTING_ITEM_IMAGE_OVERRIDE["mygita"] = {
    image = "images/inventoryimages/mygita.tex",
    atlas = "images/inventoryimages/mygita.xml"
}
--GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})		
STRINGS.RECIPE_DESC.MYGITA = "一把普通的蓝白吉他"
local mygita_recipe =  Recipe("mygita", {Ingredient("boards", 2), Ingredient("silk", 3), Ingredient("twigs",4)}, GLOBAL.RECIPETABS.WAR,GLOBAL.TECH.SCIENCE_ONE)
mygita_recipe.sortkey = 9999
mygita_recipe.atlas = "images/inventoryimages/mygita.xml"
--AddRecipeTab("zhuanshu_tab", 999, "images/inventoryimages/mygita.xml", "mygita.xml", nil, false)
--STRINGS.TABS[zhuanshu_tab] = "工具栏"
--全部大写，最后面对应我们的预设物名
--STRINGS.NAMES.MYBEARD = "波奇酱"    --显示的名字
--STRINGS.CHARACTERS.GENERIC.DESCRIBE.MYBEARD = "好精美的吉他"    --人物检查时说的话