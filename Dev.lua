function Render_obj_info()
    if Draw_ai_objects == true then
        local obj_table = object_manager.get_by_flag( object_t.ai )
        for i, obj in ipairs(obj_table) do
            local renderPos = xmath.world_to_screen(obj:get_position())
            local objName = obj:get_name( )
            render.text( renderPos, objName, 15, color:new( 255, 255, 255 ) )
            render.text_shadow( renderPos, objName, 15, color:new( 255, 255, 255 ) )
        end
        return true
    end
    if Draw_minion_objects  == true then --Draw_minion_objects:get_value() == true
        local obj_table = object_manager.get_by_flag( object_t.minion )
        for i, obj in ipairs(obj_table) do
            local renderPos = xmath.world_to_screen(obj:get_position())
            local objName = obj:get_name( )
            render.text( renderPos, objName, 15, color:new( 255, 255, 255 ) )
            render.text_shadow( renderPos, objName, 15, color:new( 255, 255, 255 ) )
        end
        return true
    end
    if Draw_hero_objects  == true then --Draw_minion_objects:get_value() == true
        local obj_table = object_manager.get_by_flag( object_t.hero )
        for i, obj in ipairs(obj_table) do
            local renderPos = xmath.world_to_screen(obj:get_position())
            local objName = obj:get_name( )
            render.text( renderPos, objName, 15, color:new( 255, 255, 255 ) )
            render.text_shadow( renderPos, objName, 15, color:new( 255, 255, 255 ) ) 
        end
        return true
    end
    if Draw_building_objects  == true then --Draw_minion_objects:get_value() == true
        local obj_table = object_manager.get_by_flag( object_t.building )
        for i, obj in ipairs(obj_table) do
            local renderPos = xmath.world_to_screen(obj:get_position())
            local objName = obj:get_name( )
            render.text( renderPos, objName, 15, color:new( 255, 255, 255 ) )
            render.text_shadow( renderPos, objName, 15, color:new( 255, 255, 255 ) )
        end
        return true
    end
    if Draw_missile_objects  == true then --Draw_minion_objects:get_value() == true
        local obj_table = object_manager.get_by_flag( object_t.missile )
        for i, obj in ipairs(obj_table) do
            local renderPos = xmath.world_to_screen(obj:get_position())
            local objName = obj:get_name( )
            render.text( renderPos, objName, 15, color:new( 255, 255, 255 ) )
            render.text_shadow( renderPos, objName, 15, color:new( 255, 255, 255 ) )
        end
        return true
    end
    if Draw_turret_objects  == true then --Draw_minion_objects:get_value() == true
        local obj_table = object_manager.get_by_flag( object_t.turret )
        for i, obj in ipairs(obj_table) do
            local renderPos = xmath.world_to_screen(obj:get_position())
            local objName = obj:get_name( )
            render.text( renderPos, objName, 15, color:new( 255, 255, 255 ) )
            render.text_shadow( renderPos, objName, 15, color:new( 255, 255, 255 ) )
        end
        return true
    end
    if Draw_all_objects  == true then --Draw_minion_objects:get_value() == true
        local obj_table = object_manager.get_valid_objects( )
        for i, obj in ipairs(obj_table) do
            local renderPos = xmath.world_to_screen(obj:get_position())
            local objName = obj:get_name( )
            render.text( renderPos, objName, 15, color:new( 255, 255, 255 ) )
            render.text_shadow( renderPos, objName, 15, color:new( 255, 255, 255 ) )
        end
        return true
    end
    if Draw_all_objects_with_valid_name  == true then --Draw_minion_objects:get_value() == true
        local obj_table = object_manager.get_valid_objects( )
        for i, obj in ipairs(obj_table) do
            local objName = obj:get_name( )
            if string.find(objName, "?") or string.find(objName, "@")  or string.find(objName, "Object")  or objName == "" then
                goto skip
            end
            local renderPos = xmath.world_to_screen(obj:get_position())
            if renderPos.x > 1920.00 or renderPos.y > 1080.00 or renderPos.x < 10.00 or renderPos.y < 10.00 then
                goto skip
            end
            render.text( renderPos, "Name : " ..objName, 15, color:new( 255, 255, 255 ) )
            render.text( vec2:new(renderPos.x, renderPos.y + 15), "Index : " ..obj:get_index( ), 15, color:new( 255, 255, 255 ) )
            render.text( vec2:new(renderPos.x, renderPos.y + 30), "Level : " ..obj:get_level( ), 15, color:new( 255, 255, 255 ) )
            render.text( vec2:new(renderPos.x, renderPos.y + 45), "Is Teammate : " ..tostring(obj:is_teammate( )), 15, color:new( 255, 255, 255 ) )
            render.text( vec2:new(renderPos.x, renderPos.y + 60), "Is Alive : " ..tostring(obj:is_alive( )), 15, color:new( 255, 255, 255 ) )
            render.text( vec2:new(renderPos.x, renderPos.y + 75), "Position : X= " .. obj:get_position().x .. " Y= " .. obj:get_position().y .. " Z= " .. obj:get_position().z, 15, color:new( 255, 255, 255 ) )
           ::skip::
        end
        return true
    end
    return true
end

function Render_hero_info()
    local my_hero = object_manager.get_local( )
    render.text( vec2:new(200, 15), "Object Vars", 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, 30), "Name : " ..my_hero:get_name(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, 45), "Champ Name : " ..my_hero:get_champ_name(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, 60), "Index : " ..my_hero:get_index(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, 75), "Position : X= " .. my_hero:get_position().x .. " Y= " .. my_hero:get_position().y .. " Z= " .. my_hero:get_position().z, 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, 90), "AD : " ..my_hero:get_attack_damage(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, 105), "Gold : " ..my_hero:get_current_gold(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, 120), "Max HP : " ..my_hero:get_max_health(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, 135), "HP : " ..my_hero:get_health(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, 150), "Level : " ..my_hero:get_level(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, 165), "Attack Speed : " ..my_hero:get_attack_speed(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, 180), "Attack Range : " ..my_hero:get_attack_range(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, 195), "HP Reg : " ..my_hero:get_health_regen(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, 210), "MS : " ..my_hero:get_movement_speed(), 15, color:new( 255, 255, 255 ) )
end

function Render_hero_buffs()
    local my_hero = object_manager.get_local( )
    local buff_manager = my_hero:get_buff_manager( )
    local active_buffs = buff_manager:get_active_buffs( )
    render.text( vec2:new(200, 250), "Active Buffs", 15, color:new( 255, 255, 255 ) )
    local render_y = 250
    for i, buff in ipairs(active_buffs) do
        render_y = render_y + 15
        render.text( vec2:new(200, render_y), "Name :".. buff:get_name(), 15, color:new( 255, 255, 255 ) )
        render.text( vec2:new(100, render_y), "Stacks :".. buff:get_amount( ), 15, color:new( 255, 255, 255 ) )
    end
    return render_y
end

function Render_hero_spells(offset)
    local render_y = offset + 40
    render.text( vec2:new(200, render_y), "Spells", 15, color:new( 255, 255, 255 ) )
    local my_hero = object_manager.get_local( )
    local spell_book = my_hero:get_spell_book( )
    local spell_slot_Q = spell_book:get_spell_slot( spell_slot_t.q )
    local spell_slot_W = spell_book:get_spell_slot( spell_slot_t.w )
    local spell_slot_E = spell_book:get_spell_slot( spell_slot_t.e )
    local spell_slot_R = spell_book:get_spell_slot( spell_slot_t.r )
    render.text( vec2:new(200, render_y+15), "Q :", 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, render_y+30), "Is Ready : " ..tostring(spell_slot_Q:is_ready( )), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, render_y+45), "Cooldown Expire : " ..spell_slot_Q:get_cooldown_expire(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, render_y+60), "Cooldown : " ..spell_slot_Q:get_cooldown(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, render_y+75), "Level : " ..spell_slot_Q:get_level(), 15, color:new( 255, 255, 255 ) )
    render_y = render_y + 75
    render.text( vec2:new(200, render_y+15), "W :", 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, render_y+30), "Is Ready : " ..tostring(spell_slot_W:is_ready( )), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, render_y+45), "Cooldown Expire : " ..spell_slot_W:get_cooldown_expire(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, render_y+60), "Cooldown : " ..spell_slot_W:get_cooldown(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, render_y+75), "Level : " ..spell_slot_W:get_level(), 15, color:new( 255, 255, 255 ) )
    render_y = render_y + 75
    render.text( vec2:new(200, render_y+15), "E :", 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, render_y+30), "Is Ready : " ..tostring(spell_slot_E:is_ready( )), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, render_y+45), "Cooldown Expire : " ..spell_slot_E:get_cooldown_expire(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, render_y+60), "Cooldown : " ..spell_slot_E:get_cooldown(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, render_y+75), "Level : " ..spell_slot_E:get_level(), 15, color:new( 255, 255, 255 ) )
    render_y = render_y + 75
    render.text( vec2:new(200, render_y+15), "R :", 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, render_y+30), "Is Ready : " ..tostring(spell_slot_R:is_ready( )), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, render_y+45), "Cooldown Expire : " ..spell_slot_R:get_cooldown_expire(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, render_y+60), "Cooldown : " ..spell_slot_R:get_cooldown(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, render_y+75), "Level : " ..spell_slot_R:get_level(), 15, color:new( 255, 255, 255 ) )
    render_y = render_y + 75
    return render_y
end

function Render_misc(offset)
    local render_y = offset + 40
    render.text( vec2:new(200, render_y), "Misc", 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, render_y+15), "Game Time : ".. globals.get_game_time(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, render_y+30), "Check Tick : ".. globals.get_cheat_tick(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, render_y+45), "Resolution : ".. "X= " .. render.get_resolution( ).x .. " Y= ".. render.get_resolution( ).y , 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, render_y+60), "Attack Ratio : ".. hero.get_attack_ratio(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, render_y+75), "Windup : ".. hero.get_windup(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, render_y+90), "Windup % : ".. hero.get_windup_percentage(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, render_y+105), "Xorbot uid : ".. xorbot.get_user( ), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(200, render_y+120), "Mouse pos : ".. "X= " .. input.get_cursor_position( ).x .. " Y= ".. input.get_cursor_position( ).y , 15, color:new( 255, 255, 255 ) )
end


function Render_target_info()
    local my_hero = object_manager.get_by_index( Target_index )
    render.text( vec2:new(1200, 15), "Orb target vars", 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, 30), "Name : " ..my_hero:get_name(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, 45), "Champ Name : " ..my_hero:get_champ_name(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, 60), "Index : " ..my_hero:get_index(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, 75), "Position : X= " .. my_hero:get_position().x .. " Y= " .. my_hero:get_position().y .. " Z= " .. my_hero:get_position().z, 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, 90), "AD : " ..my_hero:get_attack_damage(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, 105), "Gold : " ..my_hero:get_current_gold(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, 120), "Max HP : " ..my_hero:get_max_health(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, 135), "HP : " ..my_hero:get_health(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, 150), "Level : " ..my_hero:get_level(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, 165), "Attack Speed : " ..my_hero:get_attack_speed(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, 180), "Attack Range : " ..my_hero:get_attack_range(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, 195), "HP Reg : " ..my_hero:get_health_regen(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, 210), "MS : " ..my_hero:get_movement_speed(), 15, color:new( 255, 255, 255 ) )
end

function Render_target_buffs()
    local my_hero = object_manager.get_by_index( Target_index )
    local buff_manager = my_hero:get_buff_manager( )
    local active_buffs = buff_manager:get_active_buffs( )
    render.text( vec2:new(1200, 250), "Active Buffs", 15, color:new( 255, 255, 255 ) )
    local render_y = 250
    for i, buff in ipairs(active_buffs) do
        render_y = render_y + 15
        render.text( vec2:new(1200, render_y), "Name :".. buff:get_name(), 15, color:new( 255, 255, 255 ) )
        render.text( vec2:new(1100, render_y), "Stacks :".. buff:get_amount( ), 15, color:new( 255, 255, 255 ) )
    end
    return render_y
end

function Render_target_spells(offset)
    local render_y = offset + 40
    render.text( vec2:new(1200, render_y), "Spells", 15, color:new( 255, 255, 255 ) )
    local my_hero = object_manager.get_by_index( Target_index )
    local spell_book = my_hero:get_spell_book( )
    local spell_slot_Q = spell_book:get_spell_slot( spell_slot_t.q )
    local spell_slot_W = spell_book:get_spell_slot( spell_slot_t.w )
    local spell_slot_E = spell_book:get_spell_slot( spell_slot_t.e )
    local spell_slot_R = spell_book:get_spell_slot( spell_slot_t.r )
    render.text( vec2:new(1200, render_y+15), "Q :", 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, render_y+30), "Is Ready : " ..tostring(spell_slot_Q:is_ready( )), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, render_y+45), "Cooldown Expire : " ..spell_slot_Q:get_cooldown_expire(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, render_y+60), "Cooldown : " ..spell_slot_Q:get_cooldown(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, render_y+75), "Level : " ..spell_slot_Q:get_level(), 15, color:new( 255, 255, 255 ) )
    render_y = render_y + 75
    render.text( vec2:new(1200, render_y+15), "W :", 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, render_y+30), "Is Ready : " ..tostring(spell_slot_W:is_ready( )), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, render_y+45), "Cooldown Expire : " ..spell_slot_W:get_cooldown_expire(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, render_y+60), "Cooldown : " ..spell_slot_W:get_cooldown(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, render_y+75), "Level : " ..spell_slot_W:get_level(), 15, color:new( 255, 255, 255 ) )
    render_y = render_y + 75
    render.text( vec2:new(1200, render_y+15), "E :", 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, render_y+30), "Is Ready : " ..tostring(spell_slot_E:is_ready( )), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, render_y+45), "Cooldown Expire : " ..spell_slot_E:get_cooldown_expire(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, render_y+60), "Cooldown : " ..spell_slot_E:get_cooldown(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, render_y+75), "Level : " ..spell_slot_E:get_level(), 15, color:new( 255, 255, 255 ) )
    render_y = render_y + 75
    render.text( vec2:new(1200, render_y+15), "R :", 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, render_y+30), "Is Ready : " ..tostring(spell_slot_R:is_ready( )), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, render_y+45), "Cooldown Expire : " ..spell_slot_R:get_cooldown_expire(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, render_y+60), "Cooldown : " ..spell_slot_R:get_cooldown(), 15, color:new( 255, 255, 255 ) )
    render.text( vec2:new(1200, render_y+75), "Level : " ..spell_slot_R:get_level(), 15, color:new( 255, 255, 255 ) )
    render_y = render_y + 75
    return render_y
end

function Render_hero()
    if Draw_hero_info == true then Render_hero_info() end
    if Draw_hero_buffs == true then next_offset = Render_hero_buffs() end
    if Draw_hero_spells == true then next_offset = Render_hero_spells(next_offset) end
    if Draw_misc == true then Render_misc(next_offset) end
end

function Render_target()
    Target_index = orbwalker.get_target( )
    if Target_index ~= -1 then
        if Draw_target_info == true then Render_target_info() end
        if Draw_target_buffs == true then next_offset1 = Render_target_buffs() end
        if Draw_target_spells == true then next_offset1 = Render_target_spells(next_offset1) end
    end
end

function Render_obj_list(type)
    local render_y = 15
    render.text( vec2:new(700, render_y), "Objects :", 15, color:new( 255, 255, 255 ) )
    if type == "ai" then
        local obj_table = object_manager.get_by_flag( object_t.ai )
        for i, obj in ipairs(obj_table) do
            render_y = render_y + 15
            render.text( vec2:new(700, render_y), obj:get_name(), 15, color:new( 255, 255, 255 ) )
        end
        return true
    end
    if type == "minion" then --Draw_minion_objects:get_value() == true
        local obj_table = object_manager.get_by_flag( object_t.minion )
        for i, obj in ipairs(obj_table) do
            render_y = render_y + 15
            render.text( vec2:new(700, render_y), obj:get_name(), 15, color:new( 255, 255, 255 ) )
        end
        return true
    end
    if type == "hero" then --Draw_minion_objects:get_value() == true
        local obj_table = object_manager.get_by_flag( object_t.hero )
        for i, obj in ipairs(obj_table) do
            render_y = render_y + 15
            render.text( vec2:new(700, render_y), obj:get_name(), 15, color:new( 255, 255, 255 ) )
        end
        return true
    end
    if type == "building" then --Draw_minion_objects:get_value() == true
        local obj_table = object_manager.get_by_flag( object_t.building )
        for i, obj in ipairs(obj_table) do
            render_y = render_y + 15
            render.text( vec2:new(700, render_y), obj:get_name(), 15, color:new( 255, 255, 255 ) )
        end
        return true
    end
    if type == "missile" then --Draw_minion_objects:get_value() == true
        local obj_table = object_manager.get_by_flag( object_t.missile )
        for i, obj in ipairs(obj_table) do
            render_y = render_y + 15
            render.text( vec2:new(700, render_y), obj:get_name(), 15, color:new( 255, 255, 255 ) )
        end
        return true
    end
    if type == "turret" then --Draw_minion_objects:get_value() == true
        local obj_table = object_manager.get_by_flag( object_t.turret )
        for i, obj in ipairs(obj_table) do
            render_y = render_y + 15
            render.text( vec2:new(700, render_y), obj:get_name(), 15, color:new( 255, 255, 255 ) )
        end
        return true
    end
    if type == "all" then --Draw_minion_objects:get_value() == true
        local obj_table = object_manager.get_valid_objects( )
        for i, obj in ipairs(obj_table) do
            render_y = render_y + 15
            render.text( vec2:new(700, render_y), obj:get_name(), 15, color:new( 255, 255, 255 ) )
        end
        return true
    end
    if type == "all2" then --Draw_minion_objects:get_value() == true
        local obj_table = object_manager.get_valid_objects( )
        for i, obj in ipairs(obj_table) do
            local objName = obj:get_name( )
            if string.find(objName, "?") or string.find(objName, "@")  or string.find(objName, "Object")  or objName == "" then
                goto skip
            end
            render_y = render_y + 15
            render.text( vec2:new(700, render_y), obj:get_name(), 15, color:new( 255, 255, 255 ) )
            ::skip::
        end
        return true
    end
    return true
end

-----------------------------------------
Draw_obj_info = true

Draw_ai_objects = false
Draw_minion_objects  = false
Draw_hero_objects  = false
Draw_turret_objects  = false
Draw_missile_objects  = false
Draw_building_objects  = true
Draw_all_objects_with_valid_name = false
-----------------------------------------
Draw_hero = true

Draw_hero_info = true
Draw_hero_buffs = true
Draw_hero_spells = true
Draw_misc = true
-----------------------------------------
Draw_target = false

Target_index = -1
Draw_target_info = false
Draw_target_buffs = false
Draw_target_spells = false
-----------------------------------------
Draw_obj_list = false

Draw_obj_type = "all2"

function draw()
    if Draw_obj_info == true then Render_obj_info() end
    if Draw_hero == true then Render_hero() end
    if Draw_target == true then Render_target() end
    if Draw_obj_list == true then Render_obj_list(Draw_obj_type) end
end       


register_callback( "draw", draw )

--isChanneling

