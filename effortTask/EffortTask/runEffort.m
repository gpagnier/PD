%%  Effort Cost-Benefit Choice Task


%%%% Anne Collins
%%%% Brown University
%%%% May 2013
%%%% anne_collins@brown.edu

%%%% Main code


function runEffort(sujet,session)
%clear all
debug = 0;
load debugState;
language = 2;%1 for dutch
load language

%directory = 'C:\Users\Main\Documents\MATLAB\GroupedExpeData';
directory = 'C:\Users\RL\Documents\MATLAB\GroupedExpeData';
directory = '.';% /Users/frankmj/Downloads/a/PDE10_LaptopCode_June13/EffortTask';


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

columns = {'hasard','position', 'value', 'effort', 'chosen', 'GainvsCost',...
    'reward', 'Total', 'nPress', 'RT(1)', 'RT(end)'};

grey = 254/2;
red = [255 0 0];
green = [0 255 0];
blue =[0 0 255];% 
white = [255 255 255];

bcol = [blue;green];% color of easy, difficult balloons

%% params

MaxTime = 25;
MaxPress = 200;

%% define sequence of trials
RandomizeTrials;
% TrialSeq:
% 1st columns: probability?
% 2nd column: position
% 3rd column: value
% 4th column: effort
% Taille is size(TrialSeq,1)

%%




% begin
Screen('Preference', 'SkipSyncTests',0);
if debug 
screenRect = [];%[0,0,1000,600]; % screen for debugging
else
screenRect = []; % full screen
end
[w, rect] = Screen('OpenWindow', 0, 0,screenRect,32,2);
Screen('Flip', w);
HideCursor();
%ListenChar(2);

    
try


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

pop = wavread('pop.wav');pop = [pop';pop'];
textTrial = Text;

save GraphicInfo w rect Ecran Game Height x l5 Mouths Picks MinR MaxR pop textTrial keynumbers


% Write instructions code
instructionsEffort(w);

if debug
Ns0 = [2 10];
else
    Ns0 = [20 100];
end

% start trials
 
Total = 0;
Screen(w,'FillPoly',0, Ecran);%%Ecrean total noir
Screen(w,'FillPoly',grey, Game);%%Ecrean total noir
Screen('Flip', w);
WaitSecs(2);
Screen('TextFont', w , 'Arial');
Screen('TextSize', w, 28 );


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
    effort = TrialSeq(trials,4);% value of 
    choices = 1:2;% both choices available
    
    [chosen,GainvsCost,reward,Total,nPress,RT,latence] = runOneTrial(position,hasard,...
        value,effort,Total,choices);
    
    data(trials,:) = [hasard position value effort chosen GainvsCost reward Total nPress RT(1) RT(end)];
    RTseqs{trials} = RT;
    
    % save data
    tic
    save([directory,'/Efforts_S',num2str(sujet),'Sess_',num2str(session)],'data','RTseqs','TrialSeq','columns')
    latence2 =toc;
    % 
    WaitSecs(max(0,1.5-latence-latence2));
    
    Screen(w,'FillPoly',0, Ecran);%%Ecrean total noir
    Screen(w,'FillPoly',grey, Game);%%Ecrean total noir
    Screen(w,'DrawText',[Text{6}, num2str(Total),Text{1}{1+(Total>1)}],.35*rect(3),.005*rect(4),green);
    Screen('Flip', w);
    WaitSecs(1.5);
%    boum
    
end
Snd('Close')

Screen(w,'FillPoly',0, Ecran);%%Ecrean total noir
Screen(w,'DrawText',[Text{7}],.3*rect(3),.4*rect(4),255);
Screen(w,'DrawText',[Text{6}, num2str(Total),Text{1}{1+(Total>1)}],.35*rect(3),.5*rect(4),255);
Screen('Flip', w);
WaitSecs(5)
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