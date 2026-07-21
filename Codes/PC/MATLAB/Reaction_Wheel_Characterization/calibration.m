function [ang_speed,cal_factor] = calibration(time_calibration, ...
                                   ang_speed_calibration, ...
                                   time, ...
                                   ang_speed_uncalibrated, ...
                                   plot_enable)

    % Determination of the steady-state value of the calibration data

    calibration_samples = find(time_calibration{1} <= 5);

    time_calibration_red = time_calibration{1}(calibration_samples);

    steady_state_cal = mean(ang_speed_calibration{1}(find(time_calibration_red >= 4)));

    % Determination of the steady-state value of the experimental data 

    exp_data_samples = find(time{5} <= 5);

    time_red = time{5}(calibration_samples);

    steady_state_exp_data = mean(ang_speed_uncalibrated{5}(find(time_red >= 4)));

    cal_factor = (1/(steady_state_exp_data))*steady_state_cal;

    % Calibration

    for i = 1:length(ang_speed_uncalibrated)

        ang_speed{i} = ang_speed_uncalibrated{i} * cal_factor;

    end

    % Calibration check

    if(plot_enable)
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        lw = 1.5;
        blue_color = [0 0.4470 0.7410];
        orange_color = [0.8500 0.3250 0.0980];
        gray_color =  [0.5 0.5 0.5];
        for i = 1:length(time)
            p1 = plot(time{i},ang_speed{i},'Color',gray_color,'LineWidth',lw);
            hold on
        end
        p2 = plot(time_calibration{1},ang_speed_calibration{1},'Color',blue_color,'LineWidth',lw);
        hold on
        p3 = plot(time_calibration{2},ang_speed_calibration{2},'Color',orange_color,'LineWidth',lw);
        grid on
        xlabel('Time (s)','Interpreter','latex')
        ylabel('Angular Velocity ($\deg/$s)','Interpreter','latex')
        legend([p1,p2,p3],{'Suspended structure','Sliding surface - acceleration','Sliding surface - braking'},'Location','best','Interpreter','latex')
        xlim([0 5])
        saveas(gcf,'Figures/rw_scale_determination','epsc')
    end

end