Screen('Preference', 'SkipSyncTests', 1);
rng('Shuffle');
KbName('UnifyKeyNames');
% init = ['user_' upper(input('Initials: ', 's'))];
[window, rect] = Screen('OpenWindow', 0, []);
HideCursor();
Screen('BlendFunction', window,GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
RestrictKeysForKbCheck([]);

while 1
    s = gameManager(window, rect);
end