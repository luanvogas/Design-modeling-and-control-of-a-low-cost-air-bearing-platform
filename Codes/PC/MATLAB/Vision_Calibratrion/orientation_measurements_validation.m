function [] = orientation_measurements_validation(x, ...
                                                  y, ...
                                                  angles, ...
                                                  plot_enable)

    if(plot_enable)

        % Definition of the angles

        angles_grid = 0:15:345; 

        % Color

        matlab_blue  = [0 0.4470 0.7410];       

        lw = 1.5;
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        plot([0:350],[0:350],'r','LineWidth',lw);
        hold on
        for i = 1:length(x)
            plot(angles_grid,angles{i},'.','Color',matlab_blue,'LineWidth',lw);
            hold on
        end        
        grid on
        xlabel('Actual Angle ($\deg$)','Interpreter','latex')
        ylabel('Measured Angle ($\deg$)','Interpreter','latex')
        xt = 0:50:350;
        xticks(xt)
        yticks(xt)
        saveas(gcf,'Figures/angles_measured_calibration','epsc')
    end

end
