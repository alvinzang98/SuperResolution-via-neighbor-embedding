function [YT,U,neighborhood] = naneighbor(XT,XS,YS,K);

% compute weight matrix U by reconstructing nearest appearance neighbors (nan) of XT in XS
% XT :  N by T matrix of T features, each colomn representing a N-D feature vector
% XS :  N by S matrix of S features, each colomn representing a N-D feature vector
% YS :  M by S matrix of S features, each colomn representing a M-D feature vector (M>N)
% K :  # of nearest appearance neighbors, deciding by Euclidean distance
%
% YT :  M by T matrix of T features, each colomn representing a M-D feature vector
% U :  K by T weight matrix
% neighborhood : K by T matrix indicating the neighbors of each feature vector

[N,T] = size(XT);
[N,S] = size(XS);
[M,SS] = size(YS);

% fprintf('Computing weights U of %d nearest appearance neighbors\n',K);
for i = 1:T
    temp = XT(:,i);
    distance = dist2(temp',XS');
    [sorted,index] = sort(distance');
    neighborhood(:,i) = index(2:(K+1));
end
tol=1e-4; % regularlizer in case constrained fits are ill conditioned

U = zeros(K,T);
for ii=1:T
    z = XS(:,neighborhood(:,ii))-repmat(XT(:,ii),1,K); % shift ith pt to origin
    C = z'*z;                                        % local covariance
    if trace(C)==0
        C = C + eye(K,K)*tol;                   % regularlization
    else
        C = C + eye(K,K)*tol*trace(C);
    end
    U(:,ii) = C\ones(K,1);                           % solve C*u=1
    U(:,ii) = U(:,ii)/sum(U(:,ii));                  % enforce sum(u)=1
end;

for ii = 1:T
    YT(:,ii) = YS(:,neighborhood(:,ii))*U(:,ii);
end
