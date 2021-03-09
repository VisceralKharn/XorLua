towers = object_manager.get_by_flag(object_t.turret) 

local function Draw()

    for i,v in ipairs(towers) do
        tPos = v:get_position()
        --tRange = v:get_attack_range()
        render.circle_3d( tPos , 750, color:new( 0,125,255, 100 ) )
    end   
end

register_callback( "draw", Draw )

