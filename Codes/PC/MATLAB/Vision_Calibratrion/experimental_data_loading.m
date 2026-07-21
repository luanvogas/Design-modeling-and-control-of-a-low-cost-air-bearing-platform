function [x,y,angles] = experimental_data_loading()

    filename = 'Experimental_Data\calibration_check_1.csv';
    data = csvread(filename);
    
    x{1} = data(1:end-1,2);
    y{1} = data(1:end-1,3);
    angles{1} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_2.csv';
    data = csvread(filename);
    
    x{2} = data(1:end-1,2);
    y{2} = data(1:end-1,3);
    angles{2} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_3.csv';
    data = csvread(filename);
    
    x{3} = data(1:end-1,2);
    y{3} = data(1:end-1,3);
    angles{3} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_4.csv';
    data = csvread(filename);
    
    x{4} = data(1:end-1,2);
    y{4} = data(1:end-1,3);
    angles{4} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_5.csv';
    data = csvread(filename);
    
    x{5} = data(1:end-1,2);
    y{5} = data(1:end-1,3);
    angles{5} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_6.csv';
    data = csvread(filename);
    
    x{6} = data(1:end-1,2);
    y{6} = data(1:end-1,3);
    angles{6} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_7.csv';
    data = csvread(filename);
    
    x{7} = data(1:end-1,2);
    y{7} = data(1:end-1,3);
    angles{7} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_8.csv';
    data = csvread(filename);
    
    x{8} = data(1:end-1,2);
    y{8} = data(1:end-1,3);
    angles{8} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_9.csv';
    data = csvread(filename);
    
    x{9} = data(1:end-1,2);
    y{9} = data(1:end-1,3);
    angles{9} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_10.csv';
    data = csvread(filename);
    
    x{10} = data(1:end-1,2);
    y{10} = data(1:end-1,3);
    angles{10} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_11.csv';
    data = csvread(filename);
    
    x{11} = data(1:end-1,2);
    y{11} = data(1:end-1,3);
    angles{11} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_12.csv';
    data = csvread(filename);
    
    x{12} = data(1:end-1,2);
    y{12} = data(1:end-1,3);
    angles{12} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_13.csv';
    data = csvread(filename);
    
    x{13} = data(1:end-1,2);
    y{13} = data(1:end-1,3);
    angles{13} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_14.csv';
    data = csvread(filename);
    
    x{14} = data(1:end-1,2);
    y{14} = data(1:end-1,3);
    angles{14} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_15.csv';
    data = csvread(filename);
    
    x{15} = data(1:end-1,2);
    y{15} = data(1:end-1,3);
    angles{15} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_16.csv';
    data = csvread(filename);
    
    x{16} = data(1:end-1,2);
    y{16} = data(1:end-1,3);
    angles{16} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_17.csv';
    data = csvread(filename);
    
    x{17} = data(1:end-1,2);
    y{17} = data(1:end-1,3);
    angles{17} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_18.csv';
    data = csvread(filename);
    
    x{18} = data(1:end-1,2);
    y{18} = data(1:end-1,3);
    angles{18} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_19.csv';
    data = csvread(filename);
    
    x{19} = data(1:end-1,2);
    y{19} = data(1:end-1,3);
    angles{19} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_20.csv';
    data = csvread(filename);
    
    x{20} = data(1:end-1,2);
    y{20} = data(1:end-1,3);
    angles{20} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_21.csv';
    data = csvread(filename);
    
    x{21} = data(1:end-1,2);
    y{21} = data(1:end-1,3);
    angles{21} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_22.csv';
    data = csvread(filename);
    
    x{22} = data(1:end-1,2);
    y{22} = data(1:end-1,3);
    angles{22} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_23.csv';
    data = csvread(filename);
    
    x{23} = data(1:end-1,2);
    y{23} = data(1:end-1,3);
    angles{23} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_24.csv';
    data = csvread(filename);
    
    x{24} = data(1:end-1,2);
    y{24} = data(1:end-1,3);
    angles{24} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_25.csv';
    data = csvread(filename);
    
    x{25} = data(1:end-1,2);
    y{25} = data(1:end-1,3);
    angles{25} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_26.csv';
    data = csvread(filename);
    
    x{26} = data(1:end-1,2);
    y{26} = data(1:end-1,3);
    angles{26} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_27.csv';
    data = csvread(filename);
    
    x{27} = data(1:end-1,2);
    y{27} = data(1:end-1,3);
    angles{27} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_28.csv';
    data = csvread(filename);
    
    x{28} = data(1:end-1,2);
    y{28} = data(1:end-1,3);
    angles{28} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_29.csv';
    data = csvread(filename);
    
    x{29} = data(1:end-1,2);
    y{29} = data(1:end-1,3);
    angles{29} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_30.csv';
    data = csvread(filename);
    
    x{30} = data(1:end-1,2);
    y{30} = data(1:end-1,3);
    angles{30} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_31.csv';
    data = csvread(filename);
    
    x{31} = data(1:end-1,2);
    y{31} = data(1:end-1,3);
    angles{31} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_32.csv';
    data = csvread(filename);
    
    x{32} = data(1:end-1,2);
    y{32} = data(1:end-1,3);
    angles{32} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_33.csv';
    data = csvread(filename);
    
    x{33} = data(1:end-1,2);
    y{33} = data(1:end-1,3);
    angles{33} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_34.csv';
    data = csvread(filename);
    
    x{34} = data(1:end-1,2);
    y{34} = data(1:end-1,3);
    angles{34} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_35.csv';
    data = csvread(filename);
    
    x{35} = data(1:end-1,2);
    y{35} = data(1:end-1,3);
    angles{35} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_36.csv';
    data = csvread(filename);
    
    x{36} = data(1:end-1,2);
    y{36} = data(1:end-1,3);
    angles{36} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_37.csv';
    data = csvread(filename);
    
    x{37} = data(1:end-1,2);
    y{37} = data(1:end-1,3);
    angles{37} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_38.csv';
    data = csvread(filename);
    
    x{38} = data(1:end-1,2);
    y{38} = data(1:end-1,3);
    angles{38} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_39.csv';
    data = csvread(filename);
    
    x{39} = data(1:end-1,2);
    y{39} = data(1:end-1,3);
    angles{39} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_40.csv';
    data = csvread(filename);
    
    x{40} = data(1:end-1,2);
    y{40} = data(1:end-1,3);
    angles{40} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_41.csv';
    data = csvread(filename);
    
    x{41} = data(1:end-1,2);
    y{41} = data(1:end-1,3);
    angles{41} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_42.csv';
    data = csvread(filename);
    
    x{42} = data(1:end-1,2);
    y{42} = data(1:end-1,3);
    angles{42} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_43.csv';
    data = csvread(filename);
    
    x{43} = data(1:end-1,2);
    y{43} = data(1:end-1,3);
    angles{43} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_44.csv';
    data = csvread(filename);
    
    x{44} = data(1:end-1,2);
    y{44} = data(1:end-1,3);
    angles{44} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_45.csv';
    data = csvread(filename);
    
    x{45} = data(1:end-1,2);
    y{45} = data(1:end-1,3);
    angles{45} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_46.csv';
    data = csvread(filename);
    
    x{46} = data(1:end-1,2);
    y{46} = data(1:end-1,3);
    angles{46} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_47.csv';
    data = csvread(filename);
    
    x{47} = data(1:end-1,2);
    y{47} = data(1:end-1,3);
    angles{47} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_48.csv';
    data = csvread(filename);
    
    x{48} = data(1:end-1,2);
    y{48} = data(1:end-1,3);
    angles{48} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_49.csv';
    data = csvread(filename);
    
    x{49} = data(1:end-1,2);
    y{49} = data(1:end-1,3);
    angles{49} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_50.csv';
    data = csvread(filename);
    
    x{50} = data(1:end-1,2);
    y{50} = data(1:end-1,3);
    angles{50} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_51.csv';
    data = csvread(filename);
    
    x{51} = data(1:end-1,2);
    y{51} = data(1:end-1,3);
    angles{51} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_52.csv';
    data = csvread(filename);
    
    x{52} = data(1:end-1,2);
    y{52} = data(1:end-1,3);
    angles{52} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_53.csv';
    data = csvread(filename);
    
    x{53} = data(1:end-1,2);
    y{53} = data(1:end-1,3);
    angles{53} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_54.csv';
    data = csvread(filename);
    
    x{54} = data(1:end-1,2);
    y{54} = data(1:end-1,3);
    angles{54} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_55.csv';
    data = csvread(filename);
    
    x{55} = data(1:end-1,2);
    y{55} = data(1:end-1,3);
    angles{55} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_56.csv';
    data = csvread(filename);
    
    x{56} = data(1:end-1,2);
    y{56} = data(1:end-1,3);
    angles{56} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_57.csv';
    data = csvread(filename);
    
    x{57} = data(1:end-1,2);
    y{57} = data(1:end-1,3);
    angles{57} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_58.csv';
    data = csvread(filename);
    
    x{58} = data(1:end-1,2);
    y{58} = data(1:end-1,3);
    angles{58} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_59.csv';
    data = csvread(filename);
    
    x{59} = data(1:end-1,2);
    y{59} = data(1:end-1,3);
    angles{59} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_60.csv';
    data = csvread(filename);
    
    x{60} = data(1:end-1,2);
    y{60} = data(1:end-1,3);
    angles{60} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_61.csv';
    data = csvread(filename);
    
    x{61} = data(1:end-1,2);
    y{61} = data(1:end-1,3);
    angles{61} = data(1:end-1,4);

    filename = 'Experimental_Data\calibration_check_62.csv';
    data = csvread(filename);
    
    x{62} = data(1:end-1,2);
    y{62} = data(1:end-1,3);
    angles{62} = data(1:end-1,4);
    
    filename = 'Experimental_Data\calibration_check_63.csv';
    data = csvread(filename);
    
    x{63} = data(1:end-1,2);
    y{63} = data(1:end-1,3);
    angles{63} = data(1:end-1,4);

end
