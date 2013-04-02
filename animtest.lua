-- A complex try to modify mario's animation. Very buggy.

function Initialise()

    -- These details are copied from the "databank" for this mission
    -- The players "Mission Team" name and so on will also be TIC
    lib_SetupTeam(0, "team0")
    lib_SetupTeam(1, "team1")
    
    lib_SetupMario(0, "mario0")
    lib_SetupMario(1, "mario1")

    -- Again cloned from the one in the databank
    lib_SetupTeamInventory(0, "inventory")
    lib_SetupTeamInventory(1, "inventory")

    SendMessage("MarioManager.Reinitialise")

    SetData("TurnTime", 0)
    SetData("RoundTime", 0)

    StartFirstTurn()
end


function TurnEnded()
    StartTurn()
end

