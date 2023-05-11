local assets =
{
    Asset("ANIM", "anim/mygita.zip") ,--该预设物用到的动画
    Asset("ANIM", "anim/swap_mygita.zip"),
    Asset("IMAGE", "images/inventoryimages/mygita.tex") ,
    Asset("ATLAS", "images/inventoryimages/mygita.xml")
}

local function onequip(inst, owner)
	
	owner.AnimState:OverrideSymbol("swap_object", "swap_mygita", "swap_mygita")

    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
	
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")

end

local function fn()
    local inst = CreateEntity()     --创建一个实体，官方代码在 scripts/mainfunctions.lua

    --C层的组件，类似的还有Phiysics、Light、Network、SoundEmitter等
    --这些组件我们看不见源代码，对应API可以看第一期提供的资源里的 笔记：物品制作常用组件.lua
    inst.entity:AddTransform()  --添加位移组件，坐标位置
    inst.entity:AddAnimState()  --添加动画组件，用于播放动画（这里就一个地上的动画）

    MakeInventoryPhysics(inst)  --对于放在物品栏里的物理Phiysics，让其可以放地上，具体代码在 standardcomponents.lua

    --设置动画，这三个函数的参数意义在第一章提到过
    inst.AnimState:SetBank("mygita")     --Sprite里面右下角第一层的entity name
    inst.AnimState:SetBuild("mygita")    --scml name，同时也是zip的名字
    inst.AnimState:PlayAnimation("idle")    --Sprite里面右下角第二层的animation name

    inst.entity:AddNetwork()    --添加网络，因为要在服务器和客户端都显示
    --MakeInventoryFloatable(inst, "med", nil, 0.75)  --让物品浮起来，后面三参数可省，具体代码在 standardcomponents.lua
    inst:AddTag("sharp")
    inst:AddTag("pointy")
    inst.entity:SetPristine()   --推断是OnLoad等初始化相关的

   --一般与entity有关的代码，以及服务器和客户端都运行的代码都写在这行上面
    if not TheWorld.ismastersim then    --如果是客户端，返回inst，结束
        return inst         
    end

    --下面是服务器代码，我们添加若干组件，让实体有各种各样的功能
    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(38)
 
    --inst:AddComponent("inspectable")    --可检查
    --inst:AddComponent("inventoryitem")  --可放物品栏
   
    --inst:AddComponent("stackable")  --可堆叠
    --inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM --设置堆叠最大值

    --inst:AddComponent("fuel")   --可当燃料
    --inst.components.fuel.fuelvalue = TUNING.MED_FUEL    --设置燃料值

    --MakeSmallBurnable(inst, TUNING.MED_BURNTIME)    --可自然
    --MakeSmallPropagator(inst)   --可传递火焰，即自身燃烧时也点燃周围的物体，具体代码在 standardcomponents.lua

    --MakeHauntableLaunchAndIgnite(inst)  --可作祟(Hauntable)和（火把）点燃（Ignite），具体代码在 standardcomponents.lua
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(TUNING.SPEAR_USES)
    inst.components.finiteuses:SetUses(TUNING.SPEAR_USES)

    inst.components.finiteuses:SetOnFinished(inst.Remove)

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "mygita"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/mygita.xml"

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
    MakeHauntableLaunch(inst)

    return inst
end

return Prefab("mygita", fn, assets)  