%%  Effort Cost-Benefit Choice Task


%%%% Anne Collins
%%%% Brown University
%%%% May 2013
%%%% anne_collins@brown.edu

%%%% Instructions Code



function instructionsEffort(wPtr);
%    [w, rect] = Screen('OpenWindow', 0, 0,[],32,2);
%wPtr=w;
%Screen('TextSize',wPtr,30);

language = 2;% 1 for dutch
load language

textE{1} = 'Effort cost-benefit task';
textD{1} = 'Inspanning-kost voordeel taak';

textE{2} = ['In this experiment, you will be making a choice between inflating one of two balloons',...
    '\n\n by pressing corresponding keys on the keyboard.'];
textD{2} = ['In deze taak word je gevraagd om een keuze te maken tussen\n\n',...
    ' het opblazen van twee verschillende ballonnen door\n\n',...
    ' op verschillende toetsen op het toetsenbord te drukken.'];

textE{3} = 'Once the balloon pops you may win some money.';
textD{3} = 'Als de ballon knapt kan je wat punten winnen.';

textE{4} = ['For every 20 points that you win in the game,',...
    ' \n\n you will get one Dollar at the end of the experiment.'];
textD{4} = ['Voor iedere 20 punten die je wint in dit spel,',... 
    '\n\nkrijg je één Euro aan het einde van de taak.'];

textE{5} = ['There are two kinds of balloons: ',...
    '\n\n GREEN and BLUE balloons.'];
textD{5} = ['Er zijn twee verschillende soorten ballonnen:',...
    '\n\n GROENE en BLAUWE ballonnen'];

textE{6} = ['BLUE balloons will pop after you pump 20 times',...
    '\n\n and may win you 1 point\n\n\n\n\n\n',...
    'On the next screen, try popping the BLUE balloon:\n\n',...
    'To pump it, press the "1" key with you left index finger'];
textD{6} = ['Blauwe ballonnen knappen na 20 keer pompen',...
    '\n\nEn dan kan je 1 punt winnen.\n\n\n\n\n\n',...
    'Probeer op het volgende scherm de BLAUWE ballon te laten knappen:\n\n',...
    'Om de ballon op te pompen druk op de "1" toets met je linker wijsvinger'];

textE{7} = ['GREEN balloons may win you more points, but will require more pumps.',...
    '\n\n\n\n GREEN balloons will always pop when they become completely white,',...
    '\n\n after 25 seconds.'];
textD{7} = ['GROENE ballonnen leveren meer punten op, maar vereisen ook meer keren pompen',...
    '\n\n\n\n GROENE ballonnen knappen altijd als ze volledig wit gekleurd zijn,',...
    ' \n\nna 25 seconden'];

textE{8} = ['The more you pump the GREEN balloon before it turns white and pops',...
    '\n\n the bigger the balloon will be and you will win more points.'];
textD{8} = ['Hoe vaker je de GROENE ballon oppompt voor dat deze wit wordt,',...
    '\n\n hoe groter de ballon zal zijn en hoe meer punten je zal winnen!'];

textE{9} = ['When the GREEN balloon touches the prick,',...
    '\n\nyou have pumped enough to get all the points!',...
    '\n\n\n\n Note: \n\n You can get bonus points if you pump even more before the time limit!',...
    '\n\nAlso, if you pump less than is needed to hit the prick before the balloon pops,',...
    '\n\n you will still get some of the points.\n\n\n\n\n\n\n',...
    'On the next screen, try popping the GREEN balloon:\n\n',...
    'To pump it, press the "0" key with you right index finger'];
textD{9} = ['Als de GROENE ballon de naald raakt,',...
    '\n\ndan heb je genoeg gepompt om de punten te winnen!',...
    '\n\n\n\n Belangrijk: Je kan bonus punten winnen\n\n'...
    ,' als je de ballon nog meer oppompt voor dat de tijdslimiet op is.',...
    '\n\n\nEn, als je de ballon minder oppompt dan nodig is om de naald te raken voor dat de ballon knapt',...
    '\n\n krijg je wel een aantal van de punten.\n\n\n\n\n\n\n',...
    'Probeer op het volgende scherm de GROENE ballon te laten knappen:\n\n',...'
    'Om de ballon op te pompen druk op de "0" toets met je rechter wijsvinger'];

textE{10} = ['For the GREEN balloon, the number of pumps needed ',...
    '\n\nand the number of points you could win will always be shown on the screen.',...
    '\n\nThey can change on each round.',...
    '\n\n\n\n\nFor the blue balloon, the potential win will always stay the same (1 point),\n\n',...
    ' and it will always require 20 pumps.'];

textD{10} = ['Hoe vaak je de GROENE ballon moet oppompen ',...
    '\n\nEn hoeveel punten je zou kunnen winnen, zal altijd op het scherm staan.',...
    '\n\nDit kan veranderen voor iedere ronde.',...
    '\n\n\n\n\nVoor de blauwe ballon, de mogelijke hoeveelheid punten die je kan winnen',... 
    '\n\nzal altijd hetzelfde zijn (1 punt). En dit veresit altijd 20 keer pompen.'];

textE{11} = ['For some rounds, the chances that you will win points are 50% \n\n',...
    ' (even after popping the balloon, and for either balloon).'];
textD{11} = ['Voor sommige rondes is er 50% kans dat je punten wint',...
    '\n\n(zelfs als de ballon knapt, en voor beide ballonnen)'];

textE{12} = 'In other rounds the chances of winning will be 100% as long as you pop one of the balloons.';
textD{12} = 'In andere rondes is er 100% kans dat je punten wint zolang je een van de ballonnen laat knappen.';

textE{13} = 'The chances that you will win on that round, and also the potential amount to win, \n\n will be displayed on the screen.';
textD{13} = ['De kans dat je kan winnen voor iedere ronde, \n\n',...
    'en hoeveel punten je mogelijk kan winnen, zal getoond worden op het scherm.'];

textE{14} = '[Press any key to continue!]';
textD{14} = '[Druk op een willekeurige toest om door te gaan!]';

textE{15} = ['Press the    1    key to pump the balloon on the left',...
 '\n\n and the    0    key to pump the balloon on the right.',...
'\n\n\n\n\n\n Once you have chosen a balloon, you can only pump that balloon.'];

textD{15} = ['Druk op de 	1	 toets om de ballon aan de linkerkant op te pompen,',...
    '\n\nDruk op de 	0	 toest om de ballon aan de rechterkant op te pompen.',...
    '\n\n\n\n\n\n Als je eenmaal een ballon gekozen hebt om op te pompen,'...,
    '\n\n kan je alleen die ballon oppompen.'];
textE{16} = 'Press R to read the instructions again';
textD{16} = 'Druk op R om deze instructies nogmaals te lezen';



if language == 1
    text = textD;
else
    text = textE;
end


Screen('TextFont',wPtr,'Times');
Screen('TextSize', wPtr, 26 );
Screen('TextStyle',wPtr,0);
Screen('TextColor',wPtr,[255 255 255]);

DrawFormattedText(wPtr,text{1},'center','center');
Screen(wPtr, 'Flip');
WaitSecs(3);

% %****BEGINNING OF INSTRUCTIONS****


done = 1;

while done
instructionText1 = [text{2},'\n\n\n\n',text{3},'\n\n\n\n',text{4},'\n\n\n\n\n',text{14}];
DrawFormattedText(wPtr,instructionText1,'center','center');
Screen(wPtr, 'Flip');
KbWait([],3); %Waits for keyboard(any) press
WaitSecs(.02);

instructionText2 = [text{5},'\n\n\n\n',text{6},'\n\n\n\n\n',text{14}];
DrawFormattedText(wPtr,instructionText2,'center','center');
Screen(wPtr, 'Flip');
KbWait([],3); %Waits for keyboard(any) press
WaitSecs(.02);

%% run one blue trial
 position = 1;% 1/0 : 1 dollar left/right
    hasard = 0;% 1/0/-1 : 50%, get it; or 100%; or 50% don't get it
    value = 0;% value of 
    effort = 200;% value of 
    Total = 0;
    choices = 1;
    
    [chosen,GainvsCost,reward,Total,nPress,RT,latence] = runOneTrial(position,hasard,...
        value,effort,Total,choices);
    WaitSecs(max(0,1.5-latence));
Screen('TextColor',wPtr,[255 255 255]);
Screen(wPtr, 'Flip');
WaitSecs(.2);
%%


Screen('TextColor',wPtr,[255 255 255]);
instructionText3 = [text{7},'\n\n\n\n',text{8},'\n\n\n\n\n',text{14}];
DrawFormattedText(wPtr,instructionText3,'center','center');
Screen(wPtr, 'Flip');
KbWait([],3); %Waits for keyboard(any) press
WaitSecs(.02);



instructionText3 = [text{9},'\n\n\n\n\n',text{14}];
DrawFormattedText(wPtr,instructionText3,'center','center');
Screen(wPtr, 'Flip');
KbWait([],3); %Waits for keyboard(any) press
WaitSecs(.02);

%% run one green trial
 position = 1;% 1/0 : 1 dollar left/right
    hasard = 0;% 1/0/-1 : 50%, get it; or 100%; or 50% don't get it
    value = 2;% value of 
    effort = 50;% value of 
    Total = 0;
    choices = 2;
    
    [chosen,GainvsCost,reward,Total,nPress,RT,latence] = runOneTrial(position,hasard,...
        value,effort,Total,choices);
    WaitSecs(max(0,1.5-latence));
Screen('TextColor',wPtr,[255 255 255]);
Screen(wPtr, 'Flip');
WaitSecs(.2);
%%

instructionText3 = [text{10},'\n\n\n\n\n',text{14}];
DrawFormattedText(wPtr,instructionText3,'center','center');
Screen(wPtr, 'Flip');
KbWait([],3); %Waits for keyboard(any) press
WaitSecs(.02);

instructionText4 = [text{11},'\n\n\n\n',text{12},'\n\n\n\n',text{13},'\n\n\n\n\n',text{14}];
DrawFormattedText(wPtr,instructionText4,'center','center');
Screen(wPtr, 'Flip');
KbWait([],3); %Waits for keyboard(any) press
WaitSecs(.02);


instructionText3 = [text{15},'\n\n\n\n\n\n\n\n\n',text{14}];
DrawFormattedText(wPtr,instructionText3,'center','center');
Screen(wPtr, 'Flip');
KbWait([],3); %Waits for keyboard(any) press
WaitSecs(.02);

% Propose to repeat instructions
instructionText1 = [text{16},'\n\n\n\n\n\n\n\n\n',text{14}];
DrawFormattedText(wPtr,instructionText1,'center','center');
Screen(wPtr, 'Flip');

[keyIsDown, RT, keyCode] = KbCheck();
repeat = 0;
while repeat==0
    if keyIsDown 
        if keyCode(KbName('R'))
            repeat = 1;
        else
            repeat = -1;
        end
    end % if next key detected
    [keyIsDown, RT, keyCode] = KbCheck();
end % endless loop

if repeat == -1
    done = 0;
end
end

%Screen('CloseAll')