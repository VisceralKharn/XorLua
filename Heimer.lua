
local function Initialize_menu()
    Menu = {}
    menu.label("Heimer");

    menu.label("Combo")
    Menu.combo_use_q = menu.checkbox("Use Q", true)
    Menu.combo_mana_q = menu.slider_int( "Mana Q", 0, 100, 10)
    Menu.combo_use_e = menu.checkbox("Use W", true)
    Menu.combo_mana_e = menu.slider_int( "Mana W", 0, 100, 10)
    Menu.combo_use_w = menu.checkbox("Use E", true)
    Menu.combo_mana_w = menu.slider_int( "Mana E", 0, 100, 10)
    Menu.combo_use_r = menu.checkbox("Use R", true)
    Menu.combo_mana_r = menu.slider_int( "Mana R", 0, 100, 10)
    
    --menu.label("Mixed")
    --Menu.mixed_use_q = menu.checkbox("Use Q", true)
    --Menu.mixed_mana_q = menu.slider_int( "Mana Q", 0, 100, 10)

    menu.label("Draw")
    Menu.draw_q = menu.checkbox("Draw Q range", true)

end


--object:get_predicted_position( projectile_speed, projectile_range, projectile_width, cast_time ): vec3

local function Init()
    Spell_limiter_q, Spell_limiter_w, Spell_limiter_e, Spell_limiter_r, max_mana  = 0,0,0,0,0
    my_hero = object_manager.get_local( )
    spell_book = my_hero:get_spell_book( )
    spell_slot_Q = spell_book:get_spell_slot( spell_slot_t.q )
    spell_slot_W = spell_book:get_spell_slot( spell_slot_t.w )
    spell_slot_E = spell_book:get_spell_slot( spell_slot_t.e )
    spell_slot_R = spell_book:get_spell_slot( spell_slot_t.r )
    
    spellsList = evade.get_active_spells()
            
    qRange = 1
    qSize = 100
    wSpeed = 500
    wRange = 1325
    wSize = 200
    eSpeed = 1200
    eRange = 950
    eSize = 200
    --spell_book:get_spell_slot( slot: spell_slot_t ): spell_slot | nil
    --rSpeed = spell:get_speed(r)
    --rRange = Local_spellbook:get_spell_slot(spell_slot_t.r):get_speed()
    --rSize = Local_spellbook:get_spell_slot(spell_slot_t.r):get_speed()
    Initialize_menu()
end





--local function Use_Q(target)
--    if Local_spellbook:get_spell_slot( spell_slot_t.q ):is_ready() and globals.get_game_time() > Spell_limiter_q then
--        --pred speed, travel range, width, cast time
--        local pred_pos = target:get_predicted_position( Local_hero:get_position() , qSpeed, qRange, qSize, 0.25 )
--        if pred_pos:length() > 1 then
--            input.send_spell( spell_slot_t.q , pred_pos )
--            Spell_limiter_q = globals.get_game_time() + 0.5
--        end
--    end
--end

--local function Use_Q(me)
--    if Local_spellbook:get_spell_slot( spell_slot_t.q ):is_ready() and globals.get_game_time() > Spell_limiter_q then
--        local myPos = me:get_position()
--        if myPos:length() > 1 then
--            input.send_spell(spell_slot_t.q, myPos)
--            Spell_limiter_ = globals.get_game_time() + 0.5
--        end
--    end
--end

--evade.get_active_spells( ): list<spell>

local function Use_E(target)
    if Local_spellbook:get_spell_slot( spell_slot_t.e ):is_ready() and globals.get_game_time() > Spell_limiter_e then
        --pred speed, travel range, width, cast time
        local pred_pos = target:get_predicted_position( Local_hero:get_position() , eSpeed, eRange, eSize, 0.25 )
        if pred_pos:length() > 1 then
            input.send_spell( spell_slot_t.e , pred_pos )
            Spell_limiter_e = globals.get_game_time() + 0.5
        end
    end
end


local function Use_W(target)
    if Local_spellbook:get_spell_slot( spell_slot_t.w ):is_ready() and globals.get_game_time() > Spell_limiter_w then
        --pred speed, travel range, width, cast time
        local pred_pos = target:get_predicted_position( Local_hero:get_position() , wSpeed, wRange, wSize, 0.50 )
        if pred_pos:length() > 1 and not collision.is_minion_in_line( pred_pos, wSize ) then
            input.send_spell( spell_slot_t.w , pred_pos )
            Spell_limiter_w = globals.get_game_time() + 0.5
        end
    end
end


local function Combo()
    local orbwalker_target = orbwalker.get_target()
    print(orbwalker_target)
    --local orbwalker_target = GetEnemies()
    --render.text(vec2:new( 100, 100 ), tostring(orbwalker_target), 32, color:new( 255, 255, 255 ) )
    if orbwalker_target ~= nil then
        local target = object_manager.get_by_index( orbwalker_target )
        --if Menu.combo_use_q:get_value() and Local_hero:get_mana() > max_mana * (Menu.combo_mana_q:get_value()/100) and Local_hero:get_mana() > 40 then Use_Q(Local_hero) end
        if Menu.combo_use_e:get_value() and Local_hero:get_mana() > max_mana * (Menu.combo_mana_e:get_value()/100) and Local_hero:get_mana() > 40 then Use_E(target) end
        --if Menu.combo_use_w:get_value() and Local_hero:get_mana() > max_mana * (Menu.combo_mana_w:get_value()/100) and Local_hero:get_mana() > 40 then Use_W(target) end
        
    end
end

local function Draw()
    Local_hero = object_manager.get_local()
    Local_spellbook = Local_hero:get_spell_book()
    myPosString = tostring(Local_hero:get_position())
    if Menu.draw_q:get_value() then render.circle_3d( Local_hero:get_position() , eRange, color:new( 0,125,255, 100 ) ) end
    if Local_hero:get_mana() > max_mana then max_mana = Local_hero:get_mana() return end
end

local function Tick()
    if input.is_key_down(67) then Combo() return end
    --if input.is_key_down(84) then Mixed() return end
end

Init()
register_callback( "draw", Tick )
register_callback( "draw", Draw )
--register_callback( "draw", GetEnemies )
