-- ============================================
-- 🎮 Choice System for RisuAI v5
-- 선택지 시스템 Lua 트리거
-- 마지막 메시지 + 2번째 위 메시지까지 버튼 표시
-- (유저 메시지가 중간에 있으므로)
-- ============================================

-- ============================================
-- 디스플레이 편집: Choice_system 태그 처리
-- 마지막 + 2번째 위 메시지: 버튼으로 표시
-- 그 외 이전 메시지: 완전히 숨김
-- ============================================
listenEdit("editDisplay", function(triggerId, data)
    local pattern = "<Choice_system>%s*(.-)%s*</Choice_system>"
    local match = data:match(pattern)
    
    if not match then
        return data
    end
    
    -- 전체 채팅 가져오기
    local fullChat = getFullChat(triggerId)
    
    if not fullChat or #fullChat == 0 then
        return data
    end
    
    -- 현재 data가 마지막 3개 메시지 중 하나인지 확인
    -- (마지막, 마지막-1(유저), 마지막-2(이전AI))
    local isRecentMessage = false
    local chatLen = #fullChat
    
    -- 마지막 메시지 확인
    if fullChat[chatLen] and fullChat[chatLen].data then
        if fullChat[chatLen].data:find(match, 1, true) then
            isRecentMessage = true
        end
    end
    
    -- 마지막에서 두 번째 메시지 확인 (유저 메시지일 수 있음)
    if not isRecentMessage and chatLen >= 2 then
        if fullChat[chatLen - 1] and fullChat[chatLen - 1].data then
            if fullChat[chatLen - 1].data:find(match, 1, true) then
                isRecentMessage = true
            end
        end
    end
    
    -- 마지막에서 세 번째 메시지 확인 (이전 AI 메시지)
    if not isRecentMessage and chatLen >= 3 then
        if fullChat[chatLen - 2] and fullChat[chatLen - 2].data then
            if fullChat[chatLen - 2].data:find(match, 1, true) then
                isRecentMessage = true
            end
        end
    end
    
    -- 최근 3개 메시지가 아니면 숨김
    if not isRecentMessage then
        return data:gsub(pattern, "")
    end
    
    -- 선택지 파싱
    local choices = {}
    for line in match:gmatch("[^\r\n]+") do
        local trimmed = line:match("^%s*(.-)%s*$")
        if trimmed and #trimmed > 0 then
            table.insert(choices, trimmed)
        end
    end
    
    if #choices == 0 then
        return data
    end
    
    -- State에 선택지 저장
    setState(triggerId, "current_choices", choices)
    
    -- 버튼 HTML 생성
    local buttonsHTML = [[
<div style="display:flex;flex-direction:column;gap:10px;padding:16px;margin:12px 0;background:linear-gradient(145deg,rgba(25,25,40,0.95),rgba(40,40,60,0.9));border-radius:16px;border:1px solid rgba(138,120,255,0.25);box-shadow:0 8px 32px rgba(0,0,0,0.4);">
]]
    
    for i, choice in ipairs(choices) do
        buttonsHTML = buttonsHTML .. '{{button::' .. choice .. '::CHOICE_' .. i .. '}}\n'
    end
    
    buttonsHTML = buttonsHTML .. '</div>'
    
    return data:gsub(pattern, buttonsHTML)
end)

-- ============================================
-- 리퀘스트 편집: 마지막 선택지만 남기기
-- ============================================
listenEdit("editRequest", function(triggerId, data)
    local pattern = "<Choice_system>%s*(.-)%s*</Choice_system>"
    local match = data:match(pattern)
    
    if not match then
        return data
    end
    
    local choices = {}
    for line in match:gmatch("[^\r\n]+") do
        local trimmed = line:match("^%s*(.-)%s*$")
        if trimmed and #trimmed > 0 then
            table.insert(choices, trimmed)
        end
    end
    
    if #choices > 0 then
        return data:gsub(pattern, choices[#choices])
    else
        return data:gsub(pattern, "")
    end
end)

-- ============================================
-- 버튼 클릭 핸들러 (1~10번)
-- ============================================

function CHOICE_1(triggerId)
    local choices = getState(triggerId, "current_choices")
    if choices and choices[1] then addChat(triggerId, "user", choices[1]) end
end

function CHOICE_2(triggerId)
    local choices = getState(triggerId, "current_choices")
    if choices and choices[2] then addChat(triggerId, "user", choices[2]) end
end

function CHOICE_3(triggerId)
    local choices = getState(triggerId, "current_choices")
    if choices and choices[3] then addChat(triggerId, "user", choices[3]) end
end

function CHOICE_4(triggerId)
    local choices = getState(triggerId, "current_choices")
    if choices and choices[4] then addChat(triggerId, "user", choices[4]) end
end

function CHOICE_5(triggerId)
    local choices = getState(triggerId, "current_choices")
    if choices and choices[5] then addChat(triggerId, "user", choices[5]) end
end

function CHOICE_6(triggerId)
    local choices = getState(triggerId, "current_choices")
    if choices and choices[6] then addChat(triggerId, "user", choices[6]) end
end

function CHOICE_7(triggerId)
    local choices = getState(triggerId, "current_choices")
    if choices and choices[7] then addChat(triggerId, "user", choices[7]) end
end

function CHOICE_8(triggerId)
    local choices = getState(triggerId, "current_choices")
    if choices and choices[8] then addChat(triggerId, "user", choices[8]) end
end

function CHOICE_9(triggerId)
    local choices = getState(triggerId, "current_choices")
    if choices and choices[9] then addChat(triggerId, "user", choices[9]) end
end

function CHOICE_10(triggerId)
    local choices = getState(triggerId, "current_choices")
    if choices and choices[10] then addChat(triggerId, "user", choices[10]) end
end
