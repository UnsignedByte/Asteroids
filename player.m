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
        function p = addThrust(p)
            thrust = 0.5;
            p.velocity = p.velocity + [cosd(p.direction) sind(p.direction)]*thrust;
        end
        function p = turn(p, dir)
           turnrate = 4;
           p.direction = p.direction+dir*turnrate;
        end
        function p = move(p,r)
            decayrate = 0.05;
            p.position = mod(p.position + p.velocity, r(3:4));
            p.velocity = p.velocity*(1-decayrate);
        end
        function [pos, dir] = getP(p)
            pos = p.position;
            dir = p.direction;
        end
    end
end
