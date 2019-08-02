function st = gameManager(w, world)
    ListenChar(2);
    disp(world);
    bg = imresize(imread(fullfile('images', 'bg.png')), world([4 3]));
    bg_t = Screen('MakeTexture', w, bg);
    pi = imread(fullfile('images', 'player.png'));
    p_t = Screen('MakeTexture', w, pi);
    
    P = player(world(3:4)/2);
    meteors = {};
    
    while 1
        [~, ~, keys] = KbCheck();
        disp(keys(KbName('a')));
        dir = 0;
        if keys(KbName('a'))
            dir = dir + 1;
        end
        if keys(KbName('d'))
            dir = dir - 1;
        end
        P = P.turn(dir);
        if keys(KbName('w'))
            P = P.addThrust;
        end
        P = P.move(world);
        
        drawFrame();
    end
keys
    function drawFrame()
        [p,d] = P.getP();
        disp(p);
        Screen('DrawTexture', w, bg_t);
        PsychDrawSprites2D(w, p_t, p, 1, d);
        Screen('Flip', w);
    end
end


