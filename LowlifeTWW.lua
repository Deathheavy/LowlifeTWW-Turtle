-- frame
local f = CreateFrame("Frame")

-- Variáveis
LowlifeTWW_SavedVars = LowlifeTWW_SavedVars or {}
local threshold = LowlifeTWW_SavedVars.threshold or 35
local soundPlayed = false
local soundFile = "Interface\\AddOns\\LowlifeTWW-Turtle\\defaultsound.wav"

-- Função da vida
local function CheckHealth()
    local hp = UnitHealth("player")
    local maxhp = UnitHealthMax("player")
    if maxhp == 0 then return end

    local percent = (hp / maxhp) * 100

    if percent <= threshold and not soundPlayed then
        PlaySoundFile(soundFile)
        soundPlayed = true
    elseif percent > threshold then
        soundPlayed = false
    end
end

f:SetScript("OnUpdate", function()
    CheckHealth()
end)

-- Login
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function()
    DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00LowlifeTWW|r-|cFFFF0000Turtle|r loaded, use |cFFFF0000 /lowlife '0 - 100'|r to change the threshold|r"")
end)

-- Slash command
SLASH_LOWLIFE1 = "/lowlife"
SlashCmdList["LOWLIFE"] = function(msg)
    local num = tonumber(msg)
    if num and num >= 0 and num <= 100 then
        threshold = num
        LowlifeTWW_SavedVars.threshold = num
        DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00LowlifeTWW|r threshold set to |cFFFF0000" .. threshold .. "%|r")
    else
        DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00LowlifeTWW|r current threshold: |cFFFF0000" .. threshold .. "%|r")
    end
end
