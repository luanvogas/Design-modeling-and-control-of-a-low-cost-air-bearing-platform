function [time,duty,ang_speed] = experimental_data_loading(plot_enable)

    index = 0;

    % Test 1
    
    index = index + 1;
    filename = 'Experimental_Data\reaction_wheel_data_Test_1.csv';
    data = csvread(filename);
    
    time{index} = data(:,1);
    duty{index} = data(:,2);
    ang_speed{index} = data(:,5);
    
    % Test 2
    
    index = index + 1;
    filename = 'Experimental_Data\reaction_wheel_data_Test_2.csv';
    data = csvread(filename);
    
    time{index} = data(:,1);
    duty{index} = data(:,2);
    ang_speed{index} = data(:,5);
    
    % Test 3
    
    index = index + 1;
    filename = 'Experimental_Data\reaction_wheel_data_Test_3.csv';
    data = csvread(filename);
    
    time{index} = data(:,1);
    duty{index} = data(:,2);
    ang_speed{index} = data(:,5);

    % Test 4
    
    index = index + 1;
    filename = 'Experimental_Data\reaction_wheel_data_Test_4.csv';
    data = csvread(filename);
    
    time{index} = data(:,1);
    duty{index} = data(:,2);
    ang_speed{index} = data(:,5);

    % Test 5
    
    index = index + 1;
    filename = 'Experimental_Data\reaction_wheel_data_Test_5.csv';
    data = csvread(filename);
    
    time{index} = data(:,1);
    duty{index} = data(:,2);
    ang_speed{index} = data(:,5);

    % Test 6
    
    index = index + 1;
    filename = 'Experimental_Data\reaction_wheel_data_Test_6.csv';
    data = csvread(filename);
    
    time{index} = data(:,1);
    duty{index} = data(:,2);
    ang_speed{index} = data(:,5);

    % Test 7
    
    index = index + 1;
    filename = 'Experimental_Data\reaction_wheel_data_Test_7.csv';
    data = csvread(filename);
    
    time{index} = data(:,1);
    duty{index} = data(:,2);
    ang_speed{index} = data(:,5);

    % Test 8
    
    index = index + 1;
    filename = 'Experimental_Data\reaction_wheel_data_Test_8.csv';
    data = csvread(filename);
    
    time{index} = data(:,1);
    duty{index} = data(:,2);
    ang_speed{index} = data(:,5);

    % Test 9
    
    index = index + 1;
    filename = 'Experimental_Data\reaction_wheel_data_Test_9.csv';
    data = csvread(filename);
    
    time{index} = data(:,1);
    duty{index} = data(:,2);
    ang_speed{index} = data(:,5);

    % Test 10
    
    index = index + 1;
    filename = 'Experimental_Data\reaction_wheel_data_Test_10.csv';
    data = csvread(filename);
    
    time{index} = data(:,1);
    duty{index} = data(:,2);
    ang_speed{index} = data(:,5);

    % Test 11
    
    index = index + 1;
    filename = 'Experimental_Data\reaction_wheel_data_Test_11.csv';
    data = csvread(filename);
    
    time{index} = data(:,1);
    duty{index} = data(:,2);
    ang_speed{index} = data(:,5);

    % Test 12
    
    index = index + 1;
    filename = 'Experimental_Data\reaction_wheel_data_Test_12.csv';
    data = csvread(filename);
    
    time{index} = data(:,1);
    duty{index} = data(:,2);
    ang_speed{index} = data(:,5);

    % Test 13
    
    index = index + 1;
    filename = 'Experimental_Data\reaction_wheel_data_Test_13.csv';
    data = csvread(filename);
    
    time{index} = data(:,1);
    duty{index} = data(:,2);
    ang_speed{index} = data(:,5);

    % Test 14
    
    index = index + 1;
    filename = 'Experimental_Data\reaction_wheel_data_Test_14.csv';
    data = csvread(filename);
    
    time{index} = data(:,1);
    duty{index} = data(:,2);
    ang_speed{index} = data(:,5);

    % Test 15
    
    index = index + 1;
    filename = 'Experimental_Data\reaction_wheel_data_Test_15.csv';
    data = csvread(filename);
    
    time{index} = data(:,1);
    duty{index} = data(:,2);
    ang_speed{index} = data(:,5);

    % Test 16
    
    index = index + 1;
    filename = 'Experimental_Data\reaction_wheel_data_Test_16.csv';
    data = csvread(filename);
    
    time{index} = data(:,1);
    duty{index} = data(:,2);
    ang_speed{index} = data(:,5);

    if(plot_enable)

        blue = [0 0.4470 0.7410];
        orange = [0.8500 0.3250 0.0980];
        figure
        set(gcf,'units','centimeters','position',[0,0,15,11])
        lw = 1.5;
        for i = 1:index
            if(i<=8)
                p1 = plot(time{i},ang_speed{i},'Color',blue,'LineWidth',lw);
            end
            if((i>8) && (i<14))
                p2 = plot(time{i},ang_speed{i},'Color',orange,'LineWidth',lw);               
            end
            if(i>=14)
                p3 = plot(time{i},ang_speed{i},'k','LineWidth',lw);           
            end
            hold on
        end
        grid on
        xlabel('Time (s)','Interpreter','latex')
        ylabel('Angular Velocity ($\deg$/s)','Interpreter','latex')
        legend([p1,p2,p3],{'Acceleration','Braking ','Shutdown '},...
               'Location','southoutside','Orientation',...
               'horizontal','Interpreter','latex')
        xlim([0 20])
        saveas(gcf,'Figures/raw_angular_velocity','epsc')
    end
end