//Created by alice_3589
state("GenshinImpact")
{
    bool isLoading : 0x3B6BA34;
    bool ALoading : 0x3B64CB4;
    bool BLoading : 0x3B6A150;
    bool CLoading : 0x36370E0;
}

isLoading
{
    return current.isLoading || current.ALoading || current.BLoading || current.CLoading;
}

exit
{
    timer.IsGameTimePaused = true;
}
