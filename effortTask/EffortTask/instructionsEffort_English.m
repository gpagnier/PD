%%  Effort Cost-Benefit Choice Task


%%%% Anne Collins
%%%% Brown University
%%%% May 2013
%%%% anne_collins@brown.edu

%%%% Instructions Code



function instructionsEffort_English(wPtr);
%    [w, rect] = Screen('OpenWindow', 0, 0,[],32,2);
%wPtr=w;
%Screen('TextSize',wPtr,30);

language = 2;% 1 for dutch

textE{1} = 'Effort cost-benefit task';
textD{1} = 'Inspanning kosten-batentaak';
textE{2} = 'In this experiment, you will be making a choice between inflating one of two balloons\n\n by pressing corresponding keys on the keyboard.';
textD{2} = 'In dit experiment moet u kiezen tussen het opblazen van een van twee ballonnen \n\n door op de overeenkomstige toetsen op het toetsenbord te drukken.';
textE{3} = 'Once the balloon pops you may win some money.';
textD{3} = 'Als de ballon knalt, maakt u kans om wat geld te winnen.';
textE{4} = 'For every 10 points that you win in the game, \n\n you will get one Euro at the end of the experiment.';
textD{4} = 'Voor iedere 10 punten die u tijdens het spel wint,\n\n ontvangt u een euro aan het einde van het experiment.';
textE{5} = 'Popping one of the balloons will require more effort: \n\n you will have to pump the balloon 100 times, \n\n whereas the other balloon requires just 20 pumps.';
textD{5} = 'Het laten knallen van 1 van de 2 ballonnen vergt meer inspanning: \n\n u moet deze ballon wel 100 keer pompen, \n\n terwijl de andere ballon al knalt na slechts 20 keer pompen.';
textE{6} = 'But, the first balloon could potentially win you more money.';
textD{6} = 'Maar met de eerste ballon wint u misschien wel meer geld.';
textE{7} = 'Each time you will see the potential amount of money you could win for the high effort balloon,\n\n which will vary from one round to the next (from 3 to 7 points).';
textD{7} = 'U ziet iedere keer het mogelijke geldbedrag \n\n dat u kunt winnen voor de ballon waar u veel inspanning voor moet leveren, \n\n wat per ronde kan verschillen (van 3 tot 7 punten).';
textE{8} = 'The potential gain from the low effort balloon will stay the same (1 point).';
textD{8} = 'De mogelijke winst van de ballon waar u minder inspanning voor hoeft te leveren, \n\n zal hetzelfde blijven (1 punt).';
textE{9} = 'For some rounds, the chances that you will win points are 50% \n\n (even after popping the balloon, and for either balloon).';
textD{9} = 'Voor sommige rondes is de kans dat u punten wint 50% \n\n (zelfs na het laten knallen van de ballon en voor elke ballon).';
textE{10} = 'In other rounds the chances of winning will be 100% as long as you pop one of the balloons.';
textD{10} = 'In andere rondes is de kans om te winnen 100% zolang u maar een van de ballons laat knallen.';
textE{11} = 'The chances that you will win on that round, and also the potential amount to win, \n\n will be displayed on the screen.';
textD{11} = 'De kans dat u wint in die ronde en ook het mogelijke bedrag dat u kunt winnen, \n\n zullen op het scherm getoond worden.';
textE{12} = '[Press any key to continue!]';
textD{12} = '[Druk op een willekeurige toets om door te gaan!]';
textE{13} = 'Press the    1    key to pump the balloon on the left \n\n and the    0    key to pump the balloon on the right.';
textD{13} = 'Druk op de toets    1    om de ballon pompen aan de linkerkant te kiezen \n\n en de toets    0    om het ballon aan de rechterkant.';
textE{14} = 'Press R to read the instructions again';
textD{14} = 'Druk R om de instructies nogmaals te lezen';

if language == 1
    text = textD;
else
    text = textE;
end


Screen('TextFont',wPtr,'Times');
Screen('TextSize', wPtr, 28 );
Screen('TextStyle',wPtr,0);
Screen('TextColor',wPtr,[255 255 255]);

DrawFormattedText(wPtr,text{1},'center','center');
Screen(wPtr, 'Flip');
WaitSecs(3);

% %****BEGINNING OF INSTRUCTIONS****


done = 1;

while done
instructionText1 = [text{2},'\n\n\n\n',text{3},'\n\n\n\n',text{4},'\n\n\n\n\n',text{12}];
DrawFormattedText(wPtr,instructionText1,'center','center');
Screen(wPtr, 'Flip');
KbWait([],3); %Waits for keyboard(any) press
WaitSecs(.02);

instructionText2 = [text{5},'\n\n\n\n',text{6},'\n\n\n\n\n',text{12}];
DrawFormattedText(wPtr,instructionText2,'center','center');
Screen(wPtr, 'Flip');
KbWait([],3); %Waits for keyboard(any) press
WaitSecs(.02);


instructionText3 = [text{7},'\n\n\n\n',text{8},'\n\n\n\n\n',text{12}];
DrawFormattedText(wPtr,instructionText3,'center','center');
Screen(wPtr, 'Flip');
KbWait([],3); %Waits for keyboard(any) press
WaitSecs(.02);


instructionText4 = [text{9},'\n\n\n\n',text{10},'\n\n\n\n',text{11},'\n\n\n\n\n',text{12}];
DrawFormattedText(wPtr,instructionText4,'center','center');
Screen(wPtr, 'Flip');
KbWait([],3); %Waits for keyboard(any) press
WaitSecs(.02);


instructionText3 = [text{13},'\n\n\n\n\n\n\n\n\n',text{12}];
DrawFormattedText(wPtr,instructionText3,'center','center');
Screen(wPtr, 'Flip');
KbWait([],3); %Waits for keyboard(any) press
WaitSecs(.02);

% Propose to repeat instructions
instructionText1 = [text{14},'\n\n\n\n\n\n\n\n\n',text{12}];
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