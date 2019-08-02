classdef player < handle
    properties
        x
        y
        
        dx
        dy
        maxdx
        maxdy
        accelx
        
        fall
        jump 
        
        j_onset
        j_time
        j_power
        j_dpower
        j_speed
        
        p_iconl
        p_iconr
        w
        h
        
        hp
        point
    end
    methods
        function P = player(name,A,M1,M2,JO,JP,JDP,JS,INIP)
            P.accelx = A;
            P.dx = 0;
            P.dy = 0;
            P.maxdx = M1;
            P.maxdy = M2;

            P.jump = 0;
            P.fall = 1;
            P.j_onset = JO;
            P.j_time = JO;
            P.j_power = JP;
            P.j_dpower = JDP;
            P.j_speed = JS;
            [P.p_iconl,~,p_alphal] = imread(name,'png');
            P.p_iconl(:,:,4) = p_alphal; 
            P.p_iconr(:,:,1) = fliplr(P.p_iconl(:,:,1));
            P.p_iconr(:,:,2) = fliplr(P.p_iconl(:,:,2));
            P.p_iconr(:,:,3) = fliplr(P.p_iconl(:,:,3));
            P.p_iconr(:,:,4) = fliplr(p_alphal);
            P.p_iconr = P.p_iconr;
            [P.h,P.w,~]=size(P.p_iconl);
            P.hp = 100;
            P.x = 100;
            P.y = 0;  
            P.point=INIP;
        end
        function posi_new = move(P,posi,gravity,ground_mat,world,ssize,KC,stomp,KConf)
            
            x_block = ceil((P.x+P.w/2)/40);
            if x_block <= 1; x_block = 1; end;
            if x_block > world(3)/40; x_block = world(3)/40; end;
            grounds = (find(ground_mat(:,x_block))-1)*40;
            if x_block > 1;  walls_b = ground_mat(:,x_block-1); else walls_b = ones(11,1); end;
            if x_block < world(3)/40; walls_f = ground_mat(:,x_block+1); else walls_f = ones(11,1); end;
            
            if stomp==1
                P.jump = 1;
                P.fall = 1;
                P.j_time = 0;
                P.j_power = 1.2;
                P.dx = P.dx/2;
            end
            
            if P.fall
                P.j_time = P.j_time + 1;
                if ((P.j_time<16) && any(find(KC)==KConf(2)) && P.jump); P.j_power = P.j_power + P.j_dpower; end; %change 10 to other numbers to change "fliability"
                if (P.j_time>0)
                    P.dy = gravity*P.j_time^2 + P.j_speed*P.j_power*P.jump;
                end 
                if (any(find(KC)==KConf(1))); P.dx=P.dx+P.accelx*0.3;
                elseif (any(find(KC)==KConf(3))); P.dx=P.dx-P.accelx*0.3;
                end;
            else
                if (find(KC)==KConf(1)); P.dx=P.dx+P.accelx;
                elseif (find(KC)==KConf(3)); P.dx=P.dx-P.accelx;
                else P.dx=P.dx/1.9;
                end; %change 1.3 to change kansei
                if (any(find(KC)==KConf(2))); P.jump=1; P.fall=1; end;
                if ~any(find(P.y+P.h==grounds)); P.fall=1; end;
            end
            %%%% Y axis movement %%%
            
            if (abs(P.dy)>P.maxdy); P.dy = P.dy/abs(P.dy)*P.maxdy; end;
            if P.fall==1
                for k=1:length(grounds)
                    if (P.y+P.h < grounds(k)) && (grounds(k) < P.y+P.dy+P.h)
                        P.y = grounds(k)-P.h;
                        P.fall = 0;
                        P.jump = 0;
                        P.dy = 0;
                        P.j_time = P.j_onset;
                        P.j_power = 1;
                    elseif (P.y > grounds(k)+40) && (grounds(k)+40 > P.y+P.dy)
                        P.y = grounds(k)+40;
                        P.jump = 0;
                        P.j_time = 4; %heading: 4 is very arbitrary number
                    end
                end
            end
            
            if P.fall==1
                P.y = P.y + P.dy;
            end
            
            if P.y > ssize(2)+100   %fall -> game over
                P.hp = 0;
            end 
            
            %%%% X axis movement %%%
            
            if (abs(P.dx)>P.maxdx); P.dx = P.dx/abs(P.dx)*P.maxdx; end;
            y_block_h = ceil((P.y+P.h*0.5)/40);
            y_block_b = ceil((P.y+P.h)/40);
            if y_block_h>11; y_block_h=11; end;
            if y_block_h<1; y_block_h=1; end;
            if y_block_b>11; y_block_b=11; end;
            if y_block_b<1; y_block_b=1; end;
            
            if (P.x < posi); P.x=posi; P.dx=0;
            elseif (P.x+P.w > world(3)); P.x=world(3)-P.w; P.dx=0;
            else
                if P.dx>0 && (walls_f(y_block_h)||walls_f(y_block_b))&& x_block*40<=P.x+P.w+P.dx
                    P.x = x_block*40-P.w;
                    if ~P.jump; P.dx = 0; end;
                elseif P.dx<0 && (walls_b(y_block_h)||walls_b(y_block_b)) && (x_block-1)*40>=P.x+P.dx
                    P.x = (x_block-1)*40;
                    if ~P.jump; P.dx = 0; end;
                else
                    P.x = P.x + P.dx;
                end
            end
                    
            
            if (P.x > posi+500); posi=P.x-500; 
            %elseif (P.x<posi+200); posi=P.x-200;
            end;
            
            if (posi>world(3)-ssize(1)); posi=world(3)-ssize(1);end;
            if (posi<world(1)); posi=world(1);end;
            
            posi_new = posi;
            
        end
    end
end
