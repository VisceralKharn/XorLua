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
    return (((qSpellLvl - 1)*25) + qBase) + myDmg
end

local function qLastHit()
    if qSpell:is_ready() then
        getMinions()
        for i,v in ipairs() do
            if v:is_alive() and v:is_valid() then
              getQDamage()
              if v:get_health() <= getQDamage() then
                  return v:get_position()
              end
            end
        end
    end
end

local function castQ(targetPos)
    input.send_spell(qSpell,targetPos)
end

local function Combo()
    local orbwalker_target = orbwalker.get_target()
    if orbwalker_target ~= nil then
        local target = object_manager.get_by_index(orbwalker_target)
        castQ(target:get_position())
    end
end

local function Farm()
    if qLastHit() ~= nil then
        castQ(qLastHit())
end

local function Tick()
    if input.is_key_down(84) then 
        Farm()
        return 
    end
    if input.is_key_down(32) then
        Combo()
    end
end

Init()
register_callback( "draw", Tick )