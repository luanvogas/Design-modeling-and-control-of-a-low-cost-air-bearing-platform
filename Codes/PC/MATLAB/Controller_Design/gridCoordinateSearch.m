function [xIndex, yIndex] = gridCoordinateSearch(x, y, xGrid, yGrid)

    xIndex = 1;
    yIndex = 1;
    
    for i = 1:length(xGrid)
        if (xGrid(i) <= x)
            xIndex = i;
        end
    end
    
    for i = 1:length(yGrid)
        if (yGrid(i) <= y)
            yIndex = i;
        end
    end
    
end