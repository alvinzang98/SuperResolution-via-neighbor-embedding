function B = averaging3(A);
%average/blur a RGB image A into B
% A: m by n by 3
% B: m by n by 3

[m,n,x] = size(A);

A = double(A);
B = zeros(m,n,3);
for i=1:3:m
    for j=1:3:n
        temp = (sum(A(i,j:j+2,:))+sum(A(i+1,j:j+2,:))+sum(A(i+2,j:j+2,:)))/9;
        for x=0:2
            B(i,j+x,:) = temp;
            B(i+1,j+x,:) = temp;
            B(i+2,j+x,:) = temp;
        end
    end
end
B = uint8(B);


