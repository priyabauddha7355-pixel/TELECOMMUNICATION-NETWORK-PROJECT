clc;
clear;
close all;

% Parameters
N = 1e4; % number of bits
SNR_dB = 0:2:20; % range of SNR
BER = zeros(size(SNR_dB));

% Generate random data
data = randi([0 1], 1, N);

% BPSK Modulation
tx_signal = 2*data - 1;

for i = 1:length(SNR_dB)
    
    % Add AWGN noise
    rx_signal = awgn(tx_signal, SNR_dB(i), 'measured');
    
    % Demodulation
    rx_data = rx_signal > 0;
    
    % BER calculation
    BER(i) = sum(data ~= rx_data)/N;
end

% Plot BER vs SNR
figure;
semilogy(SNR_dB, BER, '-o');
grid on;
xlabel('SNR (dB)');
ylabel('Bit Error Rate (BER)');
title('BER vs SNR for BPSK over AWGN');
