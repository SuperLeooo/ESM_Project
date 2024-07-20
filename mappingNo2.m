%% Read NO2 data and plot with Munich Map
clc;
clear;
allach = readtable('./NO2Database/Allach.csv','ReadVariableNames', false, 'Delimiter', ';');
johann = readtable('./NO2Database/Johanneskirchen.csv','ReadVariableNames', false, 'Delimiter', ';');
landshuter = readtable('./NO2Database/Landshuter Allee.csv','ReadVariableNames', false, 'Delimiter', ';');
loths = readtable('./NO2Database/Lothstrasse.csv','ReadVariableNames', false, 'Delimiter', ';');
stachus = readtable('./NO2Database/Stachus.csv','ReadVariableNames', false, 'Delimiter', ';'); 

% Assuming a temperature of 298 K and a pressure of 1013 hPa
% 1 ppb = (μg/m^3 * 24.45) / (46.0055) for NO2
conversion_factor = 24.45 / 46.0055;
allach{:, 3} = allach{:, 3} * conversion_factor;
johann{:, 3} = johann{:, 3} * conversion_factor;
landshuter{:, 3} = landshuter{:, 3} * conversion_factor;
loths{:, 3} = loths{:, 3} * conversion_factor;
stachus{:, 3} = stachus{:, 3} * conversion_factor;

% Calculate the average concentration for each station
average_allach = mean(allach{:, 3});
average_johann = mean(johann{:, 3});
average_landshuter = mean(landshuter{:, 3});
average_loths = mean(loths{:, 3});
average_stachus = mean(stachus{:, 3});

% Store the averages in a vector
average_concentrations = [
    average_allach, 
    average_johann, 
    average_landshuter, 
    average_loths, 
    average_stachus
];


% Define the coordinates of the five stations 
station_coords = [
    2, 16;
    15, 14;
    7, 12;
    8, 13;
    9, 11
];

% Define the grid
[x, y] = meshgrid(1:20, 1:20);

% Apply IDW interpolation
interpolated_concentration = idw_interpolation(x, y, station_coords, average_concentrations);

% Function to calculate IDW interpolation
function c = idw_interpolation(x, y, station_coords, concentrations)
    num_stations = size(station_coords, 1);
    weights = zeros(size(x));
    c = zeros(size(x));
    for i = 1:num_stations
        d = sqrt((x - station_coords(i, 1)).^2 + (y - station_coords(i, 2)).^2);
        d(d == 0) = 1e-6; % Avoid division by zero
        w = 1 ./ d;
        weights = weights + w;
        c = c + w * concentrations(i);
    end
    c = c ./ weights;
end

DisplayMunichMap






