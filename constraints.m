function [g, h] = constraints(X, P, B)
    x_n_i = X(3, :);
    p_o_i = P(3, :);

    [W] = create_w(X, P, B);
    g1 = (p_o_i') - sum(x_n_i .*W, 2);
    g2 = -1 + sum(W, 1)';
    g = [g1; g2];
    h = sum(p_o_i) - sum(x_n_i);
end