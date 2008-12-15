
------------------------------
--      Are you local?      --
------------------------------

local playername = UnitName("player")
local ismale = UnitSex("player") == 2
local _, race = UnitRace("player")
if race == "Scourge" then race = "Undead"end
local rawrpath = "Sound\\Character\\PlayerRoars\\CharacterRoars"..race..(ismale and "Male.wav" or "Female.wav")

if race == "Draenei" or race == "BloodElf" then
	rawrpath = "Sound\\Character\\"..race.."\\"..race..(ismale and "Male" or "Female").."Roar01.wav"
end


local buffs = {
	[768] = "Sound\\Creature\\Tiger\\mTigerAttackA.wav", -- Cat Form
	[783] = "Sound\\Creature\\Tiger\\mTigerAttackA.wav", -- Travel Form
	[2645] = "Sound\\Creature\\Worgen\\A_FenrusAggro.wav", -- Ghost Wolf
	[5487] = "Sound\\Creature\\Bear\\mBearAttackCriticalA.wav", -- Bear Form
	[6405]  = "Sound\\Creature\\Furbolg\\mFurbolgWoundCritical1.wav", -- Furbolg Form
	[9634] = "Sound\\Creature\\Bear\\mBearAttackCriticalA.wav", -- Dire Bear Form
	[19937] = "Sound\\Creature\\DragonSpawn\\mDragonSpawnAttackCritical1.wav", -- Illusion: Black Dragonkin
	[24858] = "Sound\\Creature\\ForceofNature\\ForceOfNatureWoundCrit.wav", -- Moonkin Form
	[33891] = "Sound\\Creature\\AncientTreeOfWar\\AncientTreeofWarAttackA.wav", -- Tree of Life
}

---------------------------------
--      The meaty insides      --
---------------------------------


hooksecurefunc("DoEmote", function(emote, msg)
	if emote ~= "ROAR" then return end
	for id,sound in pairs(buffs) do
		local name, _, icon = GetSpellInfo(id)
		local auraname, _, auraicon = UnitAura("player", name)
		if auraname and auraicon == icon then return PlaySoundFile(sound) end
	end

	PlaySoundFile(rawrpath)
end)
