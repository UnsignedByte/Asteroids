classdef meteor < handle
    properties
        pos
        spd
        sz
        img
        exist
    end
    methods
        function m = meteor(pos0,spd0,sz0,im)
            m.pos = pos0;
            m.spd = spd0;
            m.sz = sz0;
            m.img = imread([im '.jpg']);
            m.exist = 1;
        end
        function move1(m)
            m.pos = m.pos + m.spd;
            if (m.pos(1) > r(1) || m.pos(1) < 0 || m.pos(2) > r(2) || m.pos(1) < 0)
                m.exist = 0;
            end
        end
        function [m1,m2] = split(m)
            m.exist = 0;
            if (m.sz > 1)
                m1 = meteor(m.pos,[m.spd(1)*4/3, m.spd(2)*4/3],m.sz-1,im);
                m2 = meteor(m.pos,[m.spd(1)*2/3, m.spd(2)*2/3],m.sz-1,im);
            end
        end
    end
end

                
            
            
            
            
    
        