function [forceCompensationX,forceCompensationY] =  forceCompensationDueGlassInclination(x,y)

	[currentIncX,currentIncY] = slopeDeterminationBasedOnCoordinates(x,y);

	m = 1220.24/1000; % kg
    g = 9.8066; % m/s^2

	forceCompensationX = m * g * sind(currentIncX);
	forceCompensationY = m * g * sind(currentIncY);
end


