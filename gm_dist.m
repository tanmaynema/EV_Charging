function gm = gm_dist(P, B)
    eps = 1e-8;
    gm = gmdistribution(P(1:2, :)', B*ones(1, 2), P(3, :)+eps);
end
    