local function Initialize_menu()
    Menu = {}
    menu.label("Auto Smite by Nenny and Hatcher");
end

local function Init()
    myHero = object_manager:get_local()
    spellbook = myHero:get_spell_book()
    smiteSlot = spellbook:get_spell_slot_by_name('SummonerSmite')
    Initialize_menu()
end

local function GetSmiteDps()
    level = myHero:get_level()
    baseSmite = 390
    if level == 1 then
        smiteDPS = baseSmite
    elseif level <= 4 then
        smiteDPS = baseSmite + ((level - 1) * 20)
    elseif level <= 9 then
        baseSmite = 450
        smiteDPS = baseSmite + ((level - 4) * 30)
    --calculation wrong here, tested at lvl 12
    elseif level <= 14 then
        baseSmite = 600
        smiteDPS = baseSmite + ((level - 9) * 40)
    elseif level <= 18 then
        baseSmite = 800
        smiteDPS = baseSmite + ((level - 14) * 50)
    else
        print('level not found')
    end
    return smiteDPS
end

function  test2(str)
    str = string.lower(str)
    if string.match(str, "sru")  then
        return true
    end
end

function MyHero_DistTo(point)
    return (myHero:get_position() - point):length()
end

--Filter minions to jungle mobs done by Nenny
function smite()
    GetSmiteDps()
        print(smiteDPS)
    if smiteSlot:is_ready() then
        print(smiteSlot:get_name())
        local  minions = object_manager.get_by_flag(object_t.minion) 
            for i,v in ipairs(minions) do
                local buffManager = v:get_buff_manager()
                --(Local_hero:get_position() - pred_pos):length()
                    if (buffManager:has_buff("resistantskindragon") or buffManager:has_buff("resistantskinminibaron") or buffManager:has_buff("resistantskin") or test2(v:get_name())) and v:is_alive() and v:is_valid() then 
                        local jgPos = v:get_position()
                        if MyHero_DistTo(jgPos) <= 1100 then
                            if v:get_health() <= smiteDPS then
                                print(v:get_health())
                                input.send_spell( spell_slot_t.d , jgPos )
                            end
                        end
                    end
            end 
    end    
end

local function Tick()
    if input.is_key_down(16) then smite() return end
end

Init()
register_callback( "draw", Tick )