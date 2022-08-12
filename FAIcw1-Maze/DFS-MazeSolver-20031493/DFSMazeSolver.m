%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A* ALGORITHM Demo
% 04-26-2005    Copyright 2009-2010 The MathWorks, Inc.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Matlab Basics
%{
    % "MATLAB Overview" @ MathWorks
    % "Writing a Matlab Program" @ MathWorks
    % Choose your working folder, where all Astar files are saved
    % Understand step-by-step the source code, and start working on Coursework 1
%}
function []=DFSMazeSolver(maze)

%% define the problem via GUI
r=size(maze,1);
xStart=r;
for q = 1 : r
  if(maze(r,q)==3)
    yStart=q;
  end
end

xTarget=1;
for p = 1 : r
  if(maze(1,p)==4)
    yTarget=p;
  end
end

% OBSTACLE: [X val, Y val]
OBSTACLE = [];
k = 1;
for i = 1 : r
    for j = 1 : r
        if((maze(i, j) == 0)||(maze(i, j) == 8))
            OBSTACLE(k, 1) = i;
            OBSTACLE(k, 2) = j;
            k = k + 1;
        end
    end
end
OBST_COUNT = size(OBSTACLE, 1);
OBST_COUNT = OBST_COUNT + 1;
OBSTACLE(OBST_COUNT, :) = [xStart, yStart];
%% add the starting node as the first node (root node) in QUEUE
% QUEUE: [0/1, X val, Y val, Parent X val, Parent Y val]
xNode = xStart;
yNode = yStart;
QUEUE = [];
QUEUE_COUNT = 1;
NoPath = 1; % assume there exists a path
QUEUE(QUEUE_COUNT, :) = insert(xNode, yNode, xNode, yNode);
QUEUE(QUEUE_COUNT, 1) = 0; % What does this do?

%% Start the search
while((xNode ~= xTarget || yNode ~= yTarget) && NoPath == 1)
    % expand the current node to obtain child nodes
    exp = expand(xNode,yNode,xTarget, yTarget, OBSTACLE, r, r);
    exp_count  = size(exp, 1);
    flag=0;
    % Update QUEUE with child nodes; exp: [X val, Y val, g(n), h(n), f(n)]
    if(exp_count>0)
        for i = 1 : exp_count
            for j = 1 : QUEUE_COUNT
                if(exp(i, 1) == QUEUE(j, 2) && exp(i, 2) == QUEUE(j, 3))
                    QUEUE(j,1)=0;
                    flag = 1;
                end
            end
            if flag == 0
                QUEUE_COUNT = QUEUE_COUNT + 1;
                QUEUE(QUEUE_COUNT, :) = insert(exp(i, 1), exp(i, 2), xNode, yNode);
            end % end of insert new element into QUEUE
        end
        xNode=exp(i,1);
        yNode=exp(i,2);
        QUEUE(QUEUE_COUNT,1)=0;
        OBST_COUNT = OBST_COUNT + 1;
        OBSTACLE(OBST_COUNT, 1) = xNode;
        OBSTACLE(OBST_COUNT, 2) = yNode;
        if(maze(xNode,yNode)~=4)
            maze(xNode,yNode)=7;
            dispMaze(maze);
        end
    else
        for i = 1 : QUEUE_COUNT
            if((QUEUE(i,2)==xNode)&&(QUEUE(i,3)==yNode))
                 xNode=QUEUE(i,4);
                 yNode=QUEUE(i,5);
            end
        end
    end
end

%% Output / plot your route
result();


%% Your Coursework 1 report
%{
    % Comparess a. all your program files and b. coursework report
    % Submit the file with name: FAIcw1-YourID.zip
%}
