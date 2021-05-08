local function Initialize_menu()
    Menu = {}
    menu.label("Gangplank Q Lasthit");
end

local function Init()
    local myHero = object_manager:get_local()
    local spellbook = myHero:get_spell_book()
    local qSpell = spellbook:get_spell_slot( spell_slot_t.q )
    local qRange = 625
    Initialize_menu() 
end

function MyHero_DistTo(point)
    return (myHero:get_position() - point):length()
end

local function getMinions()
    local minionsTable = {}
    local minions = object_manager.get_by_flag(object_t.minion)
        for i,v in ipairs(minions) do
            if MyHero_DistTo(v:get_position()) <= qRange then
                table.insert(minionsTable, v)
            end
        end
end

local function getQDamage()
    local myDmg = myHero:get_attack_damage()
    local qSpellLvl = qSpell:get_level()
    local qBase = 20
    return qDamage = (((qSpellLvl - 1)*25) + qBase) + myDmg
end

local function qLastHit()
    if qSpell:is_ready() then
        getMinions()
        for i,v in ipairs() do
            if v:is_alive() and v:is_valid() then
                if v:get_health() <= getQDamage() then
                    input.send_spell(qSpell,v:get_position())
                end
            end
        end
    end
end

local function Tick()
    if input.is_key_down(84) then 
        qLastHit() 
        return 
    end
end

Init()
register_callback( "draw", Tick )