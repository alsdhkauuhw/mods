local MakePlayerCharacter = require "prefabs/player_common"
local assets = {
    Asset( "ANIM", "anim/player_basic.zip" ),
        Asset( "ANIM", "anim/player_idles_shiver.zip" ),
        Asset( "ANIM", "anim/player_actions.zip" ),
        Asset( "ANIM", "anim/player_actions_axe.zip" ),
        Asset( "ANIM", "anim/player_actions_pickaxe.zip" ),
        Asset( "ANIM", "anim/player_actions_shovel.zip" ),
        Asset( "ANIM", "anim/player_actions_blowdart.zip" ),
        Asset( "ANIM", "anim/player_actions_eat.zip" ),
        Asset( "ANIM", "anim/player_actions_item.zip" ),
        Asset( "ANIM", "anim/player_actions_uniqueitem.zip" ),
        Asset( "ANIM", "anim/player_actions_bugnet.zip" ),
        Asset( "ANIM", "anim/player_actions_fishing.zip" ),
        Asset( "ANIM", "anim/player_actions_boomerang.zip" ),
        Asset( "ANIM", "anim/player_bush_hat.zip" ),
        Asset( "ANIM", "anim/player_attacks.zip" ),
        Asset( "ANIM", "anim/player_idles.zip" ),
        Asset( "ANIM", "anim/player_rebirth.zip" ),
        Asset( "ANIM", "anim/player_jump.zip" ),
        Asset( "ANIM", "anim/player_amulet_resurrect.zip" ),
        Asset( "ANIM", "anim/player_teleport.zip" ),
        Asset( "ANIM", "anim/wilson_fx.zip" ),
        Asset( "ANIM", "anim/player_one_man_band.zip" ),
        Asset( "ANIM", "anim/shadow_hands.zip" ),
        Asset( "SOUND", "sound/sfx.fsb" ),
        Asset( "SOUND", "sound/wilson.fsb" ),
        Asset( "ANIM", "anim/beard.zip" ),

        Asset( "ANIM", "anim/saber_black.zip" ),
        Asset( "ANIM", "anim/saber_blue.zip" ),
        Asset( "ANIM", "anim/saber_blue_armor.zip" ),
        Asset( "ANIM", "anim/saber.zip" ),
        Asset( "ANIM", "anim/saber_red.zip" ),
        Asset( "ANIM", "anim/saber_white.zip" ),
    }
local prefabs = {

}   
local start_inv = {
    "mygita"
} 
local function  onbecamehuman()
    inst.components.locomotor:SetExternalSpeedMultiplier(inst, "boki_speed_mod", 1.5)
    
end
local function onbecameghost()
    inst.components.locomotor:SetExternalSpeedMultiplier(inst, "boki_speed_mod" )
end
local function  onload(inst)
    inst:ListenForEvent("ms_respwanedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)
    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end


local common_postinit = function(inst)
    inst.MiniMapEntity:SetIcon("saber.tex")----改 
end
local main_init = function(inst)
    inst.soundsname = "wendy"
    inst.components.foodaffinity:AddPrefabAffinity()--最喜欢的食物，还没想好QAQ
    inst.components.health:SetMaxHealth(200)
    inst.components.hunger:SetMax(150)
    inst.components.sanity:SetMax(100)
    inst.components.combat.damagemultiplier = 0.75
    inst.components.hunger.hungerrate = 0.75 * TUNING.WILSON_HUNGER_RATE
    inst.components.sanity.sanityrate = 1.25 * TUNING.WILSON_SANITY_RATE
    inst.OnLoad = onload
    inst.OnNewSpwan = onload
end
return MakePlayerCharacter("boki", prefabs, assets, common_postinit, main_init, start_inv)