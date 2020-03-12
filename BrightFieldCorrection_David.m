%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% BrightfieldCorrection_David %%
%% David Thonnard              %%
%% thonnard.davd@gmail.com     %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% MATLAB script for brightfield correction
%% Steps:
%%   1: run this script (F5)
%%   2: select folder that contains the image files
%%   3: select brightfield (background) image
%%   4: select folder for output

%% Brightfield correction adapted from BrightFieldSubtraction.m from
%% Ben Vermaercke

%% WARNING
%% This script does NOT overwrite existing (output) image files!

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% select folder with (mosaic) image files
folder_images = uigetdir('*.*','Select folder with image files');

% list all image files
list_files = dir(folder_images);
list_files = list_files(~[list_files.isdir]); % only include files; exlcude folders

% count number of image files
index = length(list_files);

% get brightfield image
[filename, pathname, ~] = uigetfile('*.*','Select background image');
file = strcat(pathname,filename);
background = imread(file);

% select output folder
folder_output = uigetdir('*.*','Select folder for processed files or create new folder');

% process all the images
for i = 1:index
    % create variable with image file name
    image_file = fullfile(folder_images,list_files(i).name);

    % read image
    img = imread(image_file);

    % brightfield correction (adapted from Ben Vermaercke)
    processed_image = uint8(double(img)./double(background)*255);
    
    % create output file name
    [~,name,ext] = fileparts(image_file);
    filename = char(fullfile(folder_output,strcat(name,"_processed",ext)));
  
    % save file
    imwrite(processed_image, filename);
end

% clear memory
clear background ext file filename folder_images folder_output i image_file img index list_files name pathname processed_image;