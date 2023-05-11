local TEMPLATES = require "widgets/redux/templates"
local Screen = require "widges/screeen"
local scorepanel = Class(Screen, function (self, owner)
    Screen._ctor(self, "scorepanel")
    self.owner = owner
    self.panel = self:AddChild(TEMPLATES.RectangleWindow(400, 500, "还没写捏" ))
end)
return scorepanel