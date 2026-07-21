function [] = platform_characterization_data_plot(platform_input_time, ...
                                                  platform_input_pressure, ...
                                                  platform_output_time, ...
                                                  platform_output_pressure, ...
                                                  plot_enable)

    %% Relevant data

    % Input 

    index = 1;

    platform_input_time{index} = platform_input_time{index}(59:end);
    platform_input_pressure{index} = platform_input_pressure{index}(59:end);

    index = index + 1;
    platform_input_time{index} = platform_input_time{index}(44:end); 
    platform_input_pressure{index} = platform_input_pressure{index}(44:end);

    index = index + 1;
    platform_input_time{index} = platform_input_time{index}(23:end); 
    platform_input_pressure{index} = platform_input_pressure{index}(23:end);

    % Output

    index = 1;

    platform_output_time{index} = platform_output_time{index}(35:end);
    platform_output_pressure{index} = platform_output_pressure{index}(35:end);

    index = index + 1;
    platform_output_time{index} = platform_output_time{index}(30:end);
    platform_output_pressure{index} = platform_output_pressure{index}(30:end);

    index = index + 1;
    platform_output_time{index} = platform_output_time{index}(37:end);
    platform_output_pressure{index} = platform_output_pressure{index}(37:end);

    %% Initial time adjustment

    for i = 1:3

        platform_input_time{i} = (platform_input_time{i} - ...
                                  platform_input_time{i}(1))/1000;

        platform_output_time{i} = (platform_output_time{i} - ...
                                   platform_output_time{i}(1))/1000;
    end

    %% Separation of a set of samples

    max_time = 120;

    for i = 1:3

        cut_point_input = max(find(platform_input_time{i} <= max_time));
        cut_point_output = max(find(platform_output_time{i} <= max_time));

        platform_input_time{i} = platform_input_time{i}(1:cut_point_input);
        platform_input_pressure{i} = platform_input_pressure{i}(1:cut_point_input);

        platform_output_time{i} = platform_output_time{i}(1:cut_point_output);
        platform_output_pressure{i} = platform_output_pressure{i}(1:cut_point_output);

    end

    %% Mean of the data

    % Sample quantity adjustment

    min_samples_input = length(platform_input_time{1});
    min_samples_output = length(platform_output_time{1});

    for i = 1:3
        samples_input = length(platform_input_time{i});
        samples_output = length(platform_output_time{i});

        if (samples_input <= min_samples_input)
            min_samples_input = samples_input;
        end
        if (samples_output <= min_samples_output)
            min_samples_output = samples_output;
        end
    end

    for i = 1:3        
        platform_input_time{i} = platform_input_time{i}(1:min_samples_input);
        platform_input_pressure{i} = platform_input_pressure{i}(1:min_samples_input);

        platform_output_time{i} = platform_output_time{i}(1:min_samples_output);
        platform_output_pressure{i} = platform_output_pressure{i}(1:min_samples_output);
    end

    % Input

     mean_input_time = (platform_input_time{1} + ...
                        platform_input_time{2} + ...
                        platform_input_time{3}) / 3;

     mean_input_pressure = (platform_input_pressure{1} + ...
                            platform_input_pressure{2} + ...
                            platform_input_pressure{3}) / 3;

    % Output 
    
    mean_output_time = (platform_output_time{1} + ...
                        platform_output_time{2} + ...
                        platform_output_time{3}) / 3;

    mean_output_pressure = (platform_output_pressure{1} + ...
                            platform_output_pressure{2} + ...
                            platform_output_pressure{3}) / 3;

    %% Plot of the data

    if(plot_enable)

        % Input and output test

        lw = 1.5;  
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        tiledlayout(2,1)
        %
        nexttile  
        for i = 1:3
            p{i} = plot(platform_input_time{i},platform_input_pressure{i},'LineWidth',lw);
            hold on
        end        
        text(0.48,1.1,'(a)','Units','normalized','Interpreter','Latex')
        grid on
        xlim([0 120])
        ylim([40 90])
        ylabel('Inlet Pressure (psi)','Interpreter','latex')
        %
        nexttile  
        for i = 1:3
            plot(platform_output_time{i},platform_output_pressure{i},'LineWidth',lw);
            hold on
        end
        text(0.48,1.1,'(b)','Units','normalized','Interpreter','Latex')
        grid on
        xlim([0 120])
        ylim([40 90])
        ylabel('Outlet Pressure (psi)','Interpreter','latex')
        xlabel('Time (s)','Interpreter','latex')
        %
        lgd = legend([p{1},p{2},p{3}],{'Experimental data set 1', ...
                     'Experimental data set 2', 'Experimental data set 3'},...
                     'Location','best','Interpreter','latex');
        lgd.Layout.Tile = 'south';
        saveas(gcf,'Figures/pneumatic_characterization_platform','epsc')

        % Mean of the data

        lw = 1.5;  
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        plot(mean_input_time,mean_input_pressure,'LineWidth',lw);
        hold on
        plot(mean_output_time,mean_output_pressure,'LineWidth',lw);
        grid on
        xlim([0 120])
        ylim([40 90])
        ylabel('Pressure (psi)','Interpreter','latex')
        xlabel('Time (s)','Interpreter','latex')
        legend('Inlet pressure','Outlet pressure','Interpreter','latex','Location','best')
        saveas(gcf,'Figures/air_platform_autonomy','epsc')


end