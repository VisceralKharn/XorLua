
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

end


--object:get_predicted_position( projectile_speed, projectile_range, projectile_width, cast_time ): vec3

local function Init()
    Spell_limiter_q, Spell_limiter_w, Spell_limiter_e, Spell_limiter_r, max_mana  = 0,0,0,0,0            
    Initialize_menu()
end

qRange = 350
qSize = 100
wSpeed = 500
wRange = 1325
wSize = 200
eSpeed = 1200
eRange = 950
eSize = 200

local function Use_Q(target)
    if Local_spellbook:get_spell_slot( spell_slot_t.q ):is_ready() and globals.get_game_time() > Spell_limiter_q then
        --pred speed, range, width, cast time
        local pred_pos = target:get_position()
        local myPos = Local_hero:get_position()
        if (myPos - pred_pos):length() <= qRange then
            input.send_spell( spell_slot_t.q , myPos )
            Spell_limiter_q = globals.get_game_time() + 0.5
        end
    end
end

local function Use_W(target)
    if Local_spellbook:get_spell_slot( spell_slot_t.w ):is_ready() and globals.get_game_time() > Spell_limiter_w then
        local pred_pos = target:get_predicted_position( Local_hero:get_position() , wSpeed, wRange, wSize, 0.50 )
        if pred_pos:length() > 1 and not collision.is_minion_in_line( pred_pos, wSize ) then
            input.send_spell( spell_slot_t.w , pred_pos )
            Spell_limiter_w = globals.get_game_time() + 0.5
        end
    end
end

local function Use_E(target)
    if Local_spellbook:get_spell_slot( spell_slot_t.e ):is_ready() and globals.get_game_time() > Spell_limiter_e then
        local pred_pos = target:get_predicted_position( Local_hero:get_position() , eSpeed, eRange, eSize, 0.25 )
        if pred_pos:length() > 1 then
            input.send_spell( spell_slot_t.e , pred_pos )
            Spell_limiter_e = globals.get_game_time() + 0.5
        end
    end
end


local function Combo()
    local orbwalker_target = orbwalker.get_target()
    if orbwalker_target ~= nil then
        local target = object_manager.get_by_index( orbwalker_target )
        if Menu.combo_use_q:get_value() and Local_hero:get_mana() > max_mana * (Menu.combo_mana_q:get_value()/100) and Local_hero:get_mana() > 40 then Use_Q(target) end
    end
end

local function Tick()
    if input.is_key_down(32) then Combo() return end
end


Init()
register_callback( "draw", Tick )
