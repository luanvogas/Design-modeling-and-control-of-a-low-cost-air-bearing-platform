function [] = air_bearing_characterization_data_plot(air_bearing_unpainted_time, ...
                                                     air_bearing_unpainted_pressure, ...
                                                     air_bearing_painted_time, ...
                                                     air_bearing_painted_pressure, ...
                                                     plot_enable)
    
    
    %% Relevant data

    % Unpainted bearing 

    air_bearing_unpainted_time{1} = air_bearing_unpainted_time{1}(18:end);
    air_bearing_unpainted_pressure{1} = air_bearing_unpainted_pressure{1}(18:end);

    air_bearing_unpainted_time{2} = air_bearing_unpainted_time{2}(13:end);
    air_bearing_unpainted_pressure{2} = air_bearing_unpainted_pressure{2}(13:end);

    air_bearing_unpainted_time{3} = air_bearing_unpainted_time{3}(12:end);
    air_bearing_unpainted_pressure{3} = air_bearing_unpainted_pressure{3}(12:end);

    % Painted bearing

    air_bearing_painted_time{1} = air_bearing_painted_time{1}(2:end);
    air_bearing_painted_pressure{1} = air_bearing_painted_pressure{1}(2:end);

    air_bearing_painted_time{2} = air_bearing_painted_time{2}(12:end);
    air_bearing_painted_pressure{2} = air_bearing_painted_pressure{2}(12:end);

    air_bearing_painted_time{3} = air_bearing_painted_time{3}(8:end);
    air_bearing_painted_pressure{3} = air_bearing_painted_pressure{3}(8:end);


    %% Initial time adjustment

    for i = 1:3

        air_bearing_unpainted_time{i} = (air_bearing_unpainted_time{i} - ...
                                        air_bearing_unpainted_time{i}(1))/1000;
        air_bearing_painted_time{i} = (air_bearing_painted_time{i} - ...
                                      air_bearing_painted_time{i}(1))/1000;
    end

    %% Separation of a set of samples

    max_time = 120;

    for i = 1:3

        cut_point_unpainted = max(find(air_bearing_unpainted_time{i} <= max_time));
        cut_point_painted = max(find(air_bearing_painted_time{i} <= max_time));

        air_bearing_unpainted_time{i} = air_bearing_unpainted_time{i}(1:cut_point_unpainted);
        air_bearing_unpainted_pressure{i} = air_bearing_unpainted_pressure{i}(1:cut_point_unpainted);

        air_bearing_painted_time{i} = air_bearing_painted_time{i}(1:cut_point_painted);
        air_bearing_painted_pressure{i} = air_bearing_painted_pressure{i}(1:cut_point_painted);

    end

    %% Mean of the 100 initial samples

    for i = 1:3 
        initial_mean_unpainted{i} = mean(air_bearing_unpainted_pressure{i}(1:100));
        initial_mean_painted{i} = mean(air_bearing_painted_pressure{i}(1:100));        
    end

    %% Mean of the 100 final samples 

    for i = 1:3 
        final_mean_unpainted{i} = mean(air_bearing_unpainted_pressure{i}(end-100:end));
        final_mean_painted{i} = mean(air_bearing_painted_pressure{i}(end-100:end));       
    end

    %% Percentual difference

    for i = 1:3
        percentual_difference_unpainted{i} = 100 - (100 * final_mean_unpainted{i}) / initial_mean_unpainted{i};
        percentual_difference_painted{i} = 100 - (100 * final_mean_painted{i}) / initial_mean_painted{i};      
    end  

    % Percentages    
    for i = 1:3
        unpainted(i) = percentual_difference_unpainted{i};
        painted(i)   = percentual_difference_painted{i};
    end
    
    % Table header
    fprintf('\n%-25s | %-25s\n', 'Unpainted Bearing (%)', 'Painted Bearing (%)');
    fprintf('%s\n', repmat('-', 1, 55)); % separator line
    
    % Print data
    for i = 1:3
        fprintf('%-25.4f | %-25.4f\n', unpainted(i), painted(i));
    end

    %% Plot of the data

    if(plot_enable)

        lw = 1.5;  
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        tiledlayout(2,1)
        %
        nexttile  
        for i = 1:3
            p1 = plot(air_bearing_unpainted_time{i}, ...
                      air_bearing_unpainted_pressure{i}, ...
                      'b','LineWidth',lw);
            hold on
        end
        for i = 1:3
            p2 = plot(air_bearing_unpainted_time{i}, ...
                      initial_mean_unpainted{i} * ... 
                      ones(size(air_bearing_unpainted_pressure{i})), ...
                      '--k','LineWidth',lw);
        end 
        grid on
        ylabel('Air Pressure (psi)','Interpreter','Latex')
        %
        nexttile  
        for i = 1:3
            p1 = plot(air_bearing_painted_time{i}, ...
                      air_bearing_painted_pressure{i}, ...
                      'b','LineWidth',lw);
            hold on
        end
        for i = 1:3
            p2 = plot(air_bearing_painted_time{i}, ...
                      initial_mean_painted{i} * ... 
                      ones(size(air_bearing_painted_pressure{i})), ...
                      '--k','LineWidth',lw);
        end 
        grid on
        xlabel('Time (s)','Interpreter','Latex')
        ylabel('Air Pressure (psi)','Interpreter','Latex')
        %
        lgd = legend([p1,p2],{'Experimental data','Average of the first 100 samples'},'Location','best','Interpreter','latex');
        lgd.Layout.Tile = 'south';
        saveas(gcf,'Figures/pneumatic_characterization_bearings','epsc')
    end

end