function [ ] = plotPChcErrSGNG( Task )
%plotPChcErrSGNG Summary of this function goes here
%   Detailed explanation goes here

NUM_SESSION = length(Task);

pErr = new_struct({'clrEasy','clrHard'}, 'dim',[1,NUM_SESSION]);
pErr = struct('AREasy',pErr, 'ARHard',pErr);

for kk = 1:NUM_SESSION
  
  %index by color discriminability
  idxClrHard = (Task(kk).HardColor == 1);
  idxClrEasy = (Task(kk).HardColor == 0);
  %index by aspect ratio
  idxARHard = (Task(kk).SingletonDiff == 2);
  idxAREasy = (Task(kk).SingletonDiff == 4);
  %index by trial outcome
  idxErr = (Task(kk).Error == 1);
  
  %compute percent correct
  pErr.AREasy(kk).clrEasy = sum(idxClrEasy & idxAREasy & idxErr) / sum(idxClrEasy & idxAREasy);
  pErr.AREasy(kk).clrHard = sum(idxClrHard & idxAREasy & idxErr) / sum(idxClrHard & idxAREasy);
  pErr.ARHard(kk).clrEasy = sum(idxClrEasy & idxAREasy & idxErr) / sum(idxClrEasy & idxARHard);
  pErr.ARHard(kk).clrHard = sum(idxClrHard & idxAREasy & idxErr) / sum(idxClrHard & idxARHard);
  
end%for:session(kk)

%% Plotting

%BAR PLOT
yBar = [mean([pErr.AREasy.clrEasy]), mean([pErr.AREasy.clrHard]), mean([pErr.ARHard.clrEasy]), mean([pErr.ARHard.clrHard])];
sdBar = [std([pErr.AREasy.clrEasy]), std([pErr.AREasy.clrHard]), std([pErr.ARHard.clrEasy]), std([pErr.ARHard.clrHard])];

figure(); hold on
bar((1:4), yBar, 'FaceColor','k')
errorbar_no_caps((1:4), yBar, 'err',sdBar/sqrt(NUM_SESSION))
ppretty([4,5])

pause(0.25)

%LINE PLOT
figure(); hold on
plot((1:NUM_SESSION), [pErr.AREasy.clrEasy], 'k-')
plot((1:NUM_SESSION), [pErr.AREasy.clrHard], 'r-')
plot((1:NUM_SESSION), [pErr.ARHard.clrEasy], 'k-', 'LineWidth',1.5)
plot((1:NUM_SESSION), [pErr.ARHard.clrHard], 'r-', 'LineWidth',1.5)
ppretty([6.4,4])

end%plotPChcErrSGNG()

%   %index by singleton color
%   idxSingRed = (Task(kk).SingletonColor == 0);
%   idxSingNRed = (Task(kk).SingletonColor == 2);
%   idxSingGrn = (Task(kk).SingletonColor == 1);
%   idxSingNGrn = (Task(kk).SingletonColor == 9);
