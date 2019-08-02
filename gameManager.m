function [poss, texts, st] = gameManager(w, world)
    ListenChar(2);
    disp(world);
    bg = imresize(imread(fullfile('images', 'bg.jpg'), [ww wh]);
    bg_t = Screen('MakeTexture', w, bg);
    pi = imread(fullfile('images', 'player.png'));
    p_t = Screen('MakeTexture', w, pi);
    
    P = player(world(3:4)/2);
    meteors = {};
    
    while 1
        [~, ~, keys] = KbCheck();
        dir = 0;
        if keys(KbName('a'))
            dir = dir + 1;
        end
        if keys(KbName('d'))
            dir = dir - 1;
        end
        P.turn();
        if keys(KbName('w'))
            P.addThrust();
        end
        
        drawFrame();
    end

    function drawFrame()
        [p,d] = P.getP();
        Screen('DrawTexture', w, bg_t);
        PsychDrawSprites2D(windowPtr, p_t, p, 1, d);
    end
end

