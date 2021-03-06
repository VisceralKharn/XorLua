local pi = math.pi
local sqrt = math.sqrt
local cos = math.cos
local sin = math.sin
local floor = math.floor
local tointeger =  math.tointeger
local max = math.max
local min = math.min
local abs = math.abs

function Class()		
	local cls = {}; cls.__index = cls		
	return setmetatable(cls, {__call = function (c, ...)		
		local instance = setmetatable({}, cls)		
		if cls.__init then cls.__init(instance, ...) end	
		return instance		
	end})		
end

local Math = Class()

function Math:Round(num)
	return num + (2^52 + 2^51) - (2^52 + 2^51)
end

function Math:Close(a,b, tol)
	return (a-b) <= tol
end


local Vec2Math = Class()

function Vec2Math:DistSqrt(a, b)
	local x, y = a.x-b.x, a.y-b.y
    return sqrt(x*x+y*y)
end

function Vec2Math:Extend(a,b, value) 
	local offset = value / self:DistSqrt(a,b)
	local dir = vec2:new((a.x - b.x), (a.y - b.y))
	local newPos = vec2:new((a.x + dir.x *offset), (a.y + dir.y*offset))
	return newPos
end


local Vec3Math = Class()

function Vec3Math:DistSqrt(a, b)
    local x, y, z = a.x-b.x, a.y-b.y, a.z-b.z
    return sqrt(x*x+y*y+z*z)
end

function Vec3Math:Len(a)
    return sqrt(a.x * a.x + a.y * a.y + a.z * a.z)
end

function Vec3Math:Len(a)
    return sqrt(a.x * a.x + a.y * a.y + a.z * a.z)
end

function Vec3Math:Norm(a)
    local len = self:Len(a)
    a.x = a.x / len
    a.y = a.y / len
    a.z = a.z / len
    return a
end

function Vec3Math:Extend(a,b, dist)
    local offset = dist / self:DistSqrt(a,b)
    local dir = vec3:new((a.x - b.x), b.y, (a.z - b.z))
	local newPos = vec3:new((a.x + dir.x *offset), b.y, (a.z + dir.z*offset))
    return newPos
end

function Vec3Math:Rotate(c , p, angle)
	local angle = angle * (pi/180) 
	local rotatedX = cos(angle) * (p.x - c.x) - sin(angle) * (p.z - c.z) + c.x
	local rotatedZ = sin(angle) * (p.x - c.x) + cos(angle) * (p.z - c.z) + c.z
	return vec3:new(rotatedX, p.y ,rotatedZ)
end


local Geometry = Class()

function Geometry:TriangleArea(p1, p2, p3)
    return (p1.x - p3.x) * (p2.z - p3.z) - (p2.x - p3.x) * (p1.z - p3.z)
end

function Geometry:PointInTriangle(pt, v1, v2 ,v3)
    local d1 = self:TriangleArea(pt, v1, v2);
    local d2 = self:TriangleArea(pt, v2, v3);
    local d3 = self:TriangleArea(pt, v3, v1);

    local hasNeg = (d1 < 0) or (d2 < 0) or (d3 < 0)
    local hasPos = (d1 > 0) or (d2 > 0) or (d3 > 0)

    return not hasNeg and hasPos
end

function Geometry:LineCircleIntersection(center, radius, segStart, segEnd) 

    local dx = segEnd.x - segStart.x
    local dz = segEnd.z - segStart.z

    local a = (dx * dx) + (dz * dz)
    local b = 2 * (dx * ( segStart.x - center.x) + dz * (segStart.z - center.z)  )
    local c = (segStart.x - center.x) * (segStart.x - center.x) + (segStart.z - center.z) * (segStart.z - center.z) - (radius * radius)
    local det = b * b - 4 * a * c
    
    local t = (-b + math.sqrt(det)) / (2 * a)
    local intersection1 = vec3:new(segStart.x + t * dx, center.y , segStart.z + t * dz);
    local t = (-b - math.sqrt(det)) / (2 * a)
    local intersection2 = vec3:new(segStart.x + t * dx, center.y , segStart.z + t * dz);
    return intersection1, intersection2
end

function Geometry:ProjectOnSegment(v1, v2, v)
    local cx, cy, ax, ay, bx, by = v.x, v.z, v1.x, v1.z, v2.x, v2.z
    local rL = ((cx - ax) * (bx - ax) + (cy - ay) * (by - ay)) / ((bx - ax) ^ 2 + (by - ay) ^ 2)
    local pointLine = vec3:new(ax + rL * (bx - ax), 0, ay + rL * (by - ay))
    local rS = rL < 0 and 0 or (rL > 1 and 1 or rL)
    local isOnSegment = rS == rL
    local pointSegment = isOnSegment and pointLine or vec3:new(ax + rS * (bx - ax), 0, ay + rS * (by - ay))
    
    return {PointSegment = pointSegment, PointLine = pointLine, IsOnSegment = isOnSegment}
end