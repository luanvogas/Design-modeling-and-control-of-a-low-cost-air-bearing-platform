function [average_time,average_ang_speed] = average_dynamic(time, ...
                                                            normalized_ang_speed, ...
                                                            plot_enable)

    average_time = zeros(length(time{1}),1);   
    average_ang_speed = zeros(length(normalized_ang_speed{1}),1);         
    counter = 0;

    if(plot_enable)
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        blue = [0 0.4470 0.7410];
        orange = [0.8500 0.3250 0.0980];
    end

    for i = 1:length(time)
        counter = counter + 1;
        average_time  = average_time  + time{i};
        average_ang_speed = average_ang_speed + normalized_ang_speed{i};

        if(plot_enable)
            p1 = plot(time{i},normalized_ang_speed{i},'b','LineWidth',1.5);
            hold on
        end    
    end
    
    average_time = average_time / counter;
    average_ang_speed = average_ang_speed / counter;

    save('Matlab_Data\average_dynamic','average_time','average_ang_speed');

    if(plot_enable)
        p2 = plot(average_time,average_ang_speed,'r','LineWidth',1.5);
        grid on 
        xlabel('Time (s)','Interpreter','latex')
        ylabel('Normalized Angular Velocity','Interpreter','latex')
        legend([p1,p2],{'Experimental data','Mean'},'Location','best','Interpreter','latex')
        xlim([0 5])
        saveas(gcf,'Figures/average_dynamic_angular_velocity','epsc')
    end
end