% read image sequence into memory, correct vertical intensity and FFT
% filter of images
function [M,K]=ImgSeq2MK(dir,color,zrange)
load splat
disp('FFT transfering');
load('Hmask_0928.mat')
for i =1:zrange
    temp=imread([dir,'/',num2str(color),'_',num2str(i,'%03d'),'.tiff']);
    M(:,:,i)=double(temp);
    temp_fft=H2w6P.*fftshift(fft2(M(:,:,i)));
    K(:,:,i)=real(ifft2(ifftshift(temp_fft)));
end     
end