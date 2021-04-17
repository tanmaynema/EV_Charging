function [f, df] = objective(X, P, B)
    
    x_n_i = X(3, :);
 %   x_lat = X(1, :);
 %   x_lng = X(2, :);
    
 %   p_lat = P(1, :);
 %   p_lng = P(2, :);
 %   p_o_i = P(3, :);

 %   [x_lat_mesh, p_lat_mesh] = meshgrid(x_lat, p_lat);
 %   [x_lng_mesh, p_lng_mesh] = meshgrid(x_lng, p_lng);
 %   d_lat = x_lat_mesh - p_lat_mesh;
 %   d_lng = x_lng_mesh - p_lng_mesh;
 %   D = d_lat.^2 + d_lng.^2;
 %   [W, dWdlat, dWdlng] = create_w(X, P, B);
    f = sum(sum(x_n_i));
 
end   