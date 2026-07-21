function [pusher_index, ...
          pusher_time, ...
          pusher_duty, ...
          pusher_force, ...
          tractor_index, ...
          tractor_time, ...
          tractor_duty, ...
          tractor_force ...
         ] = experimental_data_loading()

% g to N force conversion

g = 9.8066;

fc = g/1000;

% Pusher mode - M1

pusher_index = 0;

load('Experimental_Data\pusher_m1.mat')

pusher_index = pusher_index + 1;
pusher_time{pusher_index} = t;
pusher_duty{pusher_index} = d;
pusher_force{pusher_index} = -m * fc; 

% Pusher mode - M2

load('Experimental_Data\pusher_m2.mat')

pusher_index = pusher_index + 1;
pusher_time{pusher_index} = t;
pusher_duty{pusher_index} = d;
pusher_force{pusher_index} = -m * fc; 

% Tractor mode - M1

tractor_index = 0;

load('Experimental_Data\tractor_m1.mat')

tractor_index = tractor_index + 1;
tractor_time{tractor_index} = t;
tractor_duty{tractor_index} = d;
tractor_force{tractor_index} = m * fc;  

% Tractor mode - M2

load('Experimental_Data\tractor_m2.mat')

tractor_index = tractor_index + 1;
tractor_time{tractor_index} = t;
tractor_duty{tractor_index} = d;
tractor_force{tractor_index} = m * fc;

% Tractor mode - M3

load('Experimental_Data\tractor_m3.mat')

tractor_index = tractor_index + 1;
tractor_time{tractor_index} = t;
tractor_duty{tractor_index} = d;
tractor_force{tractor_index} = m * fc; 

% Tractor mode - M4

load('Experimental_Data\tractor_m4.mat')

tractor_index = tractor_index + 1;
tractor_time{tractor_index} = t;
tractor_duty{tractor_index} = d;
tractor_force{tractor_index} = m * fc; 

% Tractor mode - M5

load('Experimental_Data\tractor_m5.mat')

tractor_index = tractor_index + 1;
tractor_time{tractor_index} = t;
tractor_duty{tractor_index} = d;
tractor_force{tractor_index} = m * fc;  
