function [output] = homebrew(N, zip, demand,P, B)
    pop = N*100;
    [X0,Y0] = toy_multistart(pop, zip); % Nx100 random starting points
    half = sum(demand)/(N); % mid way point for station size
    P0n = (half*0.8)*ones(1, pop) + (half*0.4)*rand(1, pop); % random station sizes
    subgroupx = zeros(pop, N); 
    subgroupy = zeros(pop, N);
    subgroupn = zeros(pop, N);
    fitness = zeros(pop, 1);
    for i = 1:pop
        r = randi([1, pop], 1, N);
        subgroupx(i, 1:N) = X0(1, r);
        subgroupy(i, 1:N) = Y0(1, r);
        subgroupn(i, 1:N) = P0n(1, r);
        fitness(i, 1) = objective([subgroupx(i,:); subgroupy(i,:); subgroupn(i,:)], P, B);
    end
    for g = 1:10 % generations
      subgroup1x = zeros(pop, N);
      subgroup1y = zeros(pop, N);
      subgroup1n = zeros(pop, N);
        for i = 1:pop
            r1 = randi([1, pop], 1, 1);
            r2 = randi([1, pop], 1, 1);
            if fitness((r1),1) < fitness((r2), 1)
                subgroup1x(i, 1:N) = subgroupx(r1, 1:N) -0.002 + (0.004).*rand(1, N);
                subgroup1y(i, 1:N) = subgroupy(r1, 1:N) -0.002 + (0.004).*rand(1, N);
                subgroup1n(i, 1:N) = subgroupn(r1, 1:N) -15 + (30).*rand(1, N);
            else
                subgroup1x(i, 1:N) = subgroupx(r2, 1:N) -0.002 + (0.004).*rand(1, N);
                subgroup1y(i, 1:N) = subgroupy(r2, 1:N) -0.002 + (0.004).*rand(1, N);
                subgroup1n(i, 1:N) = subgroupn(r2, 1:N) -15 + (30).*rand(1, N);
            end     
        end
        for l = 1:(pop)
            r = randi([1, pop], 1, 1);
            station = randi([1, N], 1, 1);
            gene = subgroup1x(r, station);
            subgroup1x(r, station) = subgroup1y(r, station);
            subgroup1y(r, station) = gene;
        end
        for i = 1:(pop)
            subgroup1n(i,:) = subgroup1n(i,:)*((half*N)/sum(subgroup1n(i,:)));
            fitness(i, 1) = objective([subgroup1x(i, :); subgroup1y(i, :); subgroup1n(i, :)], P, B);
        end
        subgroupx = subgroup1x;
        subgroupy = subgroup1y;
        subgroupn = subgroup1n;
        [m, I] = min(fitness);
    end
    figure;
    mapshow(zip, 'edgecolor', 'k', 'facecolor', 'none');
    hold on;
    scatter(P(1,:), P(2,:), 'oc');
    scatter(subgroupx(I, :),subgroupy(I, :) , '*r', 'linewidth', 1.5);
    output = [subgroupx(I, :);subgroupy(I, :);subgroupn(I, :)];
   % scatter(X_end(1,:), X_end(2,:), '*b', 'linewidth', 1.5);
    %scatter(x(1,1:N), x(1,(N+1):(N*2)), '*r', 'linewidth', 1.5);
    %scatter(X_end(1,1:N), X_end(1,(N+1):(N*2)), '*b', 'linewidth', 1.5);
end