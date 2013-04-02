-- The "SfxBankName" variable is reserved. It will be used for custom SFX stuff.

function Initialise()

    SendMessage("GameLogic.PlaceObjects")

    SendMessage("GameLogic.ResetTriggerParams")

    SetData("Camera.StartOfTurnCamera","Default")
    SetData("Mine.DudProbability", 0.1)
    SetData("Mine.MinFuse", 1000)
    SetData("Mine.MaxFuse", 5000)
    MaxWind = GetData("Wind.MaxSpeed") -- Wind doesn't exist yet. Going to patch that later.
    SetData("Wind.Speed", 1*MaxWind)
    SetData("Wind.Direction", 5.3)
   
--Triggers inside building used to check for amount of destruction done to building
        
    SetData("Trigger.Spawn", "Trig1")
    SetData("Trigger.Radius", 25)
    SetData("Trigger.Index", 1)
    SetData("Trigger.Visibility", 1)
    SendMessage("GameLogic.CreateTrigger")
    
    SetData("Trigger.Spawn", "Trig2")
    SetData("Trigger.Index", 2)
    SendMessage("GameLogic.CreateTrigger")
    
    SetData("Trigger.Spawn", "Trig3")
    SetData("Trigger.Index", 3)
    SendMessage("GameLogic.CreateTrigger")   

    SetData("Trigger.Spawn", "Trig4")
    SetData("Trigger.Index", 4)
    SendMessage("GameLogic.CreateTrigger") 

    SetData("Trigger.Spawn", "Trig5")
    SetData("Trigger.Index", 5)
    SendMessage("GameLogic.CreateTrigger")    
    
    SetData("Trigger.Spawn", "Trig6")
    SetData("Trigger.Index", 6)
    SendMessage("GameLogic.CreateTrigger")
    
    SetData("Trigger.Spawn", "Trig7")
    SetData("Trigger.Index", 7)
    SendMessage("GameLogic.CreateTrigger")
    
    SetData("Trigger.Spawn", "Trig8")
    SetData("Trigger.Index", 8)
    SendMessage("GameLogic.CreateTrigger")
    
    SetData("Trigger.Spawn", "Trig9")
    SetData("Trigger.Index", 9)
    SendMessage("GameLogic.CreateTrigger")
    
    SetData("Trigger.Spawn", "Trig10")
    SetData("Trigger.Index", 10)
    SendMessage("GameLogic.CreateTrigger")
    
    SetData("Trigger.Spawn", "Trig11")
    SetData("Trigger.Index", 11)
    SendMessage("GameLogic.CreateTrigger")
    
    SetData("Trigger.Spawn", "Trig12")
    SetData("Trigger.Index", 12)
    SendMessage("GameLogic.CreateTrigger")
    
    SetData("Trigger.Spawn", "Trig13")
    SetData("Trigger.Index", 13)
    SendMessage("GameLogic.CreateTrigger")
    
    SetData("Trigger.Spawn", "Trig14")
    SetData("Trigger.Index", 14)
    SendMessage("GameLogic.CreateTrigger")
    
    SetData("Trigger.Spawn", "Trig15")
    SetData("Trigger.Index", 15)
    SendMessage("GameLogic.CreateTrigger")
    
    SetData("Trigger.Spawn", "Trig16")
    SetData("Trigger.Index", 16)
    SendMessage("GameLogic.CreateTrigger")
    
    SetData("Trigger.Spawn", "Trig17")
    SetData("Trigger.Index", 17)
    SendMessage("GameLogic.CreateTrigger")
    
    SetData("Trigger.Spawn", "Trig18")
    SetData("Trigger.Index", 18)
    SendMessage("GameLogic.CreateTrigger")
    
    deadcount = 0
    trigcount = 0
    trigcollect = 0
           
    SetupMariosAndTeams() -- Setup Marios(Marios = Yoshi, Mario and Luigi) and Teams.
    SetupInventories() -- Setup inventories. Inventories are not done yet.
    StartFirstTurn()
end

--Checking for deadMarios in order to spawn big weapon crates. Increases deadcount variable by one
--for each Mario, this is used to decide which crate is spawned.
function Mario_Died()

    deadMario = GetData("DeadMario.Id")
    
    if deadMario == 4 or deadMario == 5 or deadMario == 6 or deadMario == 7 or deadMario == 8 or deadMario == 9 then
    
        deadcount = deadcount + 1
	CheckCrate()
    
    end

end


--Looks for destroyed triggers and adds 1 to trigcount variable for each trigger destroyed
--also chcks to see if all of townhall has been destroyed
--junk messages for debug purposes only
function Trigger_Destroyed()
	trigcount = trigcount + 1
	SetData("CommentaryPanel.Comment", "Trigger collected")
	SendMessage("CommentaryPanel.ScriptText")
    if trigcount == 18 then
	trigcollect = trigcollect +1
	SetData("CommentaryPanel.Comment", "Town Hall Destroyed")
	SendMessage("CommentaryPanel.ScriptText")
    end
      
end


function SetupMariosAndTeams()

    -- Teams --
    lock, team = EditContainer("Team.Data00") 
    team.Active = true
    team.Name = GetData("User.HumanTeamName")
    team.TeamColour = 0
    CloseContainer(lock)

    lock, team = EditContainer("Team.Data01") 
    team.Active = true
    team.Name = "The Darksiders"
    team.TeamColour = 1
    team.IsAIControlled = true
    CloseContainer(lock)
    
    -- Player Marios --
    -- These are the playing characters.
    lock, Mario = EditContainer("Mario.Data00") 
    Mario.Active = true
    Mario.Name = GetData("User.HumanMario1")
    Mario.JumpForce = Vector3.new(125,125,125) - Default mario's jump force.
    Mario.Energy = 200 -- Yes. You are mad now, right?
    Mario.Speed = 100
    Mario.WeaponFuse = 3
    Mario.WeaponIsBounceMax = false
    Mario.TeamIndex = 0
    Mario.Spawn = "HumanMario1"
    CloseContainer(lock)
    
    CopyContainer("Yoshi.Data00", "Yoshi.Data01")
    lock, Yoshi = EditContainer("Yoshi.Data01") 
    Yoshi.Name = GetData ("User.HumanYoshi2")
    Yoshi.JumpForce = Vector3.new(185,185,185) - Yoshi jumps higher, but runs slow. Making him only -50 health weaker.
    Yoshi.Energy = 150
    Yoshi.Speed = 100
    Yoshi.Spawn = "HumanYoshi2"
    CloseContainer(lock)

    CopyContainer("Luigi.Data00", "Luigi.Data02")
    lock, Luigi = EditContainer("Luigi.Data02") 
    Luigi.Name = GetData ("User.HumanLuigi3")
    Luigi.JumpForce = Vector3.new(150,150,150)
    Luigi.Energy = 100
    Luigi.Speed = 243 -- Luigi's speed is higher than mario's, but gives Luigi lesser health.
    Luigi.Spawn = "HumanLuigi3"
    CloseContainer(lock)

    CopyContainer("Mario.Data00", "Mario.Data03") -- Mario 2. These will be used for the black mario clones. The default settings of mario apply otherwise it will jump to CPU Mario.
    lock, Mario = EditContainer("Mario.Data03") 
    Mario.Name = GetData ("User.HumanMario4")
    Mario.Energy = 100
    Mario.Spawn = "HumanMario4"
    CloseContainer(lock)

    --CPU Marios -- 
    -- They're needed for the main story. The difficulty will be added soon.
    CopyContainer("Mario.Data00", "Mario.Data04")
    lock, Mario = EditContainer("Mario.Data04")
    Mario.Energy = 75 
    Mario.Name = "Dr.Davis" -- The Dr. He plays the one, who works for the Hades Corp.
    Mario.TeamIndex = 1
    Mario.SfxBankName = ""
    Mario.Spawn = "CPUMario1"
    CloseContainer(lock)

    CopyContainer("Mario.Data04", "Mario.Data05")
    lock, Mario = EditContainer("Mario.Data05")
    Mario.Energy = 1000
    Mario.TeamIndex = 5
    Mario.SfxBankName = ""
    Mario.Name = "Rudreky" -- The person, who controls the black sun and possesses the ultimate power. He's the strongest in-game.
    Mario.Spawn = "CPUMario2"
    CloseContainer(lock)

    CopyContainer("Mario.Data04", "Mario.Data06")
    lock, Mario = EditContainer("Mario.Data06")
    Mario.Name = "Dunst" -- The first boss. 
    Mario.Spawn = "CPUMario3"
    CloseContainer(lock)

    CopyContainer("Mario.Data04", "Mario.Data07")
    lock, Mario = EditContainer("Mario.Data07")
    Mario.Name = "Das Bruce" - A german guy, that kills everyone.
    Mario.Spawn = "CPUMario4"
    CloseContainer(lock)
    
    CopyContainer("Mario.Data04", "Mario.Data08")
    lock, Mario = EditContainer("Mario.Data08")
    Mario.Name = "Cyberpunk"
    Mario.Spawn = "CPUMario5"
    CloseContainer(lock)

    CopyContainer("Mario.Data04", "Mario.Data09")
    lock, Mario = EditContainer("Mario.Data09")
    Mario.Name = "Lil Burnt"
    Mario.Spawn = "CPUMario6"
    CloseContainer(lock)

    SendMessage("MarioManager.Reinitialise")
end

function SetupInventories()
    lock, inventory = EditContainer("Inventory.Team00") -- This here are custom ASM weps, they're not done yet.
    inventory.Bazooka = -1
    inventory.Grenade = -1
    inventory.ClusterGrenade = 5
    inventory.Dynamite = 1
    inventory.Landmine = 0
    inventory.Jetpack = 0
    inventory.SkipGo = -1
    inventory.Girder = 0
    inventory.Shotgun = 2
    CloseContainer(lock)

    CopyContainer("Inventory.Team00", "Inventory.Team01")
    
    lock, inventory = EditContainer("Inventory.Team01") -- This here are custom ASM weps, they're not done yet.
    inventory.Bazooka = -1
    inventory.Grenade = -1
    inventory.ClusterGrenade = 5
    inventory.Dynamite = 1
    inventory.Landmine = 0
    inventory.Jetpack = 0
    inventory.SkipGo = -1
    inventory.Girder = 0
    inventory.Shotgun = 2
    CloseContainer(lock)

end

--Function used to spawn crates from deadcount variable
function CheckCrate()
	if deadcount == 1 then
		SpawnCrate1()
	end
	if deadcount == 2 then
		SpawnCrate2()
	end
	if deadcount == 3 then
		SpawnCrate3()
	end
	if deadcount == 4 then
		SpawnCrate4()
	end
	if deadcount == 5 then
		SpawnCrate5()
	end
	if deadcount == 6 then
		SpawnCrate6()
	end
end

--This is where we actually spawn the crates
function SpawnCrate1()
	if deadcount == 1 then
	        SetData("Crate.Spawn", "WCrate_Bazooka")
		SetData("Crate.Type", "Weapon")
		SetData("Crate.Index", 101)
		SetData("Crate.NumContents", 1)
		SetData("Crate.GroundSnap", 0)
		SetData("Crate.Contents", "kWeaponBazooka")
		SendMessage("GameLogic.CreateCrate")
	end
end


function SpawnCrate2()
	if deadcount == 2 then
	        SetData("Crate.Spawn", "WCrate_Grenade")
		SetData("Crate.Type", "Weapon")
		SetData("Crate.Index", 102)
		SetData("Crate.NumContents", 1)
		SetData("Crate.GroundSnap", 0)
		SetData("Crate.Contents", "kWeaponGrenade")
		SendMessage("GameLogic.CreateCrate")
	end

end

function SpawnCrate3()
	if deadcount == 3 then
	        SetData("Crate.Spawn", "WCrate_Jetpack")
		SetData("Crate.Type", "Weapon")
		SetData("Crate.Index", 103)
		SetData("Crate.NumContents", 1)
		SetData("Crate.GroundSnap", 0)
		SetData("Crate.Contents", "kWeaponJetpack")
		SendMessage("GameLogic.CreateCrate")
	end

end

function SpawnCrate4()
	if deadcount == 4 then
	        SetData("Crate.Spawn", "WCrate_Dynamite")
		SetData("Crate.Type", "Weapon")
		SetData("Crate.Index", 104)
		SetData("Crate.NumContents", 1)
		SetData("Crate.GroundSnap", 0)
		SetData("Crate.Contents", "kWeaponDynamite")
		SendMessage("GameLogic.CreateCrate")
	end

end

function SpawnCrate5()
	if deadcount == 5 then
	        SetData("Crate.Spawn", "WCrate_Landmine")
		SetData("Crate.Type", "Weapon")
		SetData("Crate.Index", 105)
		SetData("Crate.NumContents", 1)
		SetData("Crate.GroundSnap", 0)
		SetData("Crate.Contents", "kWeaponLandmine")
		SendMessage("GameLogic.CreateCrate")
	end

end

function SpawnCrate6()
	if deadcount == 6 then
	        SetData("Crate.Spawn", "WCrate_Shotgun")
		SetData("Crate.Type", "Weapon")
		SetData("Crate.Index", 106)
		SetData("Crate.NumContents", 1)
		SetData("Crate.GroundSnap", 0)
		SetData("Crate.Contents", "kWeaponShotgun")
		SendMessage("GameLogic.CreateCrate")
	end

end


--Success/Failure checks

function TurnEnded()
  
	TeamCount = lib_GetActiveAlliances()
	WhichTeam = lib_GetSurvivingTeamIndex()  

    if TeamCount == 0 then
            SendMessage("GameLogic.StarReceived.Failure")
    elseif TeamCount == 1 and WhichTeam == 1 then
            SendMessage("GameLogic.StarReceived.Failure")
    elseif TeamCount == 1 and WhichTeam == 0 and trigcollect == 1 then
            SendMessage("GameLogic.StarReceived.Success")
        
    elseif TeamCount == 1 and WhichTeam == 0 and trigcollect == 0 then
        StartTurn()
    else
        StartTurn()
    end
end