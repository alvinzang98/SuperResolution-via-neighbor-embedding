function B = downsize(A,ratio);
%downsize a RGB image A into B
% A: m by n by ratio
% B: m/ratio by n/ratio by ratio

[m,n,x] = size(A);
newm = floor(m/ratio);
newn = floor(n/ratio);

B = zeros(newm,newn,3);
for i=1:newm
    for j=1:newn
        B(i,j,:) = A(ratio*i-1,ratio*j-1,:);
    end
end
B = uint8(B);
        

