function [X_end, F] = optimization_EV()
    %%%%%%%%%%%%%% Population Data %%%%%%%%%%%%%%%%
    %raw_data = xlsread('toy_data/san_diego_centers.xlsx', 'san_diego_centers'); % full county
    raw_data = xlsread('toy_data/san_diego_centers.xlsx', 'coronado'); % toy
    zips = shaperead('toy_data/2010_Census_5-digit_ZIP_Code_Tabulation_Areas.shp'); % toy
    %zips = shaperead('Full_data/USA_Counties.shp'); % full county
    zip = zips(1); % creates a polgon
    p_lng = raw_data(:, 4);
    p_lat = raw_data(:, 5);
    demand = raw_data(:, 6);

    %%%%%%%%%%%%%%%%%% Globals %%%%%%%%%%%%%%%%%%%%%%%
    N = 5; % Number of charging stations
    B = 0.0001; %% fitting parameter
    P = [p_lat'; p_lng'; demand']; % Populations centers (lat, long) (j)
    %[x, y]= toy_multistart(N, zip); % starting points

    %%%%%%%%%%%%% objective function %%%%%%%%%%%%%%%%%%
    
  
    gm = gm_dist(P, B);
    avg = sum(demand) / N;
    [x, y] = gm_start(N, gm, zip);
    n = unifrnd(avg*0.2, avg*(2-0.2), [1, N]); % Number of chargers per station
    X = [x; y; n]; % starting point of all variables
    
     mini = sum(demand)/(N*5); % n minimum per station
     maxi = sum(demand)/(N/5); % n maximum per station
    lb = [-117.5*ones(1, N); 32*ones(1, N); mini*ones(1, N)];
    ub = [-117*ones(1, N); 33*ones(1, N); maxi*ones(1, N)];
    fmincon_options = optimoptions(@fmincon, 'MaxIterations', 1000, 'MaxFunctionEvaluations', 1000, 'Algorithm', 'interior-point');%'OptimalityTolerance', 1e-4);
    [X_end, F] = fmincon(@(X) objective(X, P, B), X, [], [], [], [], lb, ub, @(X) constraints(X, P, B), fmincon_options);
    [X_end, F] = fmincon(@(X) objective(X, P, B), X_end, [], [], [], [], lb, ub, @(X) constraints(X, P, B), fmincon_options);
   % [X_end, F] = fmincon(@(X) objective(X, P, B), X, [], [], [], [], lb, ub, @(X) constraints(X, P, B), fmincon_options);
    
    %pop = popgen(50, N, gm, zip, P, 0.2);
    %ga_options = optimoptions(@ga,'NonlinearConstraintAlgorithm','penalty', 'InitialPopulationMatrix', pop);
    %lb_ga = [-117.5*ones(1, N), 32.4*ones(1, N), mini*ones(1, N)];
    %ub_ga = [-116*ones(1, N), 33.6*ones(1, N), maxi*ones(1, N)];
    %[X_end, F] = ga(@(X) objective_ga(X, P), N*3, [], [], [], [], lb_ga', ub_ga', @(X) constraints_ga(X, P, B), ga_options);
    
    %%%% Equality
    % start off relaxed...
    % road = norm(test_x - r); h1

    figure;
    mapshow(zip, 'edgecolor', 'k', 'facecolor', 'none')
    hold on;
    scatter(p_lat, p_lng, 'oc');
    if size(X_end, 1) == 3
        scatter(X_end(1,:), X_end(2,:), 20, X_end(3, :), '*', 'linewidth', 1.5);
        scatter(x, y, '.b', 'linewidth', 1.5);
    else
        scatter(X_end(1,1:N), X_end(1,(N+1):(N*2)), 20, X_end(1,(2*N+1):(N*3)), '*', 'linewidth', 1.5);
    end
    colorbar()
    colormap(flipud(autumn))
    hold off;
    %geobubble(lat, long, demand);
end