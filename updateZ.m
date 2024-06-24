function Z = updateZ(XX,AA,lamda,alpha,distX)
%For quadratic programming (QP) problem, there are two options to obtain
%the solution (i.e. 'SimplexQP_acc' or 'quadprog').
% QP_options = 'quadprog';
QP_options = 'SimplexQP_acc';

[m,~] = size(AA); %The number of anchors
n = size(XX,1); %The number of samples
% View = length(X); %The number of views
% if nargin < 4 %Initialize Z
%     beta = 0;
%     delta = zeros(View,1);
%     P = zeros(n,m);
%     for j = 1:View
%         initZ{j} = P;
%     end
% end
options = optimset( 'Algorithm','interior-point-convex','Display','off');
H = 2 * alpha * eye(m) + 2*lamda*AA*AA';
H = (H+H')/2;
    parfor ji = 1:n
        ff = -2*lamda*XX(ji,:)*AA' + distX(ji,:);
        %QP_options
        switch lower(QP_options)
            case {lower('SimplexQP_acc')}
                Z(ji,:) = SimplexQP_acc(H / 2,-ff');                
            case {lower('quadprog')}
                Z(ji,:) = quadprog(H,ff',[],[],ones(1,m),1,zeros(m,1),ones(m,1),[],options);
        end        
    end
%     Z=Z';
end
