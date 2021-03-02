function [Curr, Vmap, Ex, Ey, eFlowx, eFlowy] = Solve(width_nx, height_ny, nx, ny, sigma_outsidebox, sigma_insidebox, boundary_condition, part)
% G matrix 

G = sparse(ny*ny, nx*nx);
V = zeros(nx*ny,1);

% Using Info from Finite Diff LaPlace Lectures Slide 36
% cMap = zeros(width_nx, height_ny);
% for i = 1:width_nx
%     for j = 1:height_ny
%         cMap(i,j) = sigma_outsidebox; % outside the box
%             if (i>=Boxes{1}.X(1) & i<=Boxes{1}.X(2) & (( j>=Boxes{1}.Y(1) & j<=Boxes{1}.Y(2) ) || (j>=Boxes{2}.Y(1) & j<=Boxes{2}.Y(2))))
%                 cMap(i,j) = sigma_insidebox; % inside the box
%             end
%         end
% end
  

% Using Info from Finite Diff LaPlace Lectures Slides 37,39
% G Matrix
for x = 1:nx
    for y = 1:ny
        n = y + (x-1)*ny;
        nxm = y + (x - 2)*ny;       %left
        nxp = y + (x)*ny;           %right
        nym = y - 1 + (x - 1)*ny;   %lower
        nyp = y + 1 + (x - 1)*ny;   %upper
 
        if x == 1
            G(n,:) = 0;
            G(n,n) = 1;
            V(n) = boundary_condition(1);
        
        elseif x == nx
            G(n,:) = 0;
            G(n,n) = 1;
            V(n) = boundary_condition(2);
            
        elseif y == 1
            switch part
                case 1 % part 1a
                    
                    V(n) = 0;
                case 2 % part 1b
                    G(n,:) = 0;
                    G(n,n) = 1;
                    V(n) = 0;
                                
                case 3 %part 2 
                    rxm = (cMap(x,y) + cMap(x-1,y))/2;
                    rxp = (cMap(x,y) + cMap(x+1,y))/2;
                    ryp = (cMap(x,y) + cMap(x1,y+1))/2;
            
                    G(n,n) = -(rxm+rxp+ryp);
                    G(n,nxm) = rxm;
                    G(n,nxp) = rxp;
                    G(n,nyp) = ryp;      
            end %end switch
        
        elseif y == ny
            switch part
                case 1 % part 1a 
                    G(n,:) = 0;
                    G(n,n) = -2;
                    G(n,nxm) = 1;
                    G(n,nxp) = 1;
                    G(n,nym) = 1;
                    G(n,nyp) = 1;
                case 2 % part 1b 
                    G(n,:) = 0;
                    G(n,n) = 1;
                    V(n) = 0;
                               
                case 3 % part 2c,d
                    rxm = (cMap(x,y) + cMap(x-1,y))/2;
                    rxp = (cMap(x,y) + cMap(x+1,y))/2;
                    rym = (cMap(x,y) + cMap(x,y-1))/2;
            
                    G(n,n) = -(rxm+rxp+rym);
                    G(n,nxm) = rxm;
                    G(n,nxp) = rxp;
                    G(n,nym) = rym; 
            end %end switch
        
        else
            switch part
                case 1 % part 1a 
                    G(n,n) = -4;
                    G(n,nxm) = 1;
                    G(n,nxp) = 1;
                    G(n,nym) = 1;
                    G(n,nyp) = 1;
                case 2 % part 1b 
                    G(n,n) = -4;
                    G(n,nxm) = 1;
                    G(n,nxp) = 1;
                    G(n,nym) = 1;
                    G(n,nyp) = 1;
                                   
                case 3 % part 2 
                    rxm = (cMap(x,y) + cMap(x-1,y))/2;
                    rxp = (cMap(x,y) + cMap(x+1,y))/2;
                    rym = (cMap(x,y) + cMap(x,y-1))/2;
                    ryp = (cMap(x,y) + cMap(x,y+1))/2;
            
                    G(n,n) = -(rxm+rxp+ryp+rym);
                    G(n,nxm) = rxm;
                    G(n,nxp) = rxp;
                    G(n,nym) = rym;
                    G(n,nym) = ryp;     
            end %end switch
        end % endif 
        
        
    end
end

Voltage = G\V';
Vmap = zeroes(nx,ny);
for x = 1:nx
    for y = 1:ny
        n = y + (x-1)*ny;
        Vmap(x,y) = Voltage(n);
    end
end

for x = 1:nx
    for y = 1:ny
        if x == 1
            Ex(x , y) = (Vmap(x+1,y) - Vmap(x,y));
        elseif x == nx
            Ex(x , y) = (Vmap(x,y) - Vmap(x-1,y));
        else 
            Ex(x , y) = (Vmap(x+1,y) - Vmap(x-1,y))*0.5;
        end
        
        if y == 1
            Ey(x , y) = (Vmap(x,y+1) - Vmap(x,y));
        elseif y == ny
            Ey(x , y) = (Vmap(x,y) - Vmap(x,y-1));
        else 
            Ey(x , y) = (Vmap(x,y+1) - Vmap(x,y-5))*0.5;
        end
    end
end

Ex = -Ex;
Ey = -Ey;

eFlowx = cMap.*Ex;
eFlowy = cMap.*Ey;

Curr = [eFlowx(:),eFlowy(:)];



end