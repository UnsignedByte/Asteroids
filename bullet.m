classdef bullet < handle
    properties
        pos
        spd
        exist
        dir
    end
    methods
        function b = bullet(p0,playerspeed,d0)
            b.pos = p0;
            b.spd = playerspeed+3.*[cosd(d0) sind(d0)];
            b.dir = d0;
            b.exist = 1;
        end
        function move1(b)
            b.pos = b.pos+b.spd;
            if (b.pos(1) > r(1) || b.pos(1) < 0 || b.pos(2) > r(2) || b.pos(1) < 0)
                b.exist = 0;
            end
        end
        function hit(b,M)
            