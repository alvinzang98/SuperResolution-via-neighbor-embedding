function B = averaging4(A);
%average a RGB image A into B
% A: m by n by 3
% B: m by n by 3

[m,n,x] = size(A);
if mod(m,4)~=0
   m=m-mod(m,4);
end
if mod(n,4)~=0
   n=n-mod(n,4);
end

A = double(A);
B = zeros(m,n,3);
for i=1:4:m
    for j=1:4:n
        temp = round((sum(A(i,j:j+3,:))+sum(A(i+1,j:j+3,:))+sum(A(i+2,j:j+3,:))+sum(A(i+3,j:j+3,:)))/16);
        for x=0:3
            B(i,j+x,:) = temp;
            B(i+1,j+x,:) = temp;
            B(i+2,j+x,:) = temp;
            B(i+3,j+x,:) = temp;
        end
    end
end
B = uint8(B);


