%%  Effort Cost-Benefit Choice Task


%%%% Anne Collins
%%%% Brown University
%%%% May 2013
%%%% anne_collins@brown.edu

%%%% Main code - DEMO




function DEMO_Effort(sujet,session)
%clear all
debug = 1;
language = 1;%1 for dutch

% change that to new computer
keynumbers = [KbName('1!') KbName('0)')];



% change that to correct text
TextE{1}{1} = ' point';
TextD{1}{1} = ' punt';
TextE{1}{2} = ' points';
TextD{1}{2} = ' punten';
TextE{2} = ' times pump';
TextD{2} = ' keer pompen';
TextE{3} = 'On this trial you have a 50% chance of receiving your reward';
TextD{3} = 'In deze test heeft u 50% kans op het ontvangen van uw beloning.';
TextE{4} = 'On this trial you have a 100% chance of receiving your reward';
TextD{4} = 'In deze test heeft u 100% kans op het ontvangen van uw beloning.';
TextE{5} = 'You win ';
TextD{5} = 'U wint ';
TextE{6} = 'Total gains: ';
TextD{6} = 'Totaal aantal punten: ';
TextE{7} = 'Thank you for completing the experiment!!';
TextD{7} = 'Dank u voor het voltooien van het experiment!!!';

if language == 1
    Text = TextD;
else
    Text = TextE;
end


grey = 254/2;
red = [255 0 0];
green = [0 255 0];
blue =[0 0 255];% 
white = [255 255 255];





Taille = 1;
% pseudo-randomize trials
for i = 1
TrialSeq = [0 0 3;
          0 0 4;
          0 0 5;
          0 0 6;
          0 0 7;
          0 1 3;
          0 1 4;
          0 1 5;
          0 1 6;
          0 1 7;
          1 0 3;
          1 0 4;
          1 0 5;
          1 0 6;
          1 0 7;
          1 1 3;
          1 1 4;
          1 1 5;
          1 1 6;
          1 1 7;
          0 0 3;
          0 0 4;
          0 0 5;
          0 0 6;
          0 0 7;
          0 1 3;
          0 1 4;
          0 1 5;
          0 1 6;
          0 1 7;
          -1 0 3;
          -1 0 4;
          -1 0 5;
          -1 0 6;
          -1 0 7;
          -1 1 3;
          -1 1 4;
          -1 1 5;
          -1 1 6;
          -1 1 7;
          0 0 3;
          0 0 5;
          0 0 7;
          0 1 4;
          0 1 6;
          1 0 3;
          1 0 5;
          1 0 7;
          1 1 4;
          1 1 6;
          0 0 4;
          0 0 6;
          0 1 3;
          0 1 5;
          0 1 7;
          -1 0 4;
          -1 0 6;
          -1 1 3;
          -1 1 5;
          -1 1 7];
end
Taille = size(TrialSeq,1);
TrialSeq = TrialSeq(randperm(Taille),:);

%%




% begin
Screen('Preference', 'SkipSyncTests',0);
[w, rect] = Screen('OpenWindow', 0, 0,[],32,2);
Screen('Flip', w);
HideCursor();
    %ListenChar(2);


try
% Write instructions code
instructionsEffort(w);

% To draw 
Ecran = [0 0;0 rect(4);rect(3) rect(4);rect(3) 0];
Game = [0 .05*rect(4);0 .75*rect(4);rect(3) .75*rect(4); rect(3) .05*rect(4)];
Height = .7*rect(4);
x(1) = .25*rect(3);
x(2) = .75*rect(3);
l5 = rect(4)/180;%5;
Mouths(1,:) = [x(1)-l5 .75*rect(4)-22 x(1)+l5 .75*rect(4)];
Mouths(2,:) = [x(2)-l5 .75*rect(4)-22 x(2)+l5 .75*rect(4)];
Picks(:,:,1)= [x(1)-l5 .05*rect(4);x(1)+l5 .05*rect(4);x(1) .05*rect(4)+8*l5];
Picks(:,:,2) = [x(2)-l5 .05*rect(4);x(2)+l5 .05*rect(4);x(2) .05*rect(4)+8*l5];

MaxR = (Height-12*l5)/2;
MinR = 5*l5;
% if debug
Ns0 = [20 100];
% else
%    Ns0 = [20 100];
% end

% start trials
 
Total = 0;
Screen(w,'FillPoly',0, Ecran);%%Ecrean total noir
Screen(w,'FillPoly',grey, Game);%%Ecrean total noir
Screen('Flip', w);
WaitSecs(2);
Screen('TextFont', w , 'Arial');
Screen('TextSize', w, 28 );


pop = wavread('pop.wav');pop = [pop';pop'];
%blow = wavread('up1.wav');blow = [blow';blow'];

%Snd('Open')

if debug 
    trialsmax = 5;
else
    trialsmax = Taille;
end

for trials = 1:trialsmax%Taille

    % characteristics of each trial
    position = TrialSeq(trials,2);% 1/0 : 1 dollar left/right
    hasard = TrialSeq(trials,1);% 1/0/-1 : 50%, get it; or 100%; or 50% don't get it
    value = TrialSeq(trials,3);% value of 
    
    Rs = [MinR MinR];
    Balloons(1,:) = CenterRectOnPoint([0 0 1.5*Rs(1) 2*Rs(1)],x(1),.75*rect(4)-4*l5-Rs(1));
    Balloons(2,:) = CenterRectOnPoint([0 0 1.5*Rs(2) 2*Rs(2)],x(2),.75*rect(4)-4*l5-Rs(2));


    
    if position ==1
        order = [1 2];
        cost = Ns0(order);
        gain = [1 value];
        
    else
        order = [2 1];
        cost = Ns0(order);
        gain = [value 1];
    end
    Ns = cost;
    steps = (MaxR-MinR)./Ns;
    


    % presentation
    
    Screen(w,'FillPoly',0, Ecran);%%Ecrean total noir
    Screen(w,'FillPoly',grey, Game);%%Ecrean total noir
    for choice = 1:2
    Screen(w,'Fillrect', blue, Mouths(order(choice),:));
    Screen(w,'FillOval', blue,Balloons(order(choice),:));
    Screen(w,'FillPoly', white,Picks(:,:,order(choice)));
    Screen(w,'FramePoly', 0,Picks(:,:,order(choice)));
    Screen(w,'DrawText',[num2str(gain(order(choice))), Text{1}{1+(gain(order(choice))>1)}],x(order(choice))-80,.75*rect(4),255);
    Screen(w,'DrawText',[num2str(cost(order(choice))), Text{2}],x(order(choice))-16*l5,.8*rect(4),255);
    end
    if hasard ~= 0
    Screen(w,'DrawText',Text{3},.15*rect(3),.9*rect(4),red);
    else
    Screen(w,'DrawText',Text{4},.15*rect(3),.9*rect(4),255);
    end
    Screen(w,'DrawText',[Text{6}, num2str(Total),Text{1}{1+(Total>1)}],.35*rect(3),.005*rect(4),green);
    Screen('Flip', w);

    
    % press
    
    nPress = 0;
    test = 0;
    tstart=GetSecs;
    prestime = 5;
    GainvsCost = -1;
    chosen = -1;
    RT = [];
    couleur{1} = blue;
    couleur{2} = blue;
    while test == 0 & GetSecs-tstart<prestime
        kdown=0;
        while kdown==0 & GetSecs-tstart<prestime;
            [kdown secs code]=KbCheck;
        end
        if kdown == 0
            nPress = 0;
            skip = -1;
        else
        nPress = nPress + 1;
        keycode=find(code==1);
        keycode = keycode(1);
        end
        if nPress == 1
            if intersect(keynumbers,keycode)
                chosen = find(keynumbers == keycode);
                RT(nPress) = secs - tstart;
                skip = 0;
                prestime = 40;
            %Snd('Play',blow)
            else 
                skip = -1;
            end
        elseif nPress>1
            pressed = find(keynumbers == keycode);
            if pressed == chosen
                RT(nPress) = secs - tstart;
                skip = 0;
            else
                skip = -1;
            end
            %Snd('Play',blow)
        end
        RTF = secs - tstart;
        if skip == -1
            nPress = nPress - 1;
        else
            
        Rs(chosen) = MinR + nPress*steps(chosen);

        Balloons(1,:) = CenterRectOnPoint([0 0 1.5*Rs(1) 2*Rs(1)],x(1),.75*rect(4)-4*l5-Rs(1));
        Balloons(2,:) = CenterRectOnPoint([0 0 1.5*Rs(2) 2*Rs(2)],x(2),.75*rect(4)-4*l5-Rs(2));


        couleur{3-chosen} = blue;
        couleur{chosen} = green+(white-green)*nPress/Ns(chosen);
        Screen(w,'FillPoly',0, Ecran);%%Ecrean total noir
        Screen(w,'FillPoly',grey, Game);%%Ecrean total noir
        for choice = 1:2
        Screen(w,'Fillrect', couleur{choice}, Mouths(choice,:))
        Screen(w,'FillOval', couleur{choice},Balloons(choice,:));
        Screen(w,'FillPoly', white,Picks(:,:,choice));
        Screen(w,'FramePoly', 0,Picks(:,:,choice));
        Screen(w,'DrawText',[num2str(gain(choice)), Text{1}{1+(gain(choice)>1)}],x(choice)-16*l5,.75*rect(4),255);
        Screen(w,'DrawText',[num2str(cost(choice)), Text{2}],x(choice)-16*l5,.8*rect(4),255);
        end
        if hasard ~= 0
        Screen(w,'DrawText',Text{3},.15*rect(3),.9*rect(4),red);
        else 
        Screen(w,'DrawText',Text{4},.15*rect(3),.9*rect(4),255);
        end
        Screen(w,'DrawText',[Text{6}, num2str(Total),Text{1}{1+(Total>1)}],.35*rect(3),.005*rect(4),green);
        Screen('Flip', w);


        if nPress == Ns(chosen)
            test = 1;
        end
        while kdown==1
            kdown = KbCheck;
        end
        couleur{chosen} = green;
        end
    end
    if test>0
    Snd('Play',pop);
    end
    % feedback
    if hasard==-1
        reward = 0;
    elseif test == 0
        reward = 0;
    else
        reward = gain(chosen);
    end
    Total = Total + reward;


    Screen(w,'FillPoly',0, Ecran);%%Ecrean total noir
    Screen(w,'FillPoly',grey, Game);%%Ecrean total noir
    for choice = 1:2
    Screen(w,'Fillrect', couleur{choice}, Mouths(choice,:))
    Screen(w,'FillPoly', white,Picks(:,:,choice));
    Screen(w,'FramePoly', 0,Picks(:,:,choice));
    Screen(w,'DrawText',[num2str(gain(choice)), Text{1}{1+(gain(choice)>1)}],x(choice)-16*l5,.75*rect(4),255);
    Screen(w,'DrawText',[num2str(cost(choice)), Text{2}],x(choice)-16*l5,.8*rect(4),255);
    end
    if hasard ~= 0
    Screen(w,'DrawText',Text{3},.15*rect(3),.9*rect(4),red);
    else
    Screen(w,'DrawText',Text{4},.15*rect(3),.9*rect(4),255);
    end
    Screen(w,'DrawText',[Text{6}, num2str(Total),Text{1}{1+(Total>1)}],.35*rect(3),.005*rect(4),green);
    if test>0
    Screen(w,'FillOval', couleur{3-chosen},Balloons(3-chosen,:));
    Screen(w,'DrawText',[Text{5},num2str(reward), Text{1}{1+(reward>1)}],x(chosen)-20*l5,.4*rect(4),green);
    end
    Screen('Flip', w);
    tic;Snd('Close');latence=toc;
    
    
    if test >0
    GainvsCost = gain(chosen)>1;
    else
        RT = [RT -1];
    end
    
    data(trials,:) = [hasard position value chosen GainvsCost reward Total RT(1) RT(end)];
    RTseqs{trials} = RT;
    %save(['dataEffort/Efforts_S',num2str(sujet),'Sess_',num2str(session)],'data','RTseqs')
    WaitSecs(1.5-latence);
    
    Screen(w,'FillPoly',0, Ecran);%%Ecrean total noir
    Screen(w,'FillPoly',grey, Game);%%Ecrean total noir
    Screen(w,'DrawText',[Text{6}, num2str(Total),Text{1}{1+(Total>1)}],.35*rect(3),.005*rect(4),green);
    Screen('Flip', w);
    WaitSecs(1.5);

    
end
Snd('Close')

Screen(w,'FillPoly',0, Ecran);%%Ecrean total noir
Screen(w,'DrawText',[Text{7}],.3*rect(3),.4*rect(4),255);
Screen(w,'DrawText',[Text{6}, num2str(Total),Text{1}{1+(Total>1)}],.35*rect(3),.5*rect(4),255);
Screen('Flip', w);
WaitSecs(5);
Screen('CloseAll');
    %ListenChar(0);
    ShowCursor

catch
    ShowCursor;
    %ListenChar(0);
    Screen('CloseAll');
    Snd('Close')
    rethrow(lasterror);

end


end