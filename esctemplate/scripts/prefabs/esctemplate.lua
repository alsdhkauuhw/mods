
local MakePlayerCharacter = require "prefabs/player_common"


local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
	Asset("IMAGE", "images/inventoryimages/mygita.tex") ,
    Asset("ATLAS", "images/inventoryimages/mygita.xml"),
}
local prefabs = {}

-- 初始物品
local start_inv = {
	"mygita", --自带一个gita
}
-- 当人物复活的时候
local function onbecamehuman(inst)
	-- 设置人物的移速（1表示1倍于wilson）
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "esctemplate_speed_mod", 1.5)
end
--当人物死亡的时候
local function onbecameghost(inst)
	-- 变成鬼魂的时候移除速度修正
   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "esctemplate_speed_mod")
end

-- 重载游戏或者生成一个玩家的时候
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)
	inst.components.health.maxhealth = math.floor(200 * ( 1 + inst.components.Level:GetLevel() * 0.1))
	--[[ if data.health then
		inst.components.health:Setval(data.health)
	end ]]
    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end
--角色雇佣
local function OnHire(inst, data)
	if data then
		inst.components.talker:Say("hello !!boki")		
        local hired = data.hiree
        if hired.components.follower then -- 雇佣的角色是 "follower" 类型
			inst.components.talker:Say("Follow me")
            hired.components.follower:ClearCachedPlayerLeader()
        end
    end
end
--击杀boss
local function OnKilledBoss(inst, data)
    local victim = data.victim
	--inst.components.talker:Say("Level:"..tostring(inst.components.Level:GetLevel()))		
    if victim and victim:HasTag("epic") then
        local boss_type = victim.prefab
		local l = inst.components.Level:GetLevel()
		inst.components.Level:LevelUp(100)
		if l ~= inst.components.Level:GetLevel() then
					inst.components.talker:Say("Level:"..tostring(inst.components.Level:GetLevel()))		
		end
        -- 在这里编写你想要执行的代码，比如给玩家奖励等
    end
end
--干饭升级
local function OnEat(inst, data)
	local food = data.food
	if food.prefab == "mandrake" then
		inst.components.talker:Say("感觉什么都忘了,level: 0")			
		inst.components.Level:Initialization()
		return
	end
	local l = inst.components.Level:GetLevel()
	if food.prefab == "deerclops_eyeball" or food.prefab == "minotaurhorn" then
		inst.components.Level:LevelUp(200)
	end
	if food:HasTag("preparedfood") then
		inst.components.Level:LevelUp(5)
	else
		inst.components.Level:LevelUp(1)
	end
	if l ~= inst.components.Level:GetLevel() then
		inst.components.talker:Say("Level:"..tostring(inst.components.Level:GetLevel()))		
	end
end
--设置血量
local function sethealth(inst, data)
	inst.components.talker:Say("Level:"..tostring(inst.components.Level:GetLevel()))		
	--if data.health then
		inst.components.health:SetCurrentHealth(data.health)
	--end
end


local function OnLevelUp(inst)
	local Health_Precent = inst.components.health:GetPercent()
	local MaxHealth = inst.components.health.maxhealth
	inst.components.health.maxhealth = math.floor(200 * ( 1 + inst.components.Level:GetLevel() * 0.1))
	inst.components.health:SetPercent(Health_Precent)
end
--这个函数将在服务器和客户端都会执行
--一般用于添加小地图标签等动画文件或者需要主客机都执行的组件（少数）
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "esctemplate.tex" )
	inst:AddTag("boki")
end

-- 这里的的函数只在主机执行  一般组件之类的都写在这里
local master_postinit = function(inst)
	-- 人物音效
	inst.soundsname = "wendy"

	--最喜欢的食物  名字 倍率（1.2）
	inst.components.foodaffinity:AddPrefabAffinity("baconeggs", TUNING.AFFINITY_15_CALORIES_HUGE)
	-- 三维	
	inst.components.health:SetMaxHealth(200)
	--inst.components.health.maxhealth = math.floor(200 * ( 1 + inst.components.Level:GetLevel() * 0.1))
	inst.components.hunger:SetMax(150)
	inst.components.sanity:SetMax(100)
	
	-- 伤害系数
    inst.components.combat.damagemultiplier = 0.75
	
	-- 饥饿速度
	inst.components.hunger.hungerrate = 0.75 * TUNING.WILSON_HUNGER_RATE
	-- 食物收益
	inst.components.eater:SetAbsorptionModifiers(0.75, 0.75, 1.25)
	--人物升级
	inst:AddComponent("Level")
	inst.components.Level:OnLevelUp(OnLevelUp)
	--监听事件
	inst:ListenForEvent("killed", OnKilledBoss)
	inst:ListenForEvent("oneat", OnEat)
	inst:ListenForEvent("onhire", OnHire)
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
end
return MakePlayerCharacter("esctemplate", prefabs, assets, common_postinit, master_postinit, start_inv)
