function [z, temp,l_i,u_i] = evalFunExpt1(pixelOptIndex,x,temp)


global LB
global UB
global LipAll
global ErrorAll
global MAX_ITERATION
global tStart
global convnet


if pixelOptIndex == 1
    temp(pixelOptIndex,1) = x;
    z = predict(convnet,temp(1:2,1));
elseif pixelOptIndex > 1
    pixelOptIndex = pixelOptIndex - 1;
    temp(pixelOptIndex+1,1) = x;
    lb = LB(pixelOptIndex,1);
    ub = UB(pixelOptIndex,1);
    maxIter = MAX_ITERATION(pixelOptIndex,1);
    bounderror = ErrorAll(pixelOptIndex,1);
    K = LipAll(pixelOptIndex,1);

    x1 = lb;
    x2 = ub;
    
    z1 = evalFunExpt1(pixelOptIndex,x1,temp);
    z2 = evalFunExpt1(pixelOptIndex,x2,temp);
    z_Allsorted = [x1,z1;x2,z2];
    y_2 = calculate_y_i(z_Allsorted,K);
    w_y_2 = evalFunExpt1(pixelOptIndex,y_2,temp);
    [z_1,z_2] = calculate_z_i(z_Allsorted,K,[y_2,w_y_2]);
    Zall(1:2,1) = [z_1;z_2];
    z_Allunsorted = [z_Allsorted;y_2,w_y_2];
    z_Allsorted = sortrows(z_Allunsorted,1);
    l_i = min([z_1,z_2]);
    u_i = min(z_Allsorted(:,2));
    k = 3;
    while(k < maxIter && u_i-l_i > bounderror)
        [~,z_starIndex] = min(Zall);
        y_i =  calculate_y_i(z_Allsorted(z_starIndex:z_starIndex+1,:),K);
        w_y_i = evalFunExpt1(pixelOptIndex,y_i,temp);
        [z_i_1,z_i] = calculate_z_i(z_Allsorted(z_starIndex:z_starIndex+1,:),K,[y_i,w_y_i]);
        Zall = [Zall(1:z_starIndex-1,1);z_i_1;z_i;Zall(z_starIndex+1:end,1)];
        z_Allunsorted = [z_Allsorted;y_i,w_y_i];
        z_Allsorted = sortrows(z_Allunsorted,1);
        l_i = min(Zall);
        u_i = min(z_Allsorted(:,2));
        k = k+1;
    end
    z = u_i;
    z_Allsorted1 = sortrows(z_Allsorted,2);
    temp(pixelOptIndex,1) = z_Allsorted1(1,1);
    if pixelOptIndex >= 2 %&& pixelOptIndex < ll-1
        fprintf('pixelOptIndex = %d; z = %4.4f; lowerBound = %4.4f; upperBound = %4.4f; tElapsed = %2.3fs\n',...
            pixelOptIndex, z,l_i,u_i,toc(tStart));
        tStart = tic;
    end
end

