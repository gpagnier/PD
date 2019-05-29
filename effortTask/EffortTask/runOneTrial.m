function [chosen,GainvsCost,reward,Total,nPress,RT,latence] = runOneTrial(position,...
    hasard,value,effort,Total,choices) 

load GraphicInfo;
Text = textTrial;
grey = 254/2;
red = [255 0 0];
green = [0 255 0];
blue =[0 0 255];% 
white = [255 255 255];

bcol = [blue;green];% color of easy, difficult balloons

%% params

MaxTime = 25;
MaxPress = 200;
%%

Rs = [MinR MinR];
    Balloons(1,:) = CenterRectOnPoint([0 0 1.5*Rs(1) 2*Rs(1)],x(1),.75*rect(4)-4*l5-Rs(1));
    Balloons(2,:) = CenterRectOnPoint([0 0 1.5*Rs(2) 2*Rs(2)],x(2),.75*rect(4)-4*l5-Rs(2));


    
    if position ==1
        order = [1 2];
        cost = [20 effort];%Ns0(order);
        gain = [1 value];
        pcol = bcol(order,:);
        steps = (MaxR-MinR)./[20 MaxPress];
    else
        order = [2 1];
        cost = [effort 20];%Ns0(order);
        gain = [value 1];
        % color of balloon as a function of position
        pcol = bcol(order,:);
        steps = (MaxR-MinR)./[MaxPress 20];
    end
    Ns = cost;
    
    Picks(:,:,1)= [x(1)-l5 .05*rect(4);x(1)+l5 .05*rect(4);x(1) .05*rect(4)+8*l5];
    Picks(:,:,2) = [x(2)-l5 .05*rect(4);x(2)+l5 .05*rect(4);x(2) .05*rect(4)+8*l5];

    Picks(3,2,1+position) =  .05*rect(4)+ 8*l5 + 2*(MaxR-MinR)*(MaxPress-max(cost))/MaxPress;

    % presentation
    
    Screen(w,'FillPoly',0, Ecran);%%Ecrean total noir
    Screen(w,'FillPoly',grey, Game);%%Ecrean total noir
    for choice = choices
    Screen(w,'Fillrect', pcol(order(choice),:), Mouths(order(choice),:));
    Screen(w,'FillOval', pcol(order(choice),:),Balloons(order(choice),:));
    Screen(w,'FillPoly', white,Picks(:,:,order(choice)));
    Screen(w,'FramePoly', 0,Picks(:,:,order(choice)));
    Screen(w,'DrawText',[num2str(gain(order(choice))), Text{1}{1+(gain(order(choice))>1)}],x(order(choice))-16*l5,.75*rect(4),255);
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
    couleur{1} = pcol(1,:);
    couleur{2} = pcol(2,:);
    k_targ = 1;
    kdown = 0;
    
    while test == 0 
        
        [kdown secs code]=KbCheck;
        
        if kdown == 0
            k_targ = 1;
            kdown =0;
            pressed = -1;
        elseif kdown ==1 & k_targ ==0
            k_targ = 0;
            kdown =0;
            pressed = -1;
        else
            keycode=find(code==1);
            keycode = keycode(1);
            k_targ = 0;
            kdown =0;
            pressed = 1;
        end
        
        if nPress == 0 & pressed ==1
            if intersect(keynumbers,keycode)
                nPress = nPress + 1;
                chosen = find(keynumbers == keycode);
                RT(nPress) = secs - tstart;
                prestime = 40;
            end
        elseif pressed ==1
            pressed = find(keynumbers == keycode);
            if pressed == chosen
                nPress = nPress + 1;
                RT(nPress) = secs - tstart;
            end
            %Snd('Play',blow)
        end
        RTF = secs - tstart;
          
        if nPress>0
        if cost(chosen)>20
            couleur{3-chosen} = pcol(3-chosen,:);
            couleur{chosen} = pcol(chosen,:)+(white-pcol(chosen,:))*(GetSecs-tstart)/MaxTime;
        else
            couleur{3-chosen} = pcol(3-chosen,:);
            couleur{chosen} = pcol(chosen,:);%+(white-pcol(chosen,:))*nPress/Ns(chosen);
        end
        Rs(chosen) = MinR + nPress*steps(chosen);
        end

        Balloons(1,:) = CenterRectOnPoint([0 0 1.5*Rs(1) 2*Rs(1)],x(1),.75*rect(4)-4*l5-Rs(1));
        Balloons(2,:) = CenterRectOnPoint([0 0 1.5*Rs(2) 2*Rs(2)],x(2),.75*rect(4)-4*l5-Rs(2));


        Screen(w,'FillPoly',0, Ecran);%%Ecrean total noir
        Screen(w,'FillPoly',grey, Game);%%Ecrean total noir
        for choice = choices
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

        
        if nPress>0
            if cost(chosen)>20
                if(GetSecs-tstart) > MaxTime
                    test = 1;
                end
            else
                if nPress == Ns(chosen)
                    test = 1;
                end
            end

            if nPress>Ns(chosen)

                Picks(3,2,chosen) =   .05*rect(4)+ 8*l5+ 2*(MaxR-MinR)*(MaxPress-max(cost))/MaxPress-...
                    2*steps(chosen)*(min(nPress,MaxPress)-Ns(chosen));
            end
        end
        if nPress == 0 & GetSecs-tstart > prestime
            test = 1;
        end
        
    end
    if test>0 & nPress>0
    Snd('Play',pop)
    end
    % feedback
    if hasard==-1
        reward = 0;
    elseif nPress == 0
        reward = 0;
    else
        if cost(chosen) == 20
        reward = gain(chosen);
        else
        reward = gain(chosen) * (min(nPress,MaxPress)/cost(chosen));
        reward = round(10*reward)/10;
        end
            
    end
    Total = Total + reward;


    Screen(w,'FillPoly',0, Ecran);%%Ecrean total noir
    Screen(w,'FillPoly',grey, Game);%%Ecrean total noir
    for choice = choices
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
    if chosen>0
        if length(choices)>1
    Screen(w,'FillOval', couleur{3-chosen},Balloons(3-chosen,:));
        end
    Screen(w,'DrawText',[Text{5},num2str(reward), Text{1}{1+(reward>1)}],x(chosen)-20*l5,.4*rect(4),green);
    end
    Screen('Flip', w);    
    tic;Snd('Close');latence=toc;
    
    if chosen >0
    GainvsCost = gain(chosen)>1;
    else
        RT = [RT -1];
    end
end