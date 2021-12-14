function YT = findimage1(YTv,prow,pcol,XTmean,IQ,s,overlap);   
%%%%%%%% averaging %%%%%%%%%%%%%%%%%%%%%%%%%
% compute YIQ components of image YT
%
% YTv: feature vectors for each patch in YT (D by N)
% prow: # of rows of pathces in YT 
% pcol: # of cols of patches in YT
% IQ : I and Q components in YT (row by col by 2)
% s :    size of the small patches 
% overlap : overlapping number of pixels in each dimension

% YT :YIQ image for YT (row- by col- by 3)
fprintf('finding image ... ');
step = s-overlap;

[row,col,x] = size(IQ); 
[D,N] = size(YTv);
if (N~=prow*pcol)
    fprintf('input parameter error!')
    return;
end

Y = zeros(prow*step+overlap,pcol*step+overlap);
count = zeros(prow*step+overlap,pcol*step+overlap);
for i=1:prow
    for j=1:pcol        
        for t=1:s
            Y(step*(i-1)+t,step*(j-1)+1:step*(j-1)+s) = XTmean(i,j) + Y(step*(i-1)+t,step*(j-1)+1:step*(j-1)+s) + YTv(s*(t-1)+1:s*t,(i-1)*pcol+j)';       
            count(step*(i-1)+t,step*(j-1)+1:step*(j-1)+s) = count(step*(i-1)+t,step*(j-1)+1:step*(j-1)+s) +1;
        end
    end
end
YT(:,:,1) = Y./count;
YT(:,:,[2,3]) = IQ(1:prow*step+overlap,1:pcol*step+overlap,:);
fprintf('Done.\n');

% D = 6*6 (overlap 4 or 2) multi-count
% % overlap 4
% overlap = 4;
% Y = zeros(prow*2+overlap,pcol*2+overlap);
% count = zeros(prow*2+overlap,pcol*2+overlap);
% for i=1:prow
%     for j=1:pcol        
%         Y(2*i-1,2*j-1:2*j+4) = Y(2*i-1,2*j-1:2*j+4) + YTv(1:6,(i-1)*pcol+j)';       
%         count(2*i-1,2*j-1:2*j+4) = count(2*i-1,2*j-1:2*j+4) +1;
%         Y(2*i,2*j-1:2*j+4) = Y(2*i,2*j-1:2*j+4) + YTv(7:12,(i-1)*pcol+j)';  
%         count(2*i,2*j-1:2*j+4) = count(2*i,2*j-1:2*j+4) +1;
%         Y(2*i+1,2*j-1:2*j+4) = Y(2*i+1,2*j-1:2*j+4) + YTv(13:18,(i-1)*pcol+j)'; 
%         count(2*i+1,2*j-1:2*j+4) = count(2*i+1,2*j-1:2*j+4) +1;
%         Y(2*i+2,2*j-1:2*j+4) = Y(2*i+2,2*j-1:2*j+4) + YTv(19:24,(i-1)*pcol+j)'; 
%         count(2*i+2,2*j-1:2*j+4) = count(2*i+2,2*j-1:2*j+4) +1;
%         Y(2*i+3,2*j-1:2*j+4) = Y(2*i+3,2*j-1:2*j+4) + YTv(25:30,(i-1)*pcol+j)'; 
%         count(2*i+3,2*j-1:2*j+4) = count(2*i+3,2*j-1:2*j+4) +1;
%         Y(2*i+4,2*j-1:2*j+4) = Y(2*i+4,2*j-1:2*j+4) + YTv(31:36,(i-1)*pcol+j)'; 
%         count(2*i+4,2*j-1:2*j+4) = count(2*i+4,2*j-1:2*j+4) +1;
%     end
% end
% YT(:,:,1) = Y./count;
% YT(:,:,[2,3]) = IQ(1:prow*2+overlap,1:pcol*2+overlap,:);

% % overlap 2
% Y = zeros(prow*4+2,pcol*4+2);
% count = zeros(prow*4+2,pcol*4+2);
% for i=1:prow
%     for j=1:pcol        
%         Y(4*i-3,4*j-3:4*j+2) = Y(4*i-3,4*j-3:4*j+2) + YTv(1:6,(i-1)*pcol+j)';       
%         count(4*i-3,4*j-3:4*j+2) = count(4*i-3,4*j-3:4*j+2) +1;
%         Y(4*i-2,4*j-3:4*j+2) = Y(4*i-2,4*j-3:4*j+2) + YTv(7:12,(i-1)*pcol+j)';       
%         count(4*i-2,4*j-3:4*j+2) = count(4*i-2,4*j-3:4*j+2) +1;
%         Y(4*i-1,4*j-3:4*j+2) = Y(4*i-1,4*j-3:4*j+2) + YTv(13:18,(i-1)*pcol+j)';       
%         count(4*i-1,4*j-3:4*j+2) = count(4*i-1,4*j-3:4*j+2) +1;
%         Y(4*i,4*j-3:4*j+2) = Y(4*i,4*j-3:4*j+2) + YTv(19:24,(i-1)*pcol+j)';       
%         count(4*i,4*j-3:4*j+2) = count(4*i,4*j-3:4*j+2) +1;
%         Y(4*i+1,4*j-3:4*j+2) = Y(4*i+1,4*j-3:4*j+2) + YTv(25:30,(i-1)*pcol+j)';       
%         count(4*i+1,4*j-3:4*j+2) = count(4*i+1,4*j-3:4*j+2) +1;
%         Y(4*i+2,4*j-3:4*j+2) = Y(4*i+2,4*j-3:4*j+2) + YTv(31:36,(i-1)*pcol+j)';       
%         count(4*i+2,4*j-3:4*j+2) = count(4*i+2,4*j-3:4*j+2) +1;
%     end
% end
% YT(:,:,1) = Y./count;
% YT(:,:,[2,3]) = IQ(1:prow*4+2,1:pcol*4+2,:);


% % D = 4*4 (overlap  2) multi-count 
% overlap = 2;
% Y = zeros(prow*2+overlap,pcol*2+overlap);
% count = zeros(prow*2+overlap,pcol*2+overlap);
% for i=1:prow
%     for j=1:pcol        
%         Y(2*i-1,2*j-1:2*j+2) = Y(2*i-1,2*j-1:2*j+2) + YTv(1:4,(i-1)*pcol+j)';       
%         count(2*i-1,2*j-1:2*j+2) = count(2*i-1,2*j-1:2*j+2) +1;
%         Y(2*i,2*j-1:2*j+2) = Y(2*i,2*j-1:2*j+2) + YTv(5:8,(i-1)*pcol+j)';  
%         count(2*i,2*j-1:2*j+2) = count(2*i,2*j-1:2*j+2) +1;
%         Y(2*i+1,2*j-1:2*j+2) = Y(2*i+1,2*j-1:2*j+2) + YTv(9:12,(i-1)*pcol+j)'; 
%         count(2*i+1,2*j-1:2*j+2) = count(2*i+1,2*j-1:2*j+2) +1;
%         Y(2*i+2,2*j-1:2*j+2) = Y(2*i+2,2*j-1:2*j+2) + YTv(13:16,(i-1)*pcol+j)'; 
%         count(2*i+2,2*j-1:2*j+2) = count(2*i+2,2*j-1:2*j+2) +1;
%     end
% end
% YT(:,:,1) = Y./count;
% YT(:,:,[2,3]) = IQ(1:prow*2+overlap,1:pcol*2+overlap,:);

% % D = 12*12 (overlap 8) multi-count
% overlap = 8;
% Y = zeros(prow*4+overlap,pcol*4+overlap);
% count = zeros(prow*4+overlap,pcol*4+overlap);
% for i=1:prow
%     for j=1:pcol        
%         for t=1:12
%             Y(4*(i-1)+t,4*j-3:4*j+8) = Y(4*(i-1)+t,4*j-3:4*j+8) + YTv(12*(t-1)+1:12*t,(i-1)*pcol+j)';       
%             count(4*(i-1)+t,4*j-3:4*j+8) = count(4*(i-1)+t,4*j-3:4*j+8) +1;
%         end
%     end
% end
% YT(:,:,1) = Y./count;
% YT(:,:,[2,3]) = IQ(1:prow*4+overlap,1:pcol*4+overlap,:);

