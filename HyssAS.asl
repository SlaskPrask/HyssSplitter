state("TAG")
{
	/* States:
	-2: In main Menu
	-1: Is Loading
	 0:	In game
	 1: Beat Level
	 2: Beat Game
   100: In pause menu */

	int state : 0x056F9388, 0x100, 0x368, 0x90, 0x218, 0x468;
}

init
{
	vars.level = 0;	
}

startup
{
	settings.Add("lv", true, "Split on level end");
	settings.Add("lv1", true, "Forest", "lv");
	settings.Add("lv2", true, "Barn", "lv");
	settings.Add("lv3", true, "Swamp", "lv");
	settings.Add("lv4", true, "Lake", "lv");
	settings.Add("lv5", true, "Cave", "lv");
}

start
{
	if (old.state == -2 && current.state == 0)
	{
		vars.level = 1;
		return true;
	}		
}

split
{
	if (old.state != current.state)
	{
		if (current.state == 1)
		{
			bool split = settings["lv" + vars.level];
			vars.level++;
			return split;
		}	
		return (current.state == 2);
	}
}

reset
{
	return (old.state != -2 && current.state == -2);
}

isLoading
{
	return (current.state == -1);
}