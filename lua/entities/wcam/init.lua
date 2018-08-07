--SpiderMod Webcrawling entity serverside code
--Author: The Hunter
--Contact: Steam TheHunter
--Date: 25 September 2013
--Notes: Just the includes right now - will probably neaten up the shared into some of this later

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

/*---------------------------------------------------------
   Name: KeyValue
   Desc: Called when a keyvalue is added to us
---------------------------------------------------------*/
function ENT:KeyValue( key, value )
  --nothing to do yet
end
/*---------------------------------------------------------
   Name: Think
   Desc: Entity's think function. 
---------------------------------------------------------*/
function ENT:Think()
  if self.Entity:IsActivated() then
    --nothing to do yet
  end
end

/*---------------------------------------------------------
   Name: OnRemove
   Desc: Called just before entity is deleted
---------------------------------------------------------*/
function ENT:OnRemove()
  --nothing to do yet
end
