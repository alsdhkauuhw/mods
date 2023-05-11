local speedbuff = class(function (self, inst)
    self.BuffTime = 0
    self.hasBuff = false
    self.inst = inst
end)

function speedbuff:BuffTime()
    return self.BuffTime
end

function speedbuff:SetBuff()
    self.hasBuff = true
end

function speedbuff:SetBuffTime(time)
    self.BuffTime = time
end

function speedbuff:BuffOver()
   self.hasBuff = false 
end