 clear all
 clc

%%
Mainimages={};
Mainimagesfeatures={};
Normalizedimages={};

images=dir('C:\Users\Hassan\Desktop\pca\mainimages\*.jpg'); %read image files

imgfeatures=dir('C:\Users\Hassan\Desktop\pca\mainimages\*.txt');%image text file

for i = 1:length(images)
    
imgtitle = ['mainimages\' images(i).name]; % image title

imagefeatures = ['mainimages\' imgfeatures(i).name]; %text files

Imageread = imread(imgtitle); %read image
Imageread = rgb2gray(Imageread);%convert images to greyscale
Mainimages{i}=Imageread;

readtext=textread(imagefeatures);
Mainimagesfeatures{i}=readtext;
end
%%
P_features=[13,20 ; 50,20 ; 34,34 ; 16,50 ; 48,50];% predefined location feature matrix

for a = 1:length(images)

    rotationtranslation = pinv([Mainimagesfeatures{a}, [1;1;1;1;1]]) * P_features;
    rotation = rotationtranslation(1:2,:);%taking first two rows complete 
    rotation = rotation';%taking transpose
    translation = rotationtranslation(3,:);%taking whole 3rd row
    translation = translation';%taking transpose
    
   Imageread=Mainimages{a};
          normalizedImage=uint8(zeros(64, 64));%creating matrix of 64 by 64 zeros
    for i=1:64
      for j=1:64       
          normalizedpoint   = (pinv(rotation)*( [ i; j ] - translation ));
           
          x_originalimg = int32(normalizedpoint(1,:));%taking first row point
          y_originalimg = int32(normalizedpoint(2,:));%taking second row point
            
          
          if(x_originalimg <= 0)
              x_originalimg  = 1;
          end
          
          if(y_originalimg <= 0)
              y_originalimg = 1;
              
          end
          
          if(x_originalimg > 320)
              x_originalimg  = 320;
          end
          
          if(y_originalimg >320)
              y_originalimg = 320;
          end
          
            
          normalizedImage(i,j) = uint8(Imageread(y_originalimg, x_originalimg));
      end
    end
    
    
    imgtitle = ['mainimages\' images(a).name];%array of images title
 Normalizedimages{a} = normalizedImage';
 imwrite(normalizedImage',imgtitle);
%  imshow(normalizedImage')
end
    
%%
    
