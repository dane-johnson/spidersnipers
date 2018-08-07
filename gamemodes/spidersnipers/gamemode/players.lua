DEFINE_BASECLASS("gamemode_base")

function GM:PlayerSpawn(ply)
   player_manager.SetPlayerClass(ply, "player_spidersniper")
   BaseClass.PlayerSpawn(self, ply)
end
