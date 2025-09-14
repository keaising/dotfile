-- 创建 menubar 实例
menubar = hs.menubar.new()

-- 悬浮时钟相关变量
local floatingClock = nil
local floatingClockTimer = nil -- 重命名，避免与其他定时器冲突

-- 时区时间获取函数（增强错误处理）
local function currentTime(country)
    -- 时区映射表
    local timezones = {
        ["CN"] = "Asia/Shanghai",
        ["UK"] = "Europe/London",
        ["JP"] = "Asia/Tokyo",
        ["US"] = "America/New_York",
    }

    local timezone = timezones[country] or "UTC"

    -- 使用 pcall 安全执行 date 命令
    local success, result = pcall(function()
        local handle = io.popen("TZ=" .. timezone .. " date '+%Y-%m-%d %H:%M:%S'")
        if handle then
            local output = handle:read("*a")
            handle:close()
            if output and output ~= "" then
                return output:gsub("\n", "")
            end
        end
        return nil
    end)

    if success and result then
        return result
    else
        return os.date("%Y-%m-%d %H:%M:%S")
    end
end

-- 显示悬浮时钟窗口
function showFloatingClock()
    local success, err = pcall(function()
        if floatingClock then
            floatingClock:focus()
            floatingClock:raise()
            return
        end

        -- 定义要显示的时区
        local timeZones = {
            { country = "CN", flag = "🇨🇳", name = "北京" },
            { country = "UK", flag = "🇬🇧", name = "伦敦" },
            { country = "JP", flag = "🇯🇵", name = "东京" },
            { country = "US", flag = "🇺🇸", name = "纽约" },
        }

        -- 创建悬浮窗口
        local screen = hs.screen.mainScreen()
        local frame = screen:frame()

        -- 动态计算内容所需的尺寸
        local timeZoneCount = #timeZones
        local padding = 20
        local timeZoneHeight = 40
        local timeZoneSpacing = 6
        local titleBarHeight = 28
        local extraPadding = 10

        -- 计算窗口尺寸
        local contentHeight = padding
            + (timeZoneHeight * timeZoneCount)
            + (timeZoneSpacing * (timeZoneCount - 1))
            + extraPadding
        local windowHeight = contentHeight + titleBarHeight
        local windowWidth = 300

        floatingClock = hs.webview.new({
            x = frame.w - windowWidth - 20,
            y = 80,
            w = windowWidth,
            h = windowHeight,
        })

        -- 设置窗口属性
        floatingClock:windowStyle({ "titled", "closable" })
        floatingClock:windowTitle("World Clock")
        floatingClock:level(hs.drawing.windowLevels.floating)
        floatingClock:allowTextEntry(true)

        -- 更新时钟内容
        local function updateFloatingClock()
            local html = [[
            <html>
            <head>
                <meta charset="UTF-8">
                <style>
                    html, body {
                        margin: 0;
                        padding: 0;
                        height: 100vh;
                        overflow: hidden;
                        box-sizing: border-box;
                    }
                    body {
                        font-family: 'SF Pro Display', -apple-system, BlinkMacSystemFont, sans-serif;
                        padding: 12px;
                        background: rgba(255,255,255,0.02);
                        color: #333;
                        font-size: 14px;
                        backdrop-filter: blur(25px);
                        -webkit-backdrop-filter: blur(25px);
                        position: relative;
                        display: flex;
                        flex-direction: column;
                        justify-content: flex-start;
                        min-height: calc(100vh - 24px);
                    }
                    body::before {
                        content: '';
                        position: absolute;
                        top: 0;
                        left: 0;
                        right: 0;
                        bottom: 0;
                        background: rgba(255,255,255,0.1);
                        border-radius: 0 0 10px 10px;
                        pointer-events: none;
                    }
                    .content {
                        position: relative;
                        z-index: 1;
                        flex: 1;
                        display: flex;
                        flex-direction: column;
                        gap: 6px;
                    }
                    .time-zone {
                        padding: 10px 12px;
                        background: rgba(255,255,255,0.25);
                        border-radius: 6px;
                        backdrop-filter: blur(15px);
                        -webkit-backdrop-filter: blur(15px);
                        border: 1px solid rgba(0,0,0,0.08);
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
                        min-height: 20px;
                        flex-shrink: 0;
                    }
                    .city-info {
                        display: flex;
                        align-items: center;
                        gap: 6px;
                        flex: 1;
                    }
                    .flag {
                        font-size: 16px;
                        filter: drop-shadow(0 1px 1px rgba(0,0,0,0.2));
                        flex-shrink: 0;
                    }
                    .city-name {
                        font-weight: 600;
                        font-size: 14px;
                        color: #444;
                        text-shadow: 0 1px 1px rgba(255,255,255,0.8);
                        white-space: nowrap;
                    }
                    .time {
                        font-family: 'Consolas Nerd Font', 'SF Mono',  Consolas, 'Source Code Pro', Menlo, Monaco, 'Courier New', monospace;
                        font-weight: bold;
                        font-size: 13px;
                        color: #1a1a1a;
                        background: rgba(255,255,255,0.4);
                        padding: 3px 6px;
                        border-radius: 4px;
                        border: 1px solid rgba(0,0,0,0.08);
                        text-shadow: 0 1px 1px rgba(255,255,255,0.5);
                        white-space: nowrap;
                        flex-shrink: 0;
                    }
                </style>
            </head>
            <body>
                <div class="content">]]

            -- 动态生成时区内容
            for _, zone in ipairs(timeZones) do
                html = html
                    .. [[
                    <div class="time-zone">
                        <div class="city-info">
                            <span class="flag">]]
                    .. zone.flag
                    .. [[</span>
                            <span class="city-name">]]
                    .. zone.name
                    .. [[</span>
                        </div>
                        <span class="time">]]
                    .. currentTime(zone.country)
                    .. [[</span>
                    </div>]]
            end

            html = html .. [[
                </div>
            </body>
            </html>
            ]]

            if floatingClock then
                floatingClock:html(html)
            end
        end

        -- 立即更新一次
        updateFloatingClock()

        -- 每秒更新时钟显示
        floatingClockTimer = hs.timer.doEvery(1, function()
            local success, err = pcall(updateFloatingClock)
        end)

        -- 显示窗口
        floatingClock:show()
    end)

    if not success then
        -- 清理资源
        if floatingClock then
            pcall(function()
                floatingClock:delete()
            end)
            floatingClock = nil
        end
        if floatingClockTimer then
            pcall(function()
                floatingClockTimer:stop()
            end)
            floatingClockTimer = nil
        end
    end
end

local function init()
    if not menubar then
        menubar = hs.menubar.new()
    end

    menubar:setTitle("🪙")
    menubar:setClickCallback(showFloatingClock)
end

init()
