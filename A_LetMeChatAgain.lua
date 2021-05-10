local function Initialize_menu()
    Menu = {}
    menu.label("Let Me Chat");
end

local function Init()
    chatOn = 0
    Initialize_menu()
end



local function Tick()
    if input.is_key_down(13) and chatOn == 0 then
        config.set_value('orbwalker_keybind',35)
        config.set_value('orbwalker_last_hit_keybind',35)
        config.set_value('orbwalker_lane_clear_keybind',35)
        chatOn = 1
        return chatOn
    end
    if input.is_key_down(13) and chatOn == 1 then
        config.set_value('orbwalker_keybind',32)
        config.set_value('orbwalker_last_hit_keybind',84)
        config.set_value('orbwalker_lane_clear_keybind',86)
        chatOn = 0
        return chatOn    
    end
    if input.is_key_down(35) then 
        print(config.dump_vars()) 
        
    end
end


Init()
register_callback( "draw", Tick )
