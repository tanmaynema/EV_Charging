function [f, df] = objective_ga(X, P)
    
     Nx = size(X, 2)/3;
   % X_ga = [X(1, (1):(Nx));X(1, (Nx+1):(Nx*2));X(1, (Nx*2+1):(Nx*3))];
     x_n_i = X(1, (Nx*2+1):(Nx*3));
   % Nx = size(X, 2);
    
   % x_lat = X_ga(1, :);
   % x_lng = X_ga(2, :);
    
   % p_lat = P(1, :);
   % p_lng = P(2, :);
   % p_o_i = P(3, :);

   % [x_lat_mesh, p_lat_mesh] = meshgrid(x_lat, p_lat);
   % [x_lng_mesh, p_lng_mesh] = meshgrid(x_lng, p_lng);
   % d_lat = x_lat_mesh - p_lat_mesh;
   % d_lng = x_lng_mesh - p_lng_mesh;
   % D = d_lat.^2 + d_lng.^2;

    f = sum(sum(x_n_i));
end    