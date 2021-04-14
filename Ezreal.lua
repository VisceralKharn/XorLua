local function Use_Q(target)
    if Local_spellbook:get_spell_slot( spell_slot_t.q ):is_ready() then
        local pred_pos = target:get_predicted_position( Local_hero:get_position() , 2000, 1200, 120, 0.25 )
        if pred_pos:length() > 1 and not collision.is_minion_in_line( pred_pos, 120 ) then
            input.send_spell( spell_slot_t.q , pred_pos )
        end
    end
end

local function Use_W(target)
    if Local_spellbook:get_spell_slot( spell_slot_t.w ):is_ready() then
        local pred_pos = target:get_predicted_position( Local_hero:get_position() , 1700, 1200, 160, 0.25 )
        if pred_pos:length() > 1 then
            input.send_spell( spell_slot_t.w, pred_pos )
        end
    end
end

local function Combo()
    local orbwalker_target = orbwalker.get_target()
    if orbwalker_target ~= -1 then
        local target = object_manager.get_by_index( orbwalker_target )
        Use_Q(target)
        Use_W(target)
    end
end

local function Draw()
    Local_hero = object_manager.get_local()
    Local_spellbook = Local_hero:get_spell_book()

    if input.is_key_down(32) then Combo() end
end

register_callback("draw", Draw)


