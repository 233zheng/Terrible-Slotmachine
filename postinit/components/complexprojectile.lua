local AddComponentPostInit = AddComponentPostInit
GLOBAL.setfenv(1, GLOBAL)

local ComplexProjectile = require "components/complexprojectile"

local function postint(self)

    self.yOffset = 3
	self.maxRange = 10

end

AddComponentPostInit("complexprojectile", postint)
