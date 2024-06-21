%% 5个检测站NO2浓度与时间关系的可视化
function visualizeNO2Data()
    new_table = processMultipleCSVFiles();
    
    % 检查返回的表格是否为空
    if isempty(new_table)
        disp('No valid data to visualize.');
        return;
    end

    % 提取时间和NO2数据
    time = new_table.Time;
    NO2_Landshuter_Allee = new_table.NO2_Landshuter_Allee;
    NO2_Stachus = new_table.NO2_Stachus;
    NO2_Lothstrasse = new_table.NO2_Lothstrasse;
    NO2_Allach = new_table.NO2_Allach;
    NO2_Johanneskirchen = new_table.NO2_Johanneskirchen;

    % 转换NO2数据从µg/m³到ppb
    conversion_factor = 24.45 / 46.0055;
    NO2_Landshuter_Allee_ppb = NO2_Landshuter_Allee * conversion_factor;
    NO2_Stachus_ppb = NO2_Stachus * conversion_factor;
    NO2_Lothstrasse_ppb = NO2_Lothstrasse * conversion_factor;
    NO2_Allach_ppb = NO2_Allach * conversion_factor;
    NO2_Johanneskirchen_ppb = NO2_Johanneskirchen * conversion_factor;

    % 折线图
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
    title('NO2 mixing ratios in the last 48 hours');
    legend show;
    grid on;

    % 柱状图
    figure(2);
    bar(time, [NO2_Landshuter_Allee_ppb, NO2_Stachus_ppb, NO2_Lothstrasse_ppb, NO2_Allach_ppb, NO2_Johanneskirchen_ppb]);
    xlabel('Time');
    ylabel('NO2 (ppb)');
    title('NO2 mixing ratios in the last 48 hours');
    legend({'Landshuter Allee', 'Stachus', 'Lothstraße', 'Allach', 'Johanneskirchen'});
    grid on;
end