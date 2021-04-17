function [x, y] = gm_start(N, gm, zip)
   stBB = zip.BoundingBox;
   st_minlat = min(stBB(:,2));
   st_maxlat = max(stBB(:,2));
   st_latspan = st_maxlat - st_minlat;
   st_minlong = min(stBB(:,1));
   st_maxlong = max(stBB(:,1));
   st_longspan = st_maxlong - st_minlong;
   stX = zip.X;
   stY = zip.Y;
   
   X = random(gm, N);
   x = X(:, 1)';
   y = X(:, 2)';
   for i = 1:N
        flagIsIn = 0;
        while ~flagIsIn
            X = random(gm, 1);
            x(i) = X(1);
            y(i) = X(2);
            flagIsIn = inpolygon(x(i), y(i), stX, stY);
        end
   end
   % mapshow(zip, 'edgecolor', 'r', 'facecolor', 'none')
   % hold on
   % scatter(x, y, '.')
   % hold off
end