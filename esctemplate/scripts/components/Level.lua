local Level = Class(
    function(self, inst)
    self.inst = inst
    self.level = 0
    self.Maxlevel = 10
    self.experience = 0
    self.maxexperience = 1 
    local function OnKeyDown(inst)
        --local key = data.KEY
        --if key == KEY_O then
            inst.components.talker:Say("Level:"..tostring(inst.components.Level:GetLevel()))		
       -- end
    end
    TheInput:AddKeyDownHandler(KEY_O, OnKeyDown)
    end
    , nil
    , {}
)
--得到等级
function Level:GetLevel()
    return self.level
end
--升级
function Level:LevelUp(count)
    local l = self.level
    self.experience = count + self.experience
    if self.level >= self.Maxlevel then
        return
    end
    while self.experience >= self.maxexperience do
        self.experience = self.experience - self.maxexperience
        if self.level < self.Maxlevel then
            self.level = self.level + 1 
            if self.level <= 3 then
                self.maxexperience = math.pow(10, self.level)    
            end  
        end
    end
    --[[ if self.experience >= self.maxexperience then
    self.level = math.floor(self.experience * 0.01) + self.level
    self.experience = self.experience % 100 
    end ]]
    self.onlevelupfn(self.inst)
end
--升级回调函数
function Level:OnLevelUp(fn)
    self.onlevelupfn = fn
end
--重置等级
function Level:Initialization()
    self.level = 0
    self.Maxlevel = 10
    self.experience = 0
    self.maxexperience = 1
    self.onlevelupfn = (self.inst)
end
--保存
function Level:OnSave()
    return{
        level = self.level,
        maxlevel = self.Maxlevel,
        experience = self.experience,
        maxexperience = self.maxexperience,
    }
end
--加载
function Level:OnLoad(data)
    if data.level then
        self.level = data.level
    end
    if data.maxlevel then
        self.Maxlevel = data.maxlevel
    end
    if data.experience then
        self.experience = data.experience
    end
    if data.maxexperience then
        self.maxexperience = data.maxexperience
    end
end
--检查

return Level