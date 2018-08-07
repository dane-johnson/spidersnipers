--SpiderMod Webcrawling entity clientside code
--Author: The Hunter
--Contact: Steam TheHunter
--Date: 25 September 2013
--Notes: Mainly only debugging use at present

--includes
include("shared.lua")

--debug flag
--when true, this will draw a laser box around the player model
--AABB and other beams denoting edge sensor locations and the
--wall entity itself, drawn as a sawblade
local DebugWC = false

function ENT:Initialize()
  --nothing to init
end

function ENT:Draw()
  if DebugWC then
    --draw the saw blade model
    self.Entity:DrawModel()
    --collect the point data from the entity in use (if any)
    local startpos = self.Entity:GetNWVector("sensor1_start")
    local endpos = self.Entity:GetNWVector("sensor1_end")
    local hitpos = self.Entity:GetNWVector("sensor1_hit")
    --collect the player AABB data
    local ply = self.Entity:GetOwner()
    local min, max = ply:WorldSpaceAABB()
    local m1 = max
    local m2 = Vector(min.x,max.y,max.z)
    local m3 = Vector(max.x,min.y,max.z)
    local m4 = Vector(max.x,max.y,min.z)
    local n1 = min
    local n2 = Vector(max.x,min.y,min.z)
    local n3 = Vector(min.x,max.y,min.z)
    local n4 = Vector(min.x,min.y,max.z)
    --draw the mangled AABB player box
    render.SetMaterial(Material( "cable/redlaser" ) )
    render.DrawBeam(m1,m2,3,0,0, Color(255,255,255,255))
    render.DrawBeam(m2,m3,3,0,0, Color(255,255,255,255))
    render.DrawBeam(m3,m4,3,0,0, Color(255,255,255,255))
    render.DrawBeam(m4,m1,3,0,0, Color(255,255,255,255))
    render.DrawBeam(n1,n2,3,0,0, Color(255,255,255,255))
    render.DrawBeam(n2,n3,3,0,0, Color(255,255,255,255))
    render.DrawBeam(n3,n4,3,0,0, Color(255,255,255,255))
    render.DrawBeam(n4,n1,3,0,0, Color(255,255,255,255))
    render.DrawBeam(n1,m2,3,0,0, Color(255,255,255,255))
    render.DrawBeam(n2,m3,3,0,0, Color(255,255,255,255))
    render.DrawBeam(n3,m4,3,0,0, Color(255,255,255,255))
    render.DrawBeam(n4,m1,3,0,0, Color(255,255,255,255))
    --draw a diagonal blue marker denoting the beginning of the sensor trace
    render.SetMaterial(Material( "cable/blue_elec" ) )
    render.DrawBeam(startpos - Vector(5,5,5), startpos + Vector(5,5,5), 10, 0, 0, Color(255,255,255,255))
    --draw a diagonal red marker denoting the end of the sensor trace
    render.SetMaterial(Material( "cable/redlaser" ) )
    render.DrawBeam(endpos - Vector(5,5,5), endpos + Vector(5,5,5), 10, 0, 0, Color(255,255,255,255))
    --draw the sensor trace line
    render.SetMaterial(Material( "cable/xbeam" ) )
    render.DrawBeam(startpos, endpos, 10, 0, 0, Color(255,255,255,255))
    --draw a three dimension line asterisk at the hit point of the sensor (in red)
    if ((hitpos != nil) and (hitpos != endpos)) then
      render.SetMaterial(Material( "cable/redlaser" ) )
      render.DrawBeam(hitpos - Vector(10,0,0), hitpos + Vector(10,0,0), 10, 0, 0, Color(255,255,255,255))
      render.DrawBeam(hitpos - Vector(0,10,0), hitpos + Vector(0,10,0), 10, 0, 0, Color(255,255,255,255))
      render.DrawBeam(hitpos - Vector(0,0,10), hitpos + Vector(0,0,10), 10, 0, 0, Color(255,255,255,255))
    end
    --we do draw
    return true
  else
    --we don't draw
    return false
  end
end

--if the wall crawling entity is not in use we carry it with us (debugging)
function ENT:Think() 
  local ply = self.Entity:GetOwner()
  if (ply != NULL) and (self.Entity:IsActivated() == false) then
    self.Entity:SetPos(ply:GetPos()) 
  end
end   

--when used as a vehicle, this is the code to draw the view point of the 
--player (not presently used) - this code moves the viewpoint back to the
--original player view rather than from the vehicle
function ENT:CalcView(Player, Origin, Angles, FieldOfView)
  local View = {}
  View.origin = Player:GetShootPos()
  View.angles = Player:EyeAngles()
  View.fov = FieldOfView
  return View
end 

function ENT:OnRemove()
	--nothing to do yet
end
