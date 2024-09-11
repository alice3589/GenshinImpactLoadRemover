state("GenshinImpact")
{
	bool isLoading : 0x3B64CB4;
	bool World_Loaded : 0x3E26110;
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
    }
	vars.setStartTime = false;
}

init
{
	timer.IsGameTimePaused = false;
}

start
{
    return current.World_Loaded;
}

update
{
	
}

isLoading
{
	return current.isLoading || !current.World_Loaded;
}

gameTime
{
    if(vars.setStartTime)
    {
        vars.setStartTime = false;
        return TimeSpan.FromSeconds(-34.10);
    }
}

exit
{
    timer.IsGameTimePaused = true;
}