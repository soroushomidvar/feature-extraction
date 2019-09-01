function [sFeat,Sf,Nf,curve]=jGA(feat,label,N,T,CR,MR)
%---Inputs-----------------------------------------------------------------
% feat:  features
% label: labelling
% N:     Number of chromosomes
% T:     Maximum number of generations
% CR:    Crossover rate
% MR:    Mutation rate
%---Outputs----------------------------------------------------------------
% sFeat: Selected features
% Sf:    Selected feature index
% Nf:    Number of selected features
% curve: Convergence curve
%--------------------------------------------------------------------------

% Objective function
fun=@jFitnessFunction; 
% Number of dimensions
D=size(feat,2);
% Initial population
X=zeros(N,D); fit=zeros(1,N);
for i=1:N
  for d=1:D
    if rand() > 0.5
      X(i,d)=1;
    end
  end
end
% Fitness 
for i=1:N
  fit(i)=fun(feat,label,X(i,:));
end
% Pre
curve=inf; t=1; 
figure(1); clf; axis([1 100 0 0.5]); xlabel('Number of Iterations');
ylabel('Fitness Value'); title('Convergence Curve'); grid on;
%---Generations start------------------------------------------------------
while t <= T
	% Convert error to accuracy (inverse of fitness)
  Ifit=1-fit;
  % Get probability
  Prob=Ifit/sum(Ifit);
  % {1} Crossover 
  X1=zeros(1,D); X2=zeros(1,D); z=1;
  for i=1:N
    if rand() < CR
      % Select two parents 
      k1=jRouletteWheelSelection(Prob); k2=jRouletteWheelSelection(Prob);
      % Store parents 
      P1=X(k1,:); P2=X(k2,:);
      % Random select one crossover point
      ind=randi([1,D]);
      % Single point crossover between 2 parents
      X1(z,:)=[P1(1:ind),P2(ind+1:D)]; 
      X2(z,:)=[P2(1:ind),P1(ind+1:D)]; z=z+1;
    end
  end
  % Union
  Xnew=[X1;X2]; Nc=size(Xnew,1); Fnew=zeros(1,Nc);
  % {2} Mutation
  for i=1:Nc
    for d=1:D
      if rand() <= MR
        % Mutate from '0' to '1' or '1' to '0'
        Xnew(i,d)=1-Xnew(i,d);
      end
    end
    % Fitness 
    Fnew(i)=fun(feat,label,Xnew(i,:));
  end 
  % Merge population
  XX=[X;Xnew]; FF=[fit,Fnew]; 
  % Select N best solution 
  [FF,idx]=sort(FF); X=XX(idx(1:N),:); fit=FF(1:N); 
  % Best chromosome
  Xgb=X(1,:); fitG=fit(1); curve(t)=fitG; 
  % Plot convergence curve
  pause(0.000000001); hold on;
  CG=plot(t,fitG,'Color','r','Marker','.'); set(CG,'MarkerSize',5);
  t=t+1;
end
% Select features based on selected index
Pos=1:D; Sf=Pos(Xgb==1); Nf=length(Sf); sFeat=feat(:,Sf); 
end




%---Call Function----------------------------------------------------------
function Route=jRouletteWheelSelection(Prob)
% Cummulative summation
C=cumsum(Prob);
% Random one value, most probability value [0~1]
P=rand();
% Route wheel
for i=1:length(C)
	if C(i) > P
    Route=i; break;
  end
end
end

