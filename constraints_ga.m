function [g, h] = constraints_ga(X, P, B)
    Nx = length(X)/3;
    X_ga = [X(1, (1):(Nx));X(1, (Nx+1):(Nx*2));X(1, (Nx*2+1):(Nx*3))];
    x_n_i = X(1, (Nx*2+1):(Nx*3));
    p_o_i = P(3, :);

    [W, ~, ~] = create_w(X_ga, P, B);
    
    g1 = p_o_i' -sum(x_n_i .* W, 2);
    g2 = -1 + sum(W, 1)';
    g = [g1; g2];
    h = [];%- sum(p_o_i) + sum(x_n_i);
end