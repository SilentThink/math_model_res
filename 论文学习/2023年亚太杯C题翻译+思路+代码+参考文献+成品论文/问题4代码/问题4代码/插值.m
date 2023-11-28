x = [1:9 11:13]; 
y = [0.5 1.2 2.4 4.8 6.4 7.6 10.6 14.71 25.4 59 67.9 220]; 
xi = 10; 
yi = lagrange(x, y, xi)

function yi = lagrange(x, y, xi)
    n = length(x);
    yi = 0;
    for i = 1:n
        L = 1;
        for j = 1:n
            if i ~= j
                L = L * (xi - x(j))/(x(i) - x(j));
            end
        end
        yi = yi + y(i) * L;
    end
end



