local function Initialize_menu()
    Menu = {}
    menu.label("Garen Auto Execute");
end


local function Init()
    myHero = object_manager:get_local()
    spellbook = myHero:get_spell_book()
    enemyTable = object_manager.get_valid_enemy_heroes()
    Initialize_menu()
end

function MyHero_DistTo(point)
    return (myHero:get_position() - point):length()
end

local function getRdps(target)
    local rSpell = spellbook:get_spell_slot( spell_slot_t.r )
    local rSpellLvl = rSpell:get_level()
    if rSpell:is_ready() then
        if rSpellLvl == 1 then
            percentToAdd = 0.2
        elseif rSpellLvl == 2 then
            percentToAdd = 0.25
        elseif rSpellLvl == 3 then
            percentToAdd = 0.3
        else
            print('error')
        end
        local eMissingHp = target:get_max_health() - target:get_health()
        if (((150*rSpellLvl)) + (eMissingHp * percentToAdd)) >= target:get_health() then
            input.send_spell( spell_slot_t.r , target:get_position() )
        end
    end
end

local function Execute()
    for k,v in ipairs(enemyTable) do
        if v:is_valid() and v:is_alive() then
            if MyHero_DistTo(v:get_position()) <= 400 then
                if v:get_health() <= getRdps(v) then
                    input.send_spell( spell_slot_t.r , v:get_position() )
                end
            end
        end
    end
end        

local function Tick()
    if input.is_key_down(32) then Execute() return end
end

Init()
register_callback( "draw", Tick )


