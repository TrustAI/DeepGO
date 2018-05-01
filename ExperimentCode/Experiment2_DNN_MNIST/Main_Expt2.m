%% Code for paper "Confidence Reachability Analysis on DNNs"
% Compare Robustness of Different DNNs for MNIST Classification
% clear data and window
clc
clear
close all;

% Define Global varibale to save internal memory
global convnet
global logitlayer
global outputNN_ind
global LB
global UB
global PIXEL_IND
global EPSILON
global LIP_CONST
global R
global INPUT_IMAGE
global MAX_ITERATION
global imageTempK
global tStart
global tStart_M
global BOUNDERROR
global AllImage
global Kall
global LogitAll
global AllImage_M
global Kall_M
global LogitAll_M
global balaceNum

balaceNum = 0.001;
load DNN_1
load MNIST_Dataset


featureCell = {[5,5;5,6;5,7;5,8;5,9;5,10;6,10;7,10];
    [7,6;7,7;8,6;8,7;9,6;9,7;10,6;10,7];
    [11,4;11,5;11,6;11,7;11,8;11,9;10,5;10,6];
    [8,4;8,5;8,6;8,7;8,8;8,9;9,9;10,9]
    };
%%
saveImageNum = 1000;
imageIndex = 2;
featureIndexZ = 2;

%%
Kall = 1;
LogitAll = [];
Kall_M = 1;
LogitAll_M = [];
convnet = convnet_1;
logitlayer = 'fc';
INPUT_IMAGE = XTest(:,:,:,imageIndex);
[imgRowNum,imgColNum] = size(INPUT_IMAGE);
AllImage = zeros(imgRowNum,imgRowNum);
AllImage_M = zeros(imgRowNum,imgRowNum);

[outputNN_start,outputNN_ind] = max(activations(convnet,INPUT_IMAGE,logitlayer));
[outputNN_start_Conf,~] = max(activations(convnet,INPUT_IMAGE,'softmax'));

upperBound = outputNN_start;
PIXEL_IND = featureCell{featureIndexZ,1};

PIXEL_IND = [PIXEL_IND;[1,1]];
LB = zeros(size(PIXEL_IND,1),1);
UB = ones(size(PIXEL_IND,1),1);
EPSILON = 0.003*ones(size(PIXEL_IND,1),1);
R = linspace(1.1,2,size(PIXEL_IND,1));
R = R';

LIP_CONST = 8*ones(size(PIXEL_IND,1),1);
MAX_ITERATION = 100*ones(size(PIXEL_IND,1));
BOUNDERROR = linspace(0.05,0.5,size(PIXEL_IND,1));
BOUNDERROR =BOUNDERROR';

pixelOptIndex = size(PIXEL_IND,1);
x = INPUT_IMAGE(PIXEL_IND(pixelOptIndex,1),PIXEL_IND(pixelOptIndex,2));
imageTempK = INPUT_IMAGE';
imageTempK = imageTempK(:);
disp('Now Calculate the Lower Boundary of Range')

tStart = tic;
tic
[zLGO,imageReult] = evalFunDNNmin(pixelOptIndex,x,INPUT_IMAGE);
toc
min_time = toc(tStart);
%
[B_sort,I_sort] = sort(LogitAll);
LValue = B_sort(1);
Lindex = I_sort;
AllImage = AllImage(:,:,I_sort);
AllImage = AllImage(:,:,1:saveImageNum);
Min_Fig = AllImage(:,:,1);
ConfidenceAll = activations(convnet,reshape(AllImage,[14,14,1,...
    size(AllImage,3)]),'softmax');
ConfTargetAll = ConfidenceAll(:,outputNN_ind);
[CValue,Cindex]= min(ConfTargetAll);

%%
disp('Now Calculate the Ubber Boundary of Range')

tStart_M = tic;
tic
[zLGO_M,imageReult_M] = evalFunDNNmax(pixelOptIndex,x,INPUT_IMAGE);
toc
max_time = toc(tStart_M);

[B_sort_max,I_sort_max] = sort(LogitAll_M);
Lindex_M = I_sort_max(end);
LValue_M = B_sort_max(end);

AllImage_M = AllImage_M(:,:,I_sort_max);
AllImage_M = AllImage_M(:,:,end-saveImageNum+1:end);
Max_Fig = AllImage_M(:,:,end);
ConfidenceAll_M = activations(convnet,reshape(AllImage_M,[14,14,1,...
    size(AllImage_M,3)]),'softmax');
ConfTargetAll_M = ConfidenceAll_M(:,outputNN_ind);
[CValue_M,Cindex_M]= max(ConfTargetAll_M);

%%
figure;
subplot(1,3,1)
imshow(INPUT_IMAGE);
title({'Input Image';num2str(outputNN_start);num2str(outputNN_start_Conf)});

subplot(1,3,2)
imshow(Min_Fig);
title({'Lower Boundary Image';num2str(LValue);num2str(CValue)});

subplot(1,3,3)
imshow(Max_Fig);
title({'Ubber Boundary Image';num2str(LValue_M);num2str(CValue_M)});

fprintf('\nGiven Test Image: Logit = %4.4f; Confidence = %4.4f\n',...
    outputNN_start,min(outputNN_start_Conf))
fprintf('Lower Boundary:  Logit = %4.4f; Confidence = %4.4f\n',...
    LValue,min(ConfTargetAll))
fprintf('Ubber Boundary:  Logit = %4.4f; Confidence = %4.4f\n',...
    LValue_M,max(ConfTargetAll_M))
fprintf('Calculation Time: Lower Bound = %4.3fs; Upper Bound = %4.3fs\n',...
    min_time,max_time)



