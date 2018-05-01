function [z_i_1,z_i] = calculate_z_i(sortedYK,K,y_i_w)

z_i_1 = 0.5*(y_i_w(1,2)+sortedYK(1,2))-0.5*K*(y_i_w(1,1)-sortedYK(1,1));
z_i = 0.5*(y_i_w(1,2)+sortedYK(2,2))-0.5*K*(sortedYK(2,1)-y_i_w(1,1));

end

