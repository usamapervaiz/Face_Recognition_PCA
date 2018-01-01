function [Accuracy, img_color]=facerecognition(input_index)
%input_index=1;
%%
%Read trainning image
imgfiles = dir('D:\MAIA France\Image_processing\pcacode\training images\*.jpg');%Giving Directory    
D=[];%training data matrix
Lt=[];%label matrix
filesnum = length(imgfiles);    % Number of files found

 for i=1:filesnum %loop started with starting and end condition
     Imgtitle=imgfiles(i).name; %assign each image name/title here to the variable
    
     Lt=[Lt;Imgtitle(1:3)];%start building the matrix of image names
                           % limit from 1 to 3, to make the dimension of matrix uniform
                          
     IMgtitle = char(strcat('training images\',Imgtitle));%provide the folder which contains the images and concatenate with the image name
     imageread=imread(IMgtitle);%read each image inside the stated folder
     [m,n]=size(imageread)
     if(m~=64||n~=64)
     imageread=imresize(imageread,[64 64])
     end
     reshapetheimage=reshape(imageread,1,64*64);%reshape each image from 64x64 to a row vector of 1 to 64x64

     D=[D;reshapetheimage];%making a datamatrix of images here
 end
%%
%Calculate mean for each image and subtract this mean from each corresponding row entry of the matrix D
m=mean (D,2);%calculate mean for each image
imgcount = size(D,2);%find size of a matrix, only number of columns needed

%Now remove each  mean from  each entry in the corresponding row
meanremoved = [];%matrix with mean removed
for i=1 : imgcount
    reshapetheimage = double(D(:,i)) - m;%removing mean from each entry in the corresponding row
    meanremoved  = [meanremoved reshapetheimage];
end
%%
%covariance matrix(sigma)
e=length(imgfiles)-1;%calculating/finding number of all test images -1
sigmaT=(1/e)*meanremoved*(meanremoved');%apply sigma formula here

%eigenvalues and eigenvectors
[evec,eval]=eigs(sigmaT,length(imgfiles)-3);%calculate eigenvalues and eigenvectors here, 
%provide the sigma and length of images-3, because to avoid warning:For nonsymmetric and
%complex problems,must have number of eigenvalues k < n-1. 
PCA_TM=meanremoved'*evec;%calculate phi here by multiplying transpose of image matrix 
%wih mean removed multiplied with eigenvector

%%
%compute feature vectors for all training images 
Ft=[];
for i=1:filesnum 
     Imgtitle=imgfiles(i).name; %assign each image name/title here to the variable
    
     IMgtitle = char(strcat('training images\',Imgtitle));%provide the folder which contains the images and concatenate with the image name
     imageread=imread(IMgtitle);
     imageread=imresize(imageread,[64 64]);
     reshapetheimage=reshape(imageread,1,64*64);%reshape each image from 64x64 to a row vector of 1 to 64x64
     featurevectortraining=double(reshapetheimage)*PCA_TM;
     Ft=[Ft;featurevectortraining];
end
%%
%reading test images
testimagepath=('D:\MAIA France\Image_processing\pcacode\test images');
input_dir=dir('D:\MAIA France\Image_processing\pcacode\test images\*.jpg');
filter = '*.jpg';
%selectedFile = uigetfile(fullfile(testimagepath , filter));
selectedFile= input_dir(input_index).name
Qt=selectedFile(1:3);%label of selected image
IMgtitle2 = char(strcat('test images\',selectedFile));%provide the folder which contains the images and concatenate with the image name

imageread2=imread(IMgtitle2);%read  image inside the stated folder
%imshow(imageread2);
[m,n]=size(imageread2);
 if(m~=64||n~=64)
 imageread2=imresize(imageread2,[64 64]);
 end
 
reshapethetestimage=reshape(imageread2,1,64*64);
featuretestvector=double(reshapethetestimage)*PCA_TM;
%%
%compute distance
e_dist = [ ];
for i=1 : size(Ft,1)
    x = (norm(featuretestvector-Ft(i,:)))^2;
    e_dist = [e_dist;x];
end
%%
%minimum distance
[euclide_dist_min recognized_index] = min(e_dist)
recognized_img =recognized_index 
% %
% images plotting
% subplot(121);
% color_dir='D:\MAIA France\Image_processing\pcacode\actual_images\';
% imshow([color_dir selectedFile]);title('Searching for ...');
% subplot(122);
%%trying to plot color
img_color=imgfiles(recognized_index).name;

%
%accuracy
error=0;
testimages = dir('D:\MAIA France\Image_processing\pcacode\test images\*.jpg');
for i = 1 : length(testimages)
    
 Imgtitle=testimages(i).name;
 IMg = char(strcat('test images\',Imgtitle));
 image=imread(IMg);
 [m,n]=size(image);
 if(m~=64||n~=64)
 image=imresize(image,[64 64]);
 end
 reshapeimg=reshape(image,1,64*64);
 rec=double(reshapeimg)*PCA_TM; 
 
for a=1:filesnum
    
    z(a) = (norm(rec-Ft(a,:)))^2;    
end
 
 [minimum index]=min(z);

if Lt(index,1:end)~=IMg(:,13:15)
 error=error+1;

end
end
%%
% % %Accuracy test
Accuracy=(1-(error/length(testimages)))*100