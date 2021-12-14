function [B,row,col] = overlapcut(A,s,overlap);

% cut image A into small overlapping patches
% A :       m by n matrix representing the Y component of YIQ
% s    :    size of the small patches
% overlap : overlapping number of pixels in each dimension
% B:        size by size by (row*col) array representing the generated pathes

[m,n] = size(A);

step = s-overlap;
row = floor((m-s+step)/step);
col = floor((n-s+step)/step);

for i=1:row
    for j=1:col
        index = (i-1)*col + j;
        B(:,:,index) = A((i-1)*step+1:(i-1)*step+s,(j-1)*step+1:(j-1)*step+s);
    end
end