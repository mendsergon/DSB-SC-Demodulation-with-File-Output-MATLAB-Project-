% DSB-SC Demodulation with File Output
% Read the modulated signal
[s, fs] = audioread('dsbmix.wav');

% Time vector
t = (0:length(s)-1)' / fs;

% Candidate frequencies (10-14 kHz)
fc_candidates = 10000:1:14000;

% Candidate phases (excluding 0 based on your observation)
theta_candidates = [pi/4, pi/2, 3*pi/4, pi];

% Design low-pass filter for message recovery (4 kHz cutoff)
fc_cutoff = 4000;
[b, a] = butter(6, fc_cutoff/(fs/2));

max_Ey = -1;
best_fc = 0;
best_theta = 0;
best_audio = [];

% Create output file
fid = fopen('demodulation_results.txt', 'w');
fprintf(fid, 'DSB-SC Demodulation Search Results\n');
fprintf(fid, '==================================\n\n');
fprintf('Searching for optimal carrier parameters...\n');
fprintf('Progress will be saved to demodulation_results.txt\n\n');

for i = 1:length(fc_candidates)
    fc = fc_candidates(i);
    
    for j = 1:length(theta_candidates)
        theta = theta_candidates(j);
        
        % Generate carrier
        carrier = cos(2*pi*fc*t + theta);
        
        % Demodulate by mixing
        y_demod = s .* carrier;
        
        % LOW-PASS FILTER before energy calculation
        y_filtered = filter(b, a, y_demod);
        
        % Calculate energy of filtered signal
        Ey = sum(y_filtered.^2);
        
        if Ey > max_Ey
            max_Ey = Ey;
            best_fc = fc;
            best_theta = theta;
            best_audio = y_filtered;
            
            % Write only significant improvements to file
            fprintf(fid, 'New optimum: fc=%.1f Hz, theta=%.4f rad, Ey=%.4f\n', ...
                    best_fc, best_theta, max_Ey);
        end
    end
    
    % Progress indicator to console only (not file)
    if mod(i, 500) == 0
        progress = (i/length(fc_candidates))*100;
        fprintf('Progress: %.1f%% (Current best: fc=%.1f Hz, theta=%.4f rad, Ey=%.4f)\n', ...
                progress, best_fc, best_theta, max_Ey);
    end
end

% Close the file
fclose(fid);

% Normalize and save the best recovered audio
best_audio = best_audio / max(abs(best_audio));
audiowrite('recovered_message.wav', best_audio, fs);

% Final results to console
fprintf('\n=== FINAL RESULTS ===\n');
fprintf('Maximum energy Ey: %.6f\n', max_Ey);
fprintf('Optimal carrier frequency fc: %.2f Hz\n', best_fc);
fprintf('Optimal phase θ: %.4f rad (%.2f°)\n', best_theta, best_theta*180/pi);
fprintf('Detailed search results saved to: demodulation_results.txt\n');

% Write final results to file as well
fid = fopen('demodulation_results.txt', 'a');
fprintf(fid, '\n=== FINAL RESULTS ===\n');
fprintf(fid, 'Maximum energy Ey: %.6f\n', max_Ey);
fprintf(fid, 'Optimal carrier frequency fc: %.2f Hz\n', best_fc);
fprintf(fid, 'Optimal phase θ: %.4f rad (%.2f°)\n', best_theta, best_theta*180/pi);
fclose(fid);

% Optional: Play the recovered audio (commented out to avoid errors)
% fprintf('Playing recovered audio...\n');
% sound(best_audio, fs);
% pause(2);