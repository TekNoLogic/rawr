
----------------------------
--      Localization      --
----------------------------

local L = {
	emote = "You roar with bestial vigor",
	["Illusion: Black Dragonkin"] = "Illusion: Black Dragonkin",
	["Furbolg Form"] = "Furbolg Form",
	["Bear Form"] = "Bear Form",
	["Dire Bear Form"] = "Dire Bear Form",
	["Cat Form"] = "Cat Form",
	["Travel Form"] = "Travel Form",
	["Moonkin Form"] = "Moonkin Form",
	["Ghost Wolf"] = "Ghost Wolf",
}


------------------------------
--      Are you local?      --
------------------------------

local playername = UnitName("player")
local _, race = UnitRace("player")
if race == "Scourge" then race = "Undead" end
local rawrpath = "Sound\\Character\\PlayerRoars\\CharacterRoars"..race..
	((UnitSex("player") == 2) and "Male.wav" or "Female.wav")

local buffs = {
	[L["Bear Form"]]      = "Sound\\Creature\\Bear\\mBearAttackCriticalA.wav",
	[L["Dire Bear Form"]] = "Sound\\Creature\\Bear\\mBearAttackCriticalA.wav",
	[L["Cat Form"]]       = "Sound\\Creature\\Tiger\\mTigerAttackA.wav",
	[L["Travel Form"]]    = "Sound\\Creature\\Tiger\\mTigerAttackA.wav",
	[L["Moonkin Form"]]   = "Sound\\Creature\\ForceofNature\\ForceOfNatureWoundCrit.wav",
	[L["Ghost Wolf"]]     = "Sound\\Creature\\Worgen\\A_FenrusAggro.wav",
	[L["Furbolg Form"]]    = "Sound\\Creature\\Furbolg\\mFurbolgWoundCritical1.wav",
	[L["Illusion: Black Dragonkin"]] = "Sound\\Creature\\DragonSpawn\\mDragonSpawnAttackCritical1.wav",
}

---------------------------------
--      The meaty insides      --
---------------------------------

Rawr = DongleStub("Dongle-Beta1"):New("Rawr")


function Rawr:Enable()
	self:RegisterEvent("CHAT_MSG_TEXT_EMOTE")
end


function Rawr:CHAT_MSG_TEXT_EMOTE(event, emote, name)
	if name ~= playername or not string.find(emote, L.emote) then return end

	for buff,sound in pairs(buffs) do
		if GetPlayerBuffName(buff) then return PlaySoundFile(sound) end
	end

	PlaySoundFile(rawrpath)
end
