--     A "Garry's Mod" gamemode about dueling web slingers
--     Copyright (C) 2018 Dane Johnson

--     This program is free software: you can redistribute it and/or modify
--     it under the terms of the GNU General Public License as published by
--     the Free Software Foundation, either version 3 of the License, or
--     (at your option) any later version.

--     This program is distributed in the hope that it will be useful,
--     but WITHOUT ANY WARRANTY; without even the implied warranty of
--     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--     GNU General Public License for more details.

--     You should have received a copy of the GNU General Public License
--     along with this program.  If not, see <https://www.gnu.org/licenses/>.

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
