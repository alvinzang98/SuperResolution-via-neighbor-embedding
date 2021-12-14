% ------ test low-resolution image -----------
RGB_YT = imread('.\pic\4_HR_Set14_001.png','png'); 
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
