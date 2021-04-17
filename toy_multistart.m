function [x, y] = toy_multistart(N, zip)
   stBB = zip.BoundingBox;
   st_minlat = min(stBB(:,2));
   st_maxlat = max(stBB(:,2));
   st_latspan = st_maxlat - st_minlat;
   st_minlong = min(stBB(:,1));
   st_maxlong = max(stBB(:,1));
   st_longspan = st_maxlong - st_minlong;
   stX = zip.X;
   stY = zip.Y;
   x = zeros(1, length(st_minlong));
   y = zeros(1, length(st_minlat));
   for i = 1:N
        flagIsIn = 0;
        while ~flagIsIn
            x(i) = st_minlong + rand(1) * st_longspan;
            y(i) = st_minlat + rand(1) * st_latspan;
            flagIsIn = inpolygon(x(i), y(i), stX, stY);
        end
    end
   % mapshow(zip, 'edgecolor', 'r', 'facecolor', 'none')
   % hold on
   % scatter(x, y, '.')
   % hold off
end