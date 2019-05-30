
%%%% Anne Collins
%%%% Brown University
%%%% July 2015
%%%% anne_collins@brown.edu

%%%% Main Script for running tasks


% clear all variables
clear all
clc

%% check that all done well
% internet = input('Experimenter: is internet disconnected? (y/n) :\n','s');
% if strmatch(internet,'y')
% elseif strmatch(internet,'n')
%     disp('Please disconnect internet before re-starting the experiment');
%     return
% else
%     disp('Please answer y or n.');
%     return
% end
% 
% programs = input('Experimenter: are all other programs turned off? (y/n) :\n','s');
% if strmatch(programs,'y')
% elseif strmatch(programs,'n')
%     disp('Please turn off other programs before re-starting the experiment');
%     return
% else
%     disp('Please answer y or n.');
%     return
% end
% 
% external = input('Experimenter: are external devices (e.g. memory sticks) disconnected? (y/n) :\n','s');
% if strmatch(external,'y')
% elseif strmatch(external,'n')
%     disp('Please disconnect external devices before re-starting the experiment')
%     return
% else
%     disp('Please answer y or n.');
%     return
% end
% 
% outlet = input('Experimenter: is the laptop plugged into an outlet? (y/n) :\n','s');
% if strmatch(outlet,'y')
% elseif strmatch(outlet,'n')
%     disp('Please plug the laptop into an outlet before re-starting the experiment')
%     return
% else
%     disp('Please answer y or n.');
%     return
% end

%% set up Working Directory
%WorkingDirectory = 'C:\Users\Main\Documents\MATLAB';
%WorkingDirectory = 'C:\Users\RL\Documents\MATLAB';
WorkingDirectory = '/Users/Guillaume/Documents/GitHub/PD/effortTask';

cd(WorkingDirectory)

% get subject, day info
subject_id = input('Enter the subject ID # :\n');
session = input('Enter the day # :\n');
task = 2; %input('Enter the task number # (1-2):\n');

sessionnumbers = [1 22 57 92];
session = find(sessionnumbers==session);


%% implement safeguard
if task==1
    if exist(['GroupedExpeData/RLWMPST_ID',num2str(subject_id),'_Session',...
            num2str(session),'.mat'])
        ow = 1;
    else
        ow = 0;
    end
else
    if exist(['GroupedExpeData/Efforts_S',num2str(subject_id),'Sess_',...
            num2str(session),'.mat'])
        ow = 1;
    else
        ow = 0;
    end
end

if ow
    disp('!!! CAUTION !!! Data already exists for this subject number, day number, and task.')
    disp('Proceeding to the task may overwrite previous data.')
    disp('Are you sure the numbers were entered correctly?')
    overwrite = input('To proceed, enter (y); to abort, enter (n) :\n','s');


    if strmatch(overwrite,'y')
    elseif strmatch(overwrite,'n')
        disp('Please enter subject #, day #, and task number carefully!')
        return
    else
        disp('Please answer y or n.');
        return
    end

end

%% run expe

demo =1;
language = 2;
load language
if task>2 % include day 5.
    disp('Error. Incorrect task number (enter 1 or 2).')
elseif isempty(intersect(session,1:4)) 
    disp('Error. Incorrect session number (enter 1, 22, 57 or 92).')
elseif task==1 
    %cd RLWMPST_Short
    setDebugState(demo);
    Main_RLWMPST(subject_id,session);
    cd ..
    if language ==2
        clc
        disp('End of first half, Please call the experimenter!')
    else
        clc
        disp('Einde van de eerste helft, roep de proefleider alsjeblieft')
    end
else
    cd EffortTask
    setDebugState(demo);
    runEffort(subject_id,session);
    cd .. 
    if language ==2
        clc
        disp('End of the session. Thank you!')
    else
        clc
        disp('Einde van de sessie. Bedankt!')
    end
end

disp('Running Quality Control')
getStats(subject_id,session,task);
    