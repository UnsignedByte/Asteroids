classdef player
    properties
        velocity
        direction
        position
    end
    methods
        function p = player(pos)
            p.velocity = [0,0];
            p.position = pos;
            p.direction = 0;
        end
        function addThrust(p)
            p.velocity = p.velocity + [cosd(p.direction) sind(p.direction)];
        end
        function turn(p, dir)
           turnrate = 1;
           p.direction = p.direction+dir*turnrate;
        end
        function move(p)
            decayrate = 0.1;
            p.velocity = p.velocity*(1-decayrate);
            p.position = p.position + p.velocity;
        end
        function [pos, dir] = getP(p)
            pos = p.position;
            dir = p.direction;
        end
    end
end
