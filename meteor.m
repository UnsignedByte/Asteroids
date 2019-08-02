classdef meteor
    properties
        pos
        spd
        sz
        img
        exist
    end
    methods
        function m = meteor(pos0,spd0,sz0,im)
            pos = pos0;
            spd = spd0;
            sz = sz0;
            img = imread([im '.jpg']);
            exist = 1;
        end
        function move1(m)
            m.pos = mod(m.pos + m.spd, r);
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

                
            
            
            
            
    
        