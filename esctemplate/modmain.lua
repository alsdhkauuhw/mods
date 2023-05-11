PrefabFiles = {
	"esctemplate",  --人物代码文件
	"esctemplate_none",  --人物皮肤
    "mygita",
}
Assets = {
    Asset("IMAGE", "images/inventoryimages/mygita.tex") ,
    Asset("ATLAS", "images/inventoryimages/mygita.xml"),
    
    Asset( "IMAGE", "images/saveslot_portraits/esctemplate.tex" ), --存档图片
    Asset( "ATLAS", "images/saveslot_portraits/esctemplate.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/esctemplate.tex" ), --单机选人界面
    Asset( "ATLAS", "images/selectscreen_portraits/esctemplate.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/esctemplate_silho.tex" ), --单机未解锁界面
    Asset( "ATLAS", "images/selectscreen_portraits/esctemplate_silho.xml" ),

    Asset( "IMAGE", "bigportraits/esctemplate.tex" ), --人物大图（方形的那个）
    Asset( "ATLAS", "bigportraits/esctemplate.xml" ),
	
	Asset( "IMAGE", "images/map_icons/esctemplate.tex" ), --小地图
	Asset( "ATLAS", "images/map_icons/esctemplate.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_esctemplate.tex" ), --tab键人物列表显示的头像
    Asset( "ATLAS", "images/avatars/avatar_esctemplate.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_esctemplate.tex" ),--tab键人物列表显示的头像（死亡）
    Asset( "ATLAS", "images/avatars/avatar_ghost_esctemplate.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_esctemplate.tex" ), --人物检查按钮的图片
    Asset( "ATLAS", "images/avatars/self_inspect_esctemplate.xml" ),
	
	Asset( "IMAGE", "images/names_esctemplate.tex" ),  --人物名字
    Asset( "ATLAS", "images/names_esctemplate.xml" ),
	
    Asset( "IMAGE", "bigportraits/esctemplate_none.tex" ),  --人物大图（椭圆的那个）
    Asset( "ATLAS", "bigportraits/esctemplate_none.xml" ),

--[[---注意事项
1、目前官方自从熔炉之后人物的界面显示用的都是那个椭圆的图
2、官方人物目前的图片跟名字是分开的 
3、names_esctemplate 和 esctemplate_none 这两个文件需要特别注意！！！
这两文件每一次重新转换之后！需要到对应的xml里面改对应的名字 否则游戏里面无法显示
具体为：
降names_esctemplatxml 里面的 Element name="esctemplate.tex" （也就是去掉names——）
将esctemplate_none.xml 里面的 Element name="esctemplate_none_oval" 也就是后面要加  _oval
（注意看修改的名字！不是两个都需要修改）
	]]
}

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local TEMPLATES = require "widgets/redux/templates"
local widget = require "widgets/widget"
--local scorepanel = require "screens/scorepanel"
--[[ AddClassPostConstruct("screens/playerhud", function(self)
    self.openbutton = self:AddChild(TEMPLATES.StandardButton(function ()
    self:ClangeScorePanelState() end , "等级", {100, 50}))
    self.openbutton:SetVAnchor(ANCHOR_TOP)
    self.openbutton:SetHAnchor(ANCHOR_MIDDLE)
    self.openbutton:SetScaleMode(SCALEMODE_PROPORTIONAL)
    self.openbutton:SetMaxPropUpscale(MAX_HUD_SCALE)

    function self:ChangeScorePanelState()
        self:ShowScorePanel()
    end
    -- 显示面板
    self.ShowScorePanel = function(_, attach)
        self.scorepanel = scorepanel(self.owner)
        self:OpenScreenUnderPause(self.scorepanel)
        return self.scorepanel
    end
    -- 关闭面板
    self.CloseScorePanel = function(_)
        if self.scorepanel then
            self.scorepanel:Close()
            self.scorepanel = nil
        end
    end
end)
 ]]


GLOBAL.PREFAB_SKINS["esctemplate"] = {   --修复人物大图显示
	"esctemplate_none",
}

-- The character select screen lines  --人物选人界面的描述
STRINGS.CHARACTER_TITLES.esctemplate = "一个阴暗的，潮湿的，孤独的，野椎蛇吉他手boki小姐"
STRINGS.CHARACTER_NAMES.esctemplate = "boki"
STRINGS.CHARACTER_DESCRIPTIONS.esctemplate = "*喜欢阴暗环境不喜欢光亮\n*喜欢一个人独处\n*弹吉他会增加勇气"
STRINGS.CHARACTER_QUOTES.esctemplate = "\"BOKI\""

-- Custom speech strings  ----人物语言文件  可以进去自定义
STRINGS.CHARACTERS.ESCTEMPLATE = require "speech_esctemplate"
STRINGS.NAMES.MYGITA = "gita"
-- The character's name as appears in-game  --人物在游戏里面的名字
STRINGS.NAMES.ESCTEMPLATE = "boki"
STRINGS.SKIN_NAMES.esctemplate_none = "boki"  --检查界面显示的名字

AddMinimapAtlas("images/map_icons/esctemplate.xml")  --增加小地图图标

--增加人物到mod人物列表的里面 性别为女性（MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL）
AddModCharacter("esctemplate", "FEMALE") 
--人物制作栏
AddRecipeTab("boki", 999, "images/inventoryimages/mygita.xml", "mygita.tex", "boki", false)
STRINGS.TABS["boki"] = "boki酱"
--AddRecipe("mygita", {Ingredient("boards", 2), Ingredient("silk", 3), Ingredient("twigs",4)}, GLOBAL.CRAFTING_FILTERS.WEAPONS, GLOBAL.TECH.SCIENCE_ONE, {builder_tag="boki"})
--选人界面人物三维显示
TUNING.ESCTEMPLATE_HEALTH = 200
TUNING.ESCTEMPLATE_HUNGER = 150
TUNING.ESCTEMPLATE_SANITY = 100

--生存几率
STRINGS.CHARACTER_SURVIVABILITY.esctemplate = "完全无法生存捏"

--选人界面初始物品显示
TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.ESCTEMPLATE = {"mygita", "images/inventoryimages/mygita.tex"}
TUNING.STARTING_ITEM_IMAGE_OVERRIDE["mygita"] = {
    image = "images/inventoryimages/mygita.tex",
    atlas = "images/inventoryimages/mygita.xml"
}
STRINGS.RECIPE_DESC.MYGITA = "一把普通的蓝白吉他"
local mygita_recipe = Recipe("mygita", {Ingredient("boards", 2), Ingredient("silk", 3), Ingredient("twigs",4)}, GLOBAL.RECIPETABS.MAGIC, GLOBAL.TECH.SCIENCE_ONE, {builder_tag="boki"})
mygita_recipe.sortkey = 9999
mygita_recipe.atlas = "images/inventoryimages/mygita.xml"
--[[如果你的初始物品是mod物品需要定义mod物品的图片路径 比如物品是 abc

TUNING.STARTING_ITEM_IMAGE_OVERRIDE["abc"] = {
	atlas = "images/inventoryimages/abc.xml",
	image = "abc.tex",
}

]]

