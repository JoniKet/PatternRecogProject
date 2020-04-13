% Tool to plot numbers 
% Created by Joni Kettunen for the pattern recognition course fall 2019

function plotNumber(number)

    [rows,dims] = size(number);

    hold on
    for i = 1:rows-1
        startx = number(i,1);
        endx = number(i+1,1);
        starty = number(i,2);
        endy = number(i+1,2);
        %startz = number(i,3);
        %endz = number(i+1,3);

        %plot3([startx,endx],[starty,endy],[startz,endz])    
        plot([startx,endx],[starty,endy])  
    end
    hold off
end