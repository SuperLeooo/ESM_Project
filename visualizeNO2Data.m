%% Visualization of NO2 concentration over time at 5 monitoring stations
function visualizeNO2Data()
    clc;
    clear all;
    new_table = processMultipleCSVFiles();
    
    % Check if the returned table is empty
    if isempty(new_table)
        disp('No valid data to visualize.');
        return;
    end

    % Extract time and NO2 data
    time = new_table.Time;
    NO2_Landshuter_Allee = new_table.NO2_Landshuter_Allee;
    NO2_Stachus = new_table.NO2_Stachus;
    NO2_Lothstrasse = new_table.NO2_Lothstrasse;
    NO2_Allach = new_table.NO2_Allach;
    NO2_Johanneskirchen = new_table.NO2_Johanneskirchen;

    % Convert NO2 data from µg/m³ to ppb
    conversion_factor = 24.45 / 46.0055;
    NO2_Landshuter_Allee_ppb = NO2_Landshuter_Allee * conversion_factor;
    NO2_Stachus_ppb = NO2_Stachus * conversion_factor;
    NO2_Lothstrasse_ppb = NO2_Lothstrasse * conversion_factor;
    NO2_Allach_ppb = NO2_Allach * conversion_factor;
    NO2_Johanneskirchen_ppb = NO2_Johanneskirchen * conversion_factor;

    % Line plot
    figure(1);
    plot(time, NO2_Landshuter_Allee_ppb, '-r', 'DisplayName', 'Landshuter Allee');
    hold on;
    plot(time, NO2_Stachus_ppb, '-g', 'DisplayName', 'Stachus');
    plot(time, NO2_Lothstrasse_ppb, '-b', 'DisplayName', 'Lothstraße');
    plot(time, NO2_Allach_ppb, '-c', 'DisplayName', 'Allach');
    plot(time, NO2_Johanneskirchen_ppb, '-m', 'DisplayName', 'Johanneskirchen');
    hold off;

    xlabel('Time');
    ylabel('NO2 (ppb)');
    title('NO2 mixing ratios in 48 hours');
    legend('FontSize', 14);
    set(gca, 'FontSize', 14);
    legend show;
    grid on;
end
