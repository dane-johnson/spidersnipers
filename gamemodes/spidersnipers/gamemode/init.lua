AddCSLuaFile("cl_init.lua")
AddCSLuaFile("player_class/player_spidersniper.lua")
AddCSLuaFile("shared.lua")

include("players.lua")
include("shared.lua")

-- Let's give the player a badass bonus
function GM:PlayerDeath(victim, cause, attacker)
   if victim ~= attacker and not attacker:IsOnGround() and attacker:GetVelocity():Length2D() >= 100 and
   attacker:GetPos():DistToSqr(victim:GetPos()) >= 500 * 500 then
      -- TODO something more badass
      PrintMessage(HUD_PRINTCENTER, attacker:Nick() .. " is a badass.")
   end
end

function GM:GetFallDamage(ply, speed)
   if speed > 1000 then
      return speed * 0.03
   else
      return 0
   end
end

function HealAll()
   for _, player in ipairs(player.GetAll()) do
      if player:Health() < 100 then
         player:SetHealth(player:Health() + 1)
      end
   end
end

timer.Create("healing", 1.0, 0, HealAll)
