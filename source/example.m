% Single-image super-resolution, an example with head images
% Notations:
%    XS: low-resolution source(training)
%    YS: high-resolution source(training)
%    XT: low-resolution target(input)
%    YT: high-resolution target
%    ET: estimate high-resolution target
% 


close all;
clear all;
for i = 1:20
    %%% ------ training set high-resolution and low-resolution images -------
   %RGB_YS = imread('.\pic\head-high.bmp','bmp');
   if i<10
    RGB_YS = imread(strcat('.\pic\VOC2012_0000',int2str(i),'.jpg'));  
   else
       RGB_YS = imread(strcat('.\pic\VOC2012_000',int2str(i),'.jpg'));
   end
    RGB_XS = averaging4(RGB_YS);
    RGB_XS = downsize(RGB_XS,4);
    %%% ------ Y component in YIQ format -----------
    YIQ = rgb2ntsc(RGB_XS);XS = YIQ(:,:,1);  
    YIQ = rgb2ntsc(RGB_YS);YS = YIQ(:,:,1); 
    %%% ------ create image patches ------
    [XSp,XSrow,XScol] = overlapcut(XS, 3, 2);
    [YSp,YSrow,YScol] = overlapcut(YS, 12, 8);
    %%% ----- gradient features -------
    XSv2 = findgradient(XSp,XS,XSrow,XScol);
    YSv2 = findfeature(YSp,YS,YSrow,YScol,0);
    if i==1
        XSv = XSv2;
        YSv = YSv2; 
    else
        XSv(:,size(XSv,2)+1:size(XSv,2)+size(XSv2,2)) = XSv2;
        YSv(:,size(YSv,2)+1:size(YSv,2)+size(YSv2,2)) = YSv2;
    end
end
% ------ test low-resolution image -----------
RGB_YT = imread('.\pic\head-high.bmp','bmp'); 
RGB_XT = averaging4(RGB_YT); oldB = RGB_XT;
RGB_XT = downsize(RGB_XT,4);
YIQ = rgb2ntsc(RGB_XT);XT = YIQ(:,:,1); 
YIQ = rgb2ntsc(oldB);IQ_YT = YIQ(:,:,2:3);
[XTp,XTrow,XTcol] = overlapcut(XT, 3, 2);
XTmean = findmean(XTp,XTrow,XTcol);
XTv = findgradient(XTp,XT,XTrow,XTcol);

%%% ----- locally linear embedding --------
K = 5;
YTv = naneighbor(XTv,XSv,YSv,K);
ET = findimage1(YTv,XTrow,XTcol,XTmean,IQ_YT,12,8);   %YIQ components of estimated high-resolution image 
%%% ------ show image ---------
RGB_ET = ntsc2rgb(ET);
figure;image(RGB_XT);axis off;title('input low-res');
figure;image(RGB_ET);axis off;title('output super-res');



