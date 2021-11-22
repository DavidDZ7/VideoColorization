%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Script for cleaning the Places 365 dataset [1] (delete grayscale images)
% David Norman Díaz Estrada
% davidnd@stud.ntnu.no
%
% This script identifies grayscale images in the dataset, either encoded as
% 8-bit (1 channel) or encoded as 24-bit (3 channels where R=G=B).
% It outputs a list of the identified grayscale images in the format of a
% batch file in order to automate the deletion of these images,
% since grayscale images are not relevant as training examples 
% for image colorization networks.
%
% [1] Bolei Zhou, Agata Lapedriza, Aditya Khosla, Aude Oliva,
% and Antonio Torralba. Places: A 10 million image database
% for scene recognition. IEEE Transactions on Pattern Analysis
% and Machine Intelligence, 40(6):1452–1464, 2018.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%set the path to read images
images_path="D:\DocumentosDNDE\COSI\Semestre 3\VideoProcessing\FinalProject\datasets\Places365_standard_val_256\val_256 - copia\"

%Get the name of images:
imgs_ = dir(fullfile(images_path,'*.jpg')); % pattern to match filenames.    
n_imgs = length(imgs_);    % Number of files found
fprintf('Total images: %.0f \n',n_imgs)


totalGray1=0;
totalGray2=0;
for i=1:1:n_imgs
    img_name = imgs_(i).name;%get image filename
    %fprintf("-----------------------------------------------------------------------------------\n")
    %fprintf("Image # %0.0f: %s\n",i,img_name);
    [~,nameWithoutExt] = fileparts(img_name);%gets file name without the extension

    img_path=strcat(images_path,img_name); %get image full path
    IMG = imread(img_path);% Read original RGB image.
    
    [rows, columns, numberOfColorChannels] = size(IMG);
    
    if numberOfColorChannels<3 %detect if image has less than 3 channels 
        fprintf("del %s\n",img_name)
        totalGray1=totalGray1+1;
    elseif numberOfColorChannels==3
        r = IMG(:,:,1) ; % Red
        g = IMG(:,:,2) ; % Green
        b = IMG(:,:,3) ; % Blue

        if (isequal(r,g) && isequal(g,b)) %detect if image has 3 channels repeated
            fprintf("del %s\n",img_name)
            totalGray2=totalGray2+1;
        end
    end
        

end
fprintf("-----------------------------------------------------------------------------------\n")
fprintf("TOTAL GRAYSCALE IMGS: %0.0f \n",totalGray1+totalGray2)
fprintf("    Grayscale with less than 3 channels: %0.0f\n",totalGray1)
fprintf("    Grayscale with 3 repeated channels : %0.0f\n",totalGray2)