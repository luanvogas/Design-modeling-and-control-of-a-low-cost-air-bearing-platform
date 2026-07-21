function [t_exp,...
          xmp_exp,...
          ymp_exp,...
          xcont_exp,...
          ycont_exp,...
          rot_exp,...
          rot_ref_exp,...
          rw_control] = DLMI_experimental_disturbance_rejection()


    %% Experimental data loading
    
    filename = 'Experimental_Data\control_data_DLMI_disturbance.csv';
    data = csvread(filename);
    
    t_exp = data(:,2);
    xmp_exp = data(:,11);
    ymp_exp = data(:,12);
    rot_exp = data(:,10);
    rot_ref_exp = data(:,95);
    ang_vel = data(:,57);
    rw_control = data(:,79);
    xcont_exp = data(:,49);
    ycont_exp = data(:,50);
    
end