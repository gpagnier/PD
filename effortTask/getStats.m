
%%%% Anne Collins
%%%% Brown University
%%%% December 2015
%%%% anne_collins@brown.edu

function getStats(si,sess,task)
% generates main results analysis for each subject - saves

bs_log = [];
prop_no_answers_Effort = [];
bias = [nan nan];
bonus = [nan];

if task==2
try
%analyze Effort
[prop_no_answers_Effort,bs_log,bias,bonus]=  analyzeEffort(si,sess);
fl{1} = 0;
catch
     disp('error in Effort analysis')
fl{1} = 1;
end
end
st_b = nan(1,4);
perf = nan;
prop_no_answers_RLWM=[];
try
%analyze RLWMPST-learning
[st_b,perf,prop_no_answers_RLWM]=  analyzeRLWM(si,sess);
fl{2} = 0;
catch
    disp('error in RLWM analysis');
fl{2} = 1;
end
%analyze RLWMPST-test
bsRLWM = nan(1,4);
prop_no_answers_PST=nan;
try
[bsRLWM,prop_no_answers_PST] = analyseValue(si,sess);
fl{3} = 0;
catch
     disp('error in RLWMPSTanalysis');
fl{3} = 1;
end

RLWM.performance = perf;
RLWM.prop_no_answers = prop_no_answers_RLWM;
% RLWM.logistic = st_b;
% RLWM.logistic_keys = {'fixed','set-size','delay','iterations'};

RLWMPST.logistic = bsRLWM;
RLWMPST.prop_no_answers = prop_no_answers_PST;
%RLWMPST.logistic_keys = {'value','set-size','LR bias','alternate'};

%Effort.logistic = bs_log;
Effort.prop_no_answers = prop_no_answers_Effort;
Effort.bias = bias;
Effort.bonus = bonus;
Effort.logistic_keys = {'fixed', 'Certainty', 'left/right', 'value', 'effort', 'time'};

timestamp = clock;
save(['SummaryStats\S',num2str(si),'_Sess',num2str(sess)],'RLWM','RLWMPST','Effort','timestamp')
%save(['SummaryStats/S',num2str(si),'_Sess',num2str(sess)],'RLWM','RLWMPST','Effort','timestamp')

%% implement the file saving QC data.

printQC(Effort,RLWM,RLWMPST,fl, si,sess);


dossier = 'GroupedExpeData\';
%dossier = 'GroupedExpeData/';
if exist([dossier,'RLWMPST_ID',num2str(si),'_Session',num2str(sess),'.mat'])
    load([dossier,'RLWMPST_ID',num2str(si),'_Session',num2str(sess),'.mat']);
end
if exist([dossier,'Efforts_S',num2str(si),'Sess_',num2str(sess),'.mat'])
%if exist(['GroupedExpeData/Efforts_S',num2str(si),'Sess_',num2str(sess),'.mat'])
    load([dossier,'Efforts_S',num2str(si),'Sess_',num2str(sess)])
    %load(['GroupedExpeData/Efforts_S',num2str(si),'Sess_',num2str(sess)])
end
if exist([dossier,'RLWMTraining_Su',num2str(si),'_Session',num2str(sess),'.mat'])
    load([dossier,'RLWMTraining_Su',num2str(si),'_Session',num2str(sess),'.mat']);
end
save(['SummaryStats\AllDataS',num2str(si),'_Sess',num2str(sess)])
%save(['SummaryStats/AllDataS',num2str(si),'_Sess',num2str(sess)])


end

%% Get the QC
function printQC(Effort,RLWM,RLWMPST, fl,si,sess)

threshold_noA = .2;
threshold_EffortBias = .35;
threshold_PSTBias = .25;


if exist(['SummaryStats\QC_ID',num2str(si),'_Sess',num2str(sess),'.txt']);
%if exist(['SummaryStats/QC_ID',num2str(si),'_Sess',num2str(sess),'.txt']);
    fileattrib(['SummaryStats\QC_ID',num2str(si),'_Sess',num2str(sess),'.txt'],'+w');
    %fileattrib(['SummaryStats/QC_ID',num2str(si),'_Sess',num2str(sess),'.txt'],'+w');
end
fileID = fopen(['SummaryStats\QC_ID',num2str(si),'_Sess',num2str(sess),'.txt'],'w');
%fileID = fopen(['SummaryStats/QC_ID',num2str(si),'_Sess',num2str(sess),'.txt'],'w');
fprintf(fileID,['Subject ID ',num2str(si),' session ',num2str(sess),'\n\n']);

fprintf(fileID,['Effort bonus: ',num2str(Effort.bonus),'\n\n']);

fprintf(fileID,['QC Effort task: \n']);

if fl{1}; test = 'FAIL';else test = 'PASS';end
fprintf(fileID,[test, ': Recovery of Effort file.\n']);

testnoA = Effort.prop_no_answers<threshold_noA;
if testnoA; test = 'PASS';else test = 'FAIL';end
fprintf(fileID,[test, ': proportion of missed trials <',num2str(threshold_noA),'\n']);

testefb = Effort.bias(1)<threshold_EffortBias;
if testnoA; test = 'PASS';else test = 'FAIL';end
fprintf(fileID,[test, ': proportion of same effort choices <',num2str(.5+threshold_EffortBias),'\n']);

testsib = Effort.bias(2)<threshold_EffortBias;
if testnoA; test = 'PASS';else test = 'FAIL';end
fprintf(fileID,[test, ': proportion of same left/right choices <',num2str(.5+threshold_EffortBias),'\n\n']);


fprintf(fileID,['QC RLT task - learning: \n']);

if fl{2}; test = 'FAIL';else test = 'PASS';end
fprintf(fileID,[test, ': Recovery of Learning file.\n']);

testnoA = RLWM.prop_no_answers<threshold_noA;
if testnoA; test = 'PASS';else test = 'FAIL';end
fprintf(fileID,[test, ': proportion of missed trials <',num2str(threshold_noA),'\n']);

testperf =RLWM.performance>.5;
if testperf; test = 'PASS';else test = 'FAIL';end
fprintf(fileID,[test, ': Performance > ',num2str(.5),'\n\n']);


fprintf(fileID,['QC RLT task - testing: \n']);

if fl{3}; test = 'FAIL';else test = 'PASS';end
fprintf(fileID,[test, ': Analysis of Testing data.\n']);

testnoA = RLWMPST.prop_no_answers<threshold_noA;
if testnoA; test = 'PASS';else test = 'FAIL';end
fprintf(fileID,[test, ': proportion of missed trials <',num2str(threshold_noA),'\n']);

testbiasLR =RLWMPST.logistic(3)<threshold_PSTBias;
if testbiasLR; test = 'PASS';else test = 'FAIL';end
fprintf(fileID,[test, ': proportion of same left/right choices <',num2str(.5+threshold_PSTBias),'\n']);

testbiasalt =RLWMPST.logistic(4)<threshold_PSTBias;
if testbiasalt; test = 'PASS';else test = 'FAIL';end
fprintf(fileID,[test, ': proportion of alternating choices <',num2str(.5+threshold_PSTBias),'\n']);

fclose(fileID);
fileattrib(['SummaryStats/QC_ID',num2str(si),'_Sess',num2str(sess),'.txt'],'-w');
end


%% analyze RLWMPST test phase
function [bs,prop_no_answer] = analyseValue(si,sess)
%{
 each cell in tst_stims ha
lines:
- 1 ?
- 2. value (1-3) = AMB
- 3. set size
- 4. folder number
- 5. image number in folder
- 6. block number
%}

touse =1; % 1: average value including 0s, 2; excluding 0s
%% Add subjects main number to the list of subjects here



dossier = 'GroupedExpeData\';
%dossier = 'GroupedExpeData/';
    %si
    load([dossier,'RLWMPST_ID',num2str(si),'_Session',num2str(sess),'.mat'])
        
    donnees = dataT;
    blocks = donnees{end}.blocks;
    stimuli = dataT{end}.stimuli;
    stSets = dataT{end}.stSets;
    PerfC =zeros(6,3,9);
    
    % obtain objective value
    for bl = 1:length(blocks)
        st = stimuli{bl};
        for i = 1:length(st)
            
            T = find(dataT{bl}.seq==i);
            X = dataT{bl}.Cor(T);
            W = dataT{bl}.winnings(T);
            val(1) = mean(W(X>-1));
            val(2) = mean(W(X>0));
            W(W==2)=1;
            val(3) = mean(W(X>-1));
            perf(stSets(bl),st(i),1:3) = val;
            
        end
            
    end
    
    
    % get test phase data
    stseqs = matrice.testStimsSeqs;
    taille = length(stseqs);
    Mat = [];
    list = [];
    for t = 1:taille
        X = stseqs{t};
        left_val = X(2,1);%1 is A, 2 is M, 3 is B.
        left_ns = X(3,1);
        left_block = X(6,1);
        right_val = X(2,2);
        right_ns = X(3,2);
        right_block = X(6,2);
        actual_left_val = perf(X(4,1),X(5,1),touse);
        actual_right_val = perf(X(4,2),X(5,2),touse);
        Mat(t,:) = [left_val right_val left_ns right_ns left_block right_block ...
            actual_left_val actual_right_val];
    end
    
    choice = (dataTest(:,5)- 1); % 0 lefts, 1 right.
    rt = dataTest(:,3);
    test = find(choice>0 |rt>.15);
    prop_no_answer = 1-(length(test)/length(choice));
    previouschoice = [mean(choice);choice(1:end-1)];
    
    %length(diffval)
    
    val_left = Mat(test,end-1);
    val_right = Mat(test,end);
    meanval = mean(Mat(test,end-1:end),2);
    set_left = Mat(test,3);
    set_right = Mat(test,4);
    dist_left = 23-Mat(test,5);
    dist_right = 23-Mat(test,6);
    previouschoice = previouschoice(test);
    choice = choice(test);
    
    X = [val_left-val_right set_left-set_right previouschoice];
    X1 = zscore(X);%X1 = [X1 X1(:,1).*X1(:,2)];
    %[B dev stats]=mnrfit(X1,2-choice);%%%%logistic regression of perf depending on value, probabilistic

    bs = nan(1,2);%[stats.beta(2:3)'];
    
    bs = [bs abs(mean(choice)-.5) abs(mean(choice==previouschoice)-.5)];
    
end


%% analyze RLWM learning phase

function [st_b,perf,prop_no_answers] = analyzeRLWM(si,sess)

dossier = 'GroupedExpeData\';
%dossier = 'GroupedExpeData/';

interaction = 0;
if interaction ==1
type =  {'Fixed','SetSize', 'delay','CorReps', '1x2', '1x3',  '2x3'};
else
type =  {'Fixed','SetSize', 'delay','CorReps'};
end


    
    [X,perf,prop_no_answers] = getData2(si,sess);
    %X(:,2) = min(1,2./X(:,2));
    % set size
    X(:,2) = -min(1,1./X(:,2));
    % delay
    X(:,3) = -1./X(:,3);
    % iterations
    X(:,4) = -1./X(:,4);
    
%     
%     z=repmat(nanmean(X(:,[2:4 9])),size(X,1),1);
%     X(:,[2:4 9])=X(:,[2:4 9])-z;
%     z=repmat(nanstd(X(:,[2:4 9])),size(X,1),1);
%     X(:,[2:4 9])=X(:,[2:4 9])./z;
%     
%     % logistic regression (nS, time last correct, number of previous
%     % corrects)
%     %[B dev stats]=mnrfit([X(:,[2:4 9])],X(:,5)+1);%%%%logistic regression of perf depending on nS, delay, time
%     if interaction 
%     [B dev stats]=mnrfit([X(:,2:4) X(:,2).*X(:,3) X(:,2).*X(:,4) X(:,3).*X(:,4) X(:,2).*X(:,3).*X(:,4)],2-X(:,5));%%%%logistic regression of perf depending on nS, delay, time
%     else
%     [B dev stats]=mnrfit([X(:,[2:4])],2-X(:,5));%%%%logistic regression of perf depending on nS, delay, time
%     end
%     st_b=stats.beta';
%     

st_b=nan;
end


function [MS,perf,prop_no_answers] = getData2(si,sess)

dossier = 'GroupedExpeData\';
%dossier = 'GroupedExpeData/';
    load([dossier,'RLWMPST_ID',num2str(si),'_Session',num2str(sess),'.mat'])
donnees = dataT;

blocks = donnees{end}.blocks;
T = length(blocks);

prop_no_answers = 0;
MS = [];
for epi=1:T
    if isempty(donnees{epi})
    else
    nS = blocks(epi);% number stimuli to learn
    D=donnees{epi};% episode's data
    X = D.Cor;
    W = D.winnings;
    prop_no_answers = prop_no_answers+length(find(X==-1));
    W(X==-1)=0;
    X(X==-1)=0;
            %X = dataT{bl}.Rew(T);
    Y = D.seq;
    Z = D.RT;
    
    Mat =-ones(1,nS);%%%1: time last correct ; 2: nb of previous corrects
    Mat = [Mat;zeros(4,nS)];
    for t = 1:length(X)
        st = Y(t);
        co = X(t);
        r = Z(t);
        
        MS = [MS;[si nS t-Mat(1,st) Mat(2,st) co Mat(3,st) r epi Mat(4,st)]];
        % sujet,  set size, delay, nb previous cor, cor, nb previous inc,
        % rt, block, prev rew
        if co ==1
            Mat(1,st) = t;
            Mat(5,st) = W(t)-Mat(4,st)/Mat(2,st);
            Mat(2,st) = Mat(2,st)+1;
            Mat(4,st) = W(t);%Mat(4,st) +W(t); %
        else
           %Mat(1,st) = t;
            Mat(3,st) = Mat(3,st)+1;
        end
        if co<1 &W(t)>0
            Mat
            co
            W(t)
            boum
        end
        Mat(4,st) = W(t); 
            
            
    end
    end
end
prop_no_answers = prop_no_answers/size(MS,1);
perf = nanmean(MS(:,4)>0);
MS(MS(:,4)==0,:)=[];


end



function [noA,bs_log,bias,bonus]=analyzeEffort(si,sess)

dossier = 'GroupedExpeData\';
%dossier = 'GroupedExpeData/';

    load([dossier,'Efforts_S',num2str(si),'Sess_',num2str(sess)])
    %load(['GroupedExpeData/Efforts_S',num2str(si),'Sess_',num2str(sess)])
    n72 = size(data,1);
    data = [data (1:n72)' ones(n72,1)];
    noA = length(find(data(:,5)==-1))/n72;
    
    data(data(:,9)==-1,:) = [];
    data(data(:,5)==-1,:) = [];
    data(:,1) = .5*abs(data(:,1)) + 1*(1-abs(data(:,1)));
    
    %% logistic regression 
%     [b dev stats] = mnrfit([zscore(data(:,[1:4 12]))],2-data(:,6));
%     % fixed, chance, left/right, value, effort, time
%     bs_log = b';
    %[b stats.p]'
    bs_log = nan;
    %% bias
    choiceside = data(:,6).*data(:,2) + ((1-data(:,6)).*(1-data(:,2)));
    bias(1) = abs(mean(data(:,6))-.5);
    bias(2) = abs(mean(choiceside)-.5);
    %% bonus 
    bonus = data(end,8)/20;
        
    
end
%% stattoolbox functions
function m=nanmean(X)
X = X(~isnan(X));
m=mean(X);

end

function s=nanstd(X)
X = X(~isnan(X));
s=std(X);
end

function X=zscore(X)
X = (X-nanmean(X))/nanstd(X);
end