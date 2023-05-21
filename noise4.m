% Step 1: Generate a noisy input signal and a reference signal
fs = 44100; % Sampling frequency
t = (0:1/fs:1)'; % Time vector
cleanSignal = sin(2*pi*1000*t); % Original clean signal
noise = 0.2*randn(size(cleanSignal)); % Gaussian noise- *LMS is used...
noisySignal = cleanSignal + noise; % Noisy input signal

% Step 2: Design an adaptive filter
filterOrder = 32; % Order of the adaptive filter
mu = 0.01; % Adaptation step size
adaptFilter = dsp.LMSFilter('Length', filterOrder, 'StepSize', mu);

% Step 3: Apply the adaptive filter to the noisy input signal
[y, err] = adaptFilter(noisySignal, cleanSignal);

% Step 4: Subtract the estimated noise from the noisy input signal
cleanOutput = noisySignal - y;

% Step 5: Evaluate the performance and analyze the output signal
snrBefore = snr(cleanSignal, noise);
snrAfter = snr(cleanSignal, cleanOutput);

disp(['SNR before noise cancellation: ', num2str(snrBefore), ' dB']);
disp(['SNR after noise cancellation: ', num2str(snrAfter), ' dB']);

% Plot the signals
figure;
subplot(3, 1, 1);
plot(t, cleanSignal);
title('Clean Signal');
subplot(3, 1, 2);
plot(t, noisySignal);
title('Noisy Input Signal');
subplot(3, 1, 3);
plot(t, cleanOutput);
title('Clean Output Signal');