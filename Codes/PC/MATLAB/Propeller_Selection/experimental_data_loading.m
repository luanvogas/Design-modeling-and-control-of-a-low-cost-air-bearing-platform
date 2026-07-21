function [pusher_time_air, ...
          pusher_duty_air, ...
          pusher_force_air, ...
          tractor_time_air, ...
          tractor_duty_air, ...
          tractor_force_air, ...
          pusher_time_ducted, ...
          pusher_duty_ducted, ...
          pusher_force_ducted, ...
          tractor_time_ducted, ...
          tractor_duty_ducted, ...
          tractor_force_ducted ...
          ] = experimental_data_loading()

% g to N force conversion

g = 9.8066;

fc = g/1000;

% Pusher mode - 45 mm double blade - air

filename = 'Experimental_Data\pusher_45mm_double_blade_air.csv';
data = csvread(filename);

pusher_time_air{1} = (data(:,1) - data(1,1))/1000;
pusher_duty_air{1} = data(:,2);
pusher_force_air{1} = -data(:,3) * fc; 

% Pusher mode - 45 mm triple blade - air

filename = 'Experimental_Data\pusher_45mm_triple_blade_air.csv';
data = csvread(filename);

pusher_time_air{2} = (data(:,1) - data(1,1))/1000;
pusher_duty_air{2} = data(:,2);
pusher_force_air{2} = -data(:,3) * fc; 

% Pusher mode - 55 mm - air

filename = 'Experimental_Data\pusher_55mm_air.csv';
data = csvread(filename);

pusher_time_air{3} = (data(:,1) - data(1,1))/1000;
pusher_duty_air{3} = data(:,2);
pusher_force_air{3} = -data(:,3) * fc; 

% Tractor mode - 45 mm double blade - air

filename = 'Experimental_Data\tractor_45mm_double_blade_air.csv';
data = csvread(filename);

tractor_time_air{1} = (data(:,1) - data(1,1))/1000;
tractor_duty_air{1} = data(:,2);
tractor_force_air{1} = data(:,3) * fc; 

% Tractor mode - 45 mm triple blade - air

filename = 'Experimental_Data\tractor_45mm_triple_blade_air.csv';
data = csvread(filename);

tractor_time_air{2} = (data(:,1) - data(1,1))/1000;
tractor_duty_air{2} = data(:,2);
tractor_force_air{2} = data(:,3) * fc; 

% Tractor mode - 55 mm - air

filename = 'Experimental_Data\tractor_55mm_air.csv';
data = csvread(filename);

tractor_time_air{3} = (data(:,1) - data(1,1))/1000;
tractor_duty_air{3} = data(:,2);
tractor_force_air{3} = data(:,3) * fc; 

% Pusher mode - 45 mm double blade - ducted

filename = 'Experimental_Data\pusher_45mm_double_blade_ducted.csv';
data = csvread(filename);

pusher_time_ducted{1} = (data(:,1) - data(1,1))/1000;
pusher_duty_ducted{1} = data(:,2);
pusher_force_ducted{1} = -data(:,3) * fc; 

% Pusher mode - 45 mm triple blade - ducted

filename = 'Experimental_Data\pusher_45mm_triple_blade_ducted.csv';
data = csvread(filename);

pusher_time_ducted{2} = (data(:,1) - data(1,1))/1000;
pusher_duty_ducted{2} = data(:,2);
pusher_force_ducted{2} = -data(:,3) * fc; 

% Pusher mode - 55 mm - ducted

filename = 'Experimental_Data\pusher_55mm_ducted.csv';
data = csvread(filename);

pusher_time_ducted{3} = (data(:,1) - data(1,1))/1000;
pusher_duty_ducted{3} = data(:,2);
pusher_force_ducted{3} = -data(:,3) * fc; 

% Tractor mode - 45 mm double blade - ducted

filename = 'Experimental_Data\tractor_45mm_double_blade_ducted.csv';
data = csvread(filename);

tractor_time_ducted{1} = (data(:,1) - data(1,1))/1000;
tractor_duty_ducted{1} = data(:,2);
tractor_force_ducted{1} = data(:,3) * fc; 

% Tractor mode - 45 mm triple blade - ducted

filename = 'Experimental_Data\tractor_45mm_triple_blade_ducted.csv';
data = csvread(filename);

tractor_time_ducted{2} = (data(:,1) - data(1,1))/1000;
tractor_duty_ducted{2} = data(:,2);
tractor_force_ducted{2} = data(:,3) * fc; 

% Tractor mode - 55 mm - ducted

filename = 'Experimental_Data\tractor_55mm_ducted.csv';
data = csvread(filename);

tractor_time_ducted{3} = (data(:,1) - data(1,1))/1000;
tractor_duty_ducted{3} = data(:,2);
tractor_force_ducted{3} = data(:,3) * fc; 

end