
local function Init()
    myHero = object_manager:get_local()
    spellbook = myHero:get_spell_book()
    enemyTable = object_manager.get_valid_enemy_heroes()
    Initialize_menu()
end

local function lerp(fPos,lPos,divide)
    vectors = {}
    local decimal = 1 / divide
    local increaseAmt = 1 / divide
    while decimal <= 1 do
        table.insert(vectors, fPos:Lerp(lPos, decimal))
        decimal = decimal + increaseAmt
    end
end

local function printLerp()
    for k,v in ipairs(vectors)


local function Tick()
    if input.is_key_down(32) then Ex return end
end

Init()
register_callback( "draw", Tick )
