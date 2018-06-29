%% Code for paper "Confidence Reachability Analysis on DNNs"
% Compare Robustness of Different DNNs for MNIST Classification
clear
clc
load FunctionNNs

global LB
global UB
global LipAll
global ErrorAll
global MAX_ITERATION
global tStart
global convnet

for i = 1:6
    LB = [0;0];
    UB = [10;10];
    LipAll = [2;2];
    if i == 6
        LipAll = [20;20];
    end
    ErrorAll = [0.01;0.01];
    MAX_ITERATION = [1000;1000];
    pixelOptIndex = 3;
    temp = [0;1;4];
    x = 3;
    convnet = FuncNN{i,1};
    tStart = tic;
    tic
    [zLGOMin,imageReultMin] = evalFunExpt1(pixelOptIndex,x,temp);
    [zLGO,imageReultMax] = evalFunExpt1_MAX(pixelOptIndex,x,temp);
    toc
    %%
    disp('Now use the exhaustive Search to find the accurate minimum!')
    disp('It may take a while ... around tens of minutes without GPU')
    
    x_pixel1 = LB(1):0.002:UB(1);
    x_pixel2 = LB(2):0.002:UB(2);
    [X,Y] = meshgrid(x_pixel1,x_pixel2);
    input = [X(:),Y(:)]';
    tic
    z = predict(convnet,reshape(input,[2,1,1,size(input,2)]));
    toc
    fprintf('\nEstimate Global Minimum = %8.8f; Maximum = %8.8f \n', zLGOMin, -zLGO)
    fprintf('Accurate Global Minimum = %8.8f; Maximum = %8.8f \n\n', min(z),max(z))
end

