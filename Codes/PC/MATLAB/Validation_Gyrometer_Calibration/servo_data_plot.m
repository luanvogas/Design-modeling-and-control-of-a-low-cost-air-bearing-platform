function [] = servo_data_plot(t_servo,...
                              angle_servo,...
                              plot_enable)

    if(plot_enable)    
        lw = 1.5;  
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        plot(t_servo,angle_servo,'LineWidth',lw)
        grid on
        xlabel('Time (s)','Interpreter','latex')
        ylabel('Angular Displacement ($\deg$)','Interpreter','latex')
        xlim([0 5])
        saveas(gcf,'Figures/servo_data_plot','epsc')
    end
end