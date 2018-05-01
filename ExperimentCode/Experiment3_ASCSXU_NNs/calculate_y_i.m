function y_i = calculate_y_i(sortedYK,K)
y_i = 0.5*(sortedYK(1,1)+sortedYK(2,1)) + 0.5*(sortedYK(1,2)-sortedYK(2,2))/K;
end

