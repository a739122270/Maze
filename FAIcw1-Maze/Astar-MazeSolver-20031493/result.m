%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Optimal path: starting from the last node, backtrack to
% its parent nodes until it reaches the start node
% 04-26-2005    Copyright 2009-2010 The MathWorks, Inc.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
Optimal_path = [];
QUEUE_COUNT = size(QUEUE, 1);
xval = QUEUE(QUEUE_COUNT, 2);
yval = QUEUE(QUEUE_COUNT, 3);

temp = QUEUE_COUNT-1;
while(((xval ~= xTarget) || (yval ~= yTarget)) && temp > 0)
    temp = temp - 1;
    xval = QUEUE(1, 2);
    yval = QUEUE(1, 3);
end

i = 1;
Optimal_path(i, 1) = xval;
Optimal_path(i, 2) = yval;
if ((xval == xTarget) && (yval == yTarget))
    inode = 0;
    % Traverse QUEUE and determine the parent nodes
    parent_x = QUEUE(index(QUEUE, xval, yval), 4);
    parent_y = QUEUE(index(QUEUE, xval, yval), 5);
   
    while(parent_x ~= xStart || parent_y ~= yStart)
        i = i + 1;
        Optimal_path(i, 1) = parent_x; % store nodes on the optimal path
        Optimal_path(i, 2) = parent_y;
        inode = index(QUEUE, parent_x, parent_y); % find the grandparents 
        parent_x = QUEUE(inode, 4);
        parent_y = QUEUE(inode, 5);
    end
    Optimal_path(i+1,1) = xStart;    % add start node to the optimal path  
    Optimal_path(i+1,2) = yStart;
        while(i>1)
        maze( Optimal_path(i, 1),Optimal_path(i, 2))=5;
        dispMaze(maze);
        i=i-1;
    end
else
    h = msgbox('Oops! No path exists to the Target!', 'warn');
end
