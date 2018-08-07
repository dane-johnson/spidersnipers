DEFINE_BASECLASS("player_default")
local PLAYER = {}

PLAYER.JumpPower = 400

function PLAYER:Loadout()
   self.Player:RemoveAllAmmo()
   self.Player:Give("weapon_rifle")
   self.Player:Give("weapon_spiderman")
end

player_manager.RegisterClass("player_spidersniper", PLAYER, "player_default")
