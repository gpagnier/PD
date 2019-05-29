

% 1st columns: probability?
% 2nd column: position
% 3rd column: value
% 4th column: effort

probs = [0 0 1 -1];
pos = [0 1];
vals = [3 5 7];
effs = [100 120 150];

TrialSeq =[];
for pr = probs
    for po = pos
        for va = vals
            for ef = effs
                TrialSeq = [TrialSeq;[pr po va ef]];
            end
        end
    end
end

Taille = size(TrialSeq,1);
TrialSeq = TrialSeq(randperm(Taille),:);