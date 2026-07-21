function [] = model_simulation(G,time,ang_speed,plot_enable)

    if(plot_enable)
        t= 0:0.01:5;
        duty = [50 100 150 200 250 -50 -100 -150 -200 -250];
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])        
        for i = 1:length(duty)
            u = duty(i)*ones(1,length(t));
            y{i} = lsim(G,u,t);

            p1 = plot(time{i},ang_speed{i},'b','LineWidth',1.5);
            hold on
            p2 = plot(t,y{i},'r','LineWidth',1.5);
            hold on
        end
        grid on
        xlabel('Time (s)','Interpreter','latex')
        ylabel('Angular Velocity ($\deg/$s)','Interpreter','latex')
        legend([p1,p2],{'Experimental data','Model simulation'},'Location','best','Interpreter','latex')
        xlim([0 5])
        saveas(gcf,'Figures/rw_model_simulation','epsc')
    end
end