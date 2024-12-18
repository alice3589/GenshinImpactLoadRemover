state("GenshinImpact")
{
    bool isLoading : 0x47EB14C;
    bool World_Loaded : 0x4537664;
    bool domainLoading : 0x47EAE90;
}

startup
{
    if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var timingMessage = MessageBox.Show(
            "This game uses Time without Loads (Game Time) as the main timing method.\n"
            + "LiveSplit is currently set to show Real Time (RTA).\n"
            + "Would you like to set the timing method to Game Time?",
            "Genshin Impact | LiveSplit",
            MessageBoxButtons.YesNo, MessageBoxIcon.Question
        );

        if (timingMessage == DialogResult.Yes)
        {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }

        if (timer.IsGameTimePaused)
        {
            timer.IsGameTimePaused = false;
        }
    }
    vars.setStartTime = false;
    vars.worldLoadDelayTimer = 0.0;    
    vars.delayActive = false;         
    vars.previousWorldLoaded = false; 
}

init
{
}

start
{
    return current.World_Loaded;
}

update
{
    if (current.World_Loaded && !vars.previousWorldLoaded)
    {
        vars.worldLoadDelayTimer = 1.2; 
        vars.delayActive = true;       
    }

    if (vars.delayActive)
    {
        vars.worldLoadDelayTimer -= 0.016; 
        if (vars.worldLoadDelayTimer <= 0.0)
        {
            vars.delayActive = false; 
            vars.worldLoadDelayTimer = 0.0; 
        }
    }

    vars.previousWorldLoaded = current.World_Loaded;
}

isLoading
{
    return current.isLoading || current.domainLoading || !current.World_Loaded || vars.delayActive;
}

gameTime
{
    if (vars.setStartTime)
    {
        vars.setStartTime = false;
        return TimeSpan.FromSeconds(-34.10);
    }
}

exit
{
    timer.IsGameTimePaused = true;
}
