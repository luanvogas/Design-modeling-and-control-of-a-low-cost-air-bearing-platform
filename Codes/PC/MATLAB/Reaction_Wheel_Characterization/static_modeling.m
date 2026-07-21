function [angular_coef] = static_modeling(steady_state_duty, ...
                                          steady_state_ang_speed, ...
                                          plot_enable)


    [angular_coef] = least_square_without_linear_coefficient(steady_state_duty, ...
                                                             steady_state_ang_speed);
    
    x_line = steady_state_duty;
    y_line = angular_coef*steady_state_duty;
    
    if(plot_enable)
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        plot(steady_state_duty,steady_state_ang_speed,'b*','LineWidth',1.5);
        hold on
        plot(x_line,y_line,'r','LineWidth',1.5);
        grid on
        xlabel('Duty Cycle Variation ($\mu$s)','Interpreter','Latex')
        ylabel('Angular Velocity ($\deg/$s)','Interpreter','latex')
        saveas(gcf,'Figures/static_modeling_angular_velocity','epsc')
    end
end