%% Read traffic data
% Extract and visualize the traffic volume data from the provided traffic table
%
clc;

data = readtable('traffic.csv', 'VariableNamingRule', 'preserve');
% Extract data for each location
LHA_data = data{1, 4:end};
LOT_data = data{2, 4:end};
STA_data = data{3, 4:end};

time = 0:23;

figure;
hold on;
grid on;

plot(time, LHA_data, 'b-o', 'LineWidth', 2, 'DisplayName', 'Landshuter Allee');
plot(time, LOT_data, 'r-o', 'LineWidth', 2, 'DisplayName', 'Lothstraße');
plot(time, STA_data, 'g-o', 'LineWidth', 2, 'DisplayName', 'Stachus');

xticks(0:1:23);
xticklabels(0:1:23);
xlabel('Time of Day (Hours)');
ylabel('Traffic Volume');
title('Hourly Traffic Volume for LHA, LOT, and STA');
legend;
legend('FontSize', 14);
set(gca, 'FontSize', 14);
hold off;
