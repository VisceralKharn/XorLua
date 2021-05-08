local myHero = object_manager:get_local()
local spellbook = myHero:get_spell_book()
local qRange = 625

local function Initialize_menu()
    Menu = {}
    menu.label("Gangplank Q Lasthit");
end

local function Init()
    Spell_limiter_q, Spell_limiter_w, Spell_limiter_e, Spell_limiter_r  = 0,0,0,0
    Initialize_menu() 
end

function myHeroDistTo(position)
    return (myHero:get_position() - position):length()
end

local function getMinions(range)
    minionsTable = {}
    local minions = object_manager.get_by_flag(object_t.minion)
        for i,v in ipairs(minions) do
            if myHeroDistTo(v:get_position()) <= range then
                table.insert(minionsTable, v)
            end
        end
    return minionsTable
end

local function getQDamage(target)
    local myDmg = myHero:get_attack_damage()
    local qSpell = spellbook:get_spell_slot( spell_slot_t.q )
    local qSpellLvl = qSpell:get_level()
    local qBase = 20
    return ((((qSpellLvl - 1)*25) + qBase) + myDmg) * ( 100 / ( 100 + target:get_armor()))
end

local function qLastHitPos()
    if spellbook:get_spell_slot( spell_slot_t.q ) then
        for i,v in ipairs(getMinions(qRange)) do
            if v:is_alive() and v:is_valid() and getQDamage(v) ~= 'unknown' then
                if v:get_health() <= getQDamage(v) then
                    return v:get_position()
                end
            end
        end
    end
end

local function castQ(targetPos)
    if globals.get_game_time() > Spell_limiter_q and spellbook:get_spell_slot( spell_slot_t.q ):is_ready() then
        input.send_spell(spell_slot_t.q ,targetPos)
        --Spell_limiter_q = globals.get_game_time() + 0.5
    end
end

local function Combo()
    local orbwalker_target = orbwalker.get_target()
    if orbwalker_target ~= nil then
        local target = object_manager.get_by_index(orbwalker_target)
        if myHeroDistTo(target:get_position()) <= qRange then 
            castQ(target:get_position())
        end
    end
end

local function Farm()
    if qLastHitPos() ~= nil and spellbook:get_spell_slot( spell_slot_t.q ):is_ready() then
        castQ(qLastHitPos())
    end
end

local function Tick()
    if input.is_key_down(84) then 
        Farm()
        return 
    end
    if input.is_key_down(32) then
        Combo()
        return
    end
end

Init()
register_callback( "draw", Tick )