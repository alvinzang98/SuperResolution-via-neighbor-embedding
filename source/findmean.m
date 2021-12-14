function XTmean = findmean(XTp,row,col);

[s,s,n] = size(XTp);
if (n~=row*col)
    fprintf('input parameter error!')
    return;
end

XTmean = zeros(row,col);
for i=1:row
    for j=1:col
        index = (i-1)*col+j;
        XTmean(i,j) = mean(mean(XTp(:,:,index)));
    end
end