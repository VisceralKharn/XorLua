
local function Initialize_menu()
    Menu = {}
    menu.label("Kayn");

    Menu.combo_use_q = menu.checkbox("Use Q", true)
    Menu.combo_mana_q = menu.slider_int( "Mana Q", 0, 100, 10)
    Menu.combo_use_w = menu.checkbox("Use W", true)
    Menu.combo_mana_w = menu.slider_int( "Mana W", 0, 100, 10)

    menu.label("Draw")
    Menu.draw_q = menu.checkbox("Draw Q range", true)

end

allObjects = object_manager.get_valid_objects()
--Spells
qSpeed = 3000
qRange = 350
qWidth = 300
wSpeed = 3000
wRange = 700
wWidth = 500
rSpeed = 2000
rRange = 500
rWidth = 100

local function Init()
    Spell_limiter_q, Spell_limiter_w, Spell_limiter_e, Spell_limiter_r, max_mana  = 0,0,0,0,0
    Initialize_menu()
end

local function Use_Q(target)
    if Local_spellbook:get_spell_slot( spell_slot_t.q ):is_ready() and globals.get_game_time() > Spell_limiter_q then
        --pred speed, travel range, width, cast time
        local pred_pos = target:get_predicted_position( Local_hero:get_position() , qSpeed, qRange, qWidth, 0 )
        if pred_pos:length() > 1  then
            input.send_spell( spell_slot_t.q , pred_pos )
            Spell_limiter_q = globals.get_game_time() + 0.5
        end
    end
end

local function Use_W(target)
    if Local_spellbook:get_spell_slot( spell_slot_t.w ):is_ready() and globals.get_game_time() > Spell_limiter_w then
        --pred speed, travel range, width, cast time
        local pred_pos = target:get_predicted_position( Local_hero:get_position() , wSpeed, wRange, wWidth, 0.55 )
        if pred_pos:length() > 1 then 
            input.send_spell( spell_slot_t.w , pred_pos )
            Spell_limiter_w = globals.get_game_time() + 0.5
        end
    end
end



local function Combo()
    local orbwalker_target = orbwalker.get_target()
    if orbwalker_target ~= nil then
        local target = object_manager.get_by_index( orbwalker_target )
        --print(Menu.combo_use_q:get_value())
        if Menu.combo_use_q:get_value() and Local_hero:get_mana() > max_mana * (Menu.combo_mana_q:get_value()/100) and Local_hero:get_mana() > 40 then Use_Q(target) end
        if Menu.combo_use_w:get_value() and Local_hero:get_mana() > max_mana * (Menu.combo_mana_w:get_value()/100) and Local_hero:get_mana() > 40 then Use_W(target) end

    end
end


local function Draw()
    Local_hero = object_manager.get_local()
    Local_spellbook = Local_hero:get_spell_book()
    

    if Menu.draw_q:get_value() then render.circle_3d( Local_hero:get_position() , qRange, color:new( 0,125,255, 100 ) ) end

    --for i,v in ipairs(allObjects) do
    --    --if string.find(v:get_name(),'turret') then print(v:get_name())  end
    --    
    --    --if v:get_attack_range() > 0 then render.circle_3d(v:get_position(), v:get_attack_range(), color:new( 255, 255, 255 )) end
    --end
end

local function Tick()
    if input.is_key_down(32) then Combo() return end
end

Init()
register_callback( "draw", Tick )
register_callback( "draw", Draw )

