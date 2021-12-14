function f = findgradient(A,B,row,col);
% construct the feature vecor for some image
% A : s by s by n matrix, representing patches of Y component of some image
% B : ii by jj matrix of Y component of image
% row:  # of rows of patches
% col:  # of cols of patches
% f : feature vectors

[s,s,n] = size(A);  %n is # of patches
[ii,jj] = size(B);

if (row*col~=n)
    fprintf('input parameter error!');
    return;
end

grad = zeros(ii,jj,4);
for i=1:ii %for each pixel in B matrix
    for j=1:jj
        if (i+1<=ii) & (i-1>=1)
            grad(i,j,1) = B(i+1,j)-B(i-1,j);
        end
        if (j+1<=jj) & (j-1>=1)
            grad(i,j,2) = B(i,j+1)-B(i,j-1);
        end
        if (i+2<=ii) & (i-2>=1)
            grad(i,j,3) = B(i+2,j)-2*B(i,j)+B(i-2,j);
        end
        if (j+2<=jj) & (j-2>=1)
            grad(i,j,4) = B(i,j+2)-2*B(i,j)+B(i,j-2);
        end         
    end
end
for p=1:n
    i = ceil(p/col);        % left top position of p-th patch
    j = mod(p-1,col)+1;     % in grad matrix is (i,j)    
    add = 0;
    for si=0:s-1
        for sj=0:s-1
            for num=1:size(grad,3)
                add = add+1;
                f(add,p) = grad(i+si,j+sj,num);
            end
        end
    end
end
