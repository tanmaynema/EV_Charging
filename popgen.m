function start = popgen(pop, N, gm, zip, P, min)
    start = [];
    avg = sum(P(3, :)) / N;
    for i = 1:pop
        [x, y] = gm_start(N, gm, zip);
        n = unifrnd(avg*min, avg*(2-min), [1, N]);
        s = [x y n];
        start = [start; s];
    end
end