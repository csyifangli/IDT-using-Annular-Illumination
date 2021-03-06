clc
clearvars
close all

addpath('functions')
addpath('Utilities')

%% Parameter

lambda=0.515; % Wavelength
k=2*pi/lambda; % Wave number

NA=0.65;
Mag=40;
Pixelsize=6.5/Mag;
n_Medium=1.33;

Length_MN=8;% the number of LEDs
Bright_Radius=29.7;% the Radius of LED ring
fDL=Bright_Radius./tan(asin(NA));% the distance of LED and object 

Calib=1; % if Calibrate LED postion
gpu = 0;% if using gpu

%% Step Load measured intensity data and initial spectrum postion

load('IRaw_Elegans.mat');

Cablib_Nx=400;  
Cablib_Ny=400;

Cablib_pointX=300;  
Cablib_pointY=300;

eval Step0_IDT_Init

%% Step Implete the calibation of LED postion

 if Calib==1
    eval Step1_IDT_Calib
 end
 
%% Implete the IDT
dz=1;
Depth_Set=[-10:dz:10];

Alpha=1e2;
Beta=1e2;

eval Step2_IDT_Poss

%% show RI Slice

figure
for ii=1:length(Depth_Set)
    subplot(121)
    imshow(imag(squeeze(RI(:,:,ii))),[]);
    subplot(122)
    imshow(real(squeeze(RI(:,:,ii))),[]);
    pause(0.5);
end

                    







