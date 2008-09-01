if IS_WRATH_BUILD == nil then IS_WRATH_BUILD = (select(4, GetBuildInfo()) >= 30000) end

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
local ismale = UnitSex("player") == 2
local _, race = UnitRace("player")
if race == "Scourge" then race = "Undead"
elseif race == "Blood Elf" then race = "BloodElf" end
local rawrpath = "Sound\\Character\\PlayerRoars\\CharacterRoars"..race..(ismale and "Male.wav" or "Female.wav")

if race == "Draenei" or race == "Blood Elf" then
	rawrpath = "Sound\\Character\\"..race.."\\"..race..(ismale and "Male" or "Female").."Roar01.wav"
end


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

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(self, event, emote, name)
	if name ~= playername or not string.find(emote, L.emote) then return end

	for buff,sound in pairs(buffs) do
		if (IS_WRATH_BUILD and UnitAura("player", buff)) or (not IS_WRATH_BUILD and GetPlayerBuffName(buff)) then return PlaySoundFile(sound) end
	end

	PlaySoundFile(rawrpath)
end)
f:RegisterEvent("CHAT_MSG_TEXT_EMOTE")
