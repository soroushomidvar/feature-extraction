function [mcord, mcovd, pValue, tStatistic, dof] = mcorrdis(x,y)
%
%   Modified Correlation and Covariance Distance Quantities
%
%   [mcord, mcovd, pValue, tStatistic, dof] = bcdistcorr(X,Y) returns the
%   modified correlation and covariance distance values as well as some
%   results such as p-value, t-statistics and degree-of-freedom. In this
%   function X (size n-by-p) and Y (size n-by-q) are n random samples of 
%   observation. Note that the t-test of independence is unbiased for 
%   every n ? 4 and any significance level.
%
% SYBTAX:
%        mcord = bcdistcorr(x,y)
%       [mcord, mcovd] = bcdistcorr(x,y)
%       [mcord, mcovd, pValue, tStatistic, dof] = bcdistcorr(x,y)
%
% INPUTS:
%       x : Matrix of size n-by-p
%       y : Matrix of size n-by-q
%
% OUTPUTS:
%       mcord : Modified correlation distance
%       mcovd : Modified covariance distance
%
%   This implementation is based on Székely, G. J., & Rizzo, M. L. (2013).
%   The distance correlation t-test of independence in high dimension.
%   Journal of Multivariate Analysis, 117, 193-213.
%

assert(rows(x)==rows(y));

n = rows(x);
X = Astar(x);    
Y = Astar(y);

XY = modified_distance_covariance(X,Y);
XX = modified_distance_covariance(X,X); clear X;
YY = modified_distance_covariance(Y,Y); clear Y;

% Modified covariance and correlation distances:
mcovd = XY;
mcord = XY/sqrt(XX*YY);

M = n*(n-3)/2;
tStatistic = sqrt(M-1) * mcord / sqrt(1-mcord^2);
dof = M-1;
pValue = 1 - tcdf(tStatistic,dof);

% fprintf('Bias-corrected R = %.3f, p-value=%.3f, T(%d)=%.4f\n',...
%     mcord, pValue, dof,tStatistic);

end

function XY = modified_distance_covariance(X,Y)
n = rows(X);
XY = sum(sum(bsxfun(@times, X, Y)))- (n/(n-2))*diag(X)'*diag(Y);
end

function A = Astar(x)
d = pdist2(x,x);

n = rows(x);
m = mean(d);
M = mean(d(:));

% A = d - m'*ones(1,n);
A = bsxfun(@minus, d, bsxfun(@mtimes, m', ones(1,n)));
% A = A - ones(n,1)*m;
A = bsxfun(@minus, A, bsxfun(@mtimes, ones(n,1), m));
% A = A + M;
A = bsxfun(@plus, A, M); 

A = A - d/n;
A(1:n+1:end) = m - M;
A = (n/(n-1))*A;
end

function r = rows(x)
    r = size(x,1);
end