%%% test to do:
% bpsk and 16qam with and without filter
% compare modulation schemes without filters
% compare modulations schemes with filters at all alpha
% mod_data + unfiltered (us&h) vs mod_filt at all alpha
% rx_sig vs rx_filt + unfiltered (us&h) at all alpha

M = 16; % alphabet size
b = log2(M); % bits per symbol
bits = 1e6; % no. of bits generated
sps = 8; % upsampling factor
span = 4; % filter span in symbols
beta = [0, 0.25, 0.5, 1]; % rolloff factor

EbN0 = -5:10; % Eb/N0 in dB
BER_th = berawgn(EbN0,'qam',M,'nondiff'); % theoretical BER
BER_sim = zeros(1,length(EbN0)); % array to store simulated BER but unfilitered
tx_data = randi([0,1],bits,1); % randomly generated sequence of bits
save tx_data

awgn_channel = comm.AWGNChannel('BitsPerSymbol',b); % awgn channel
calc_ber = comm.ErrorRate; % bit error rate calculation object (without filter)

% without rcos filter
for i = 1:length(EbN0)
    reset(calc_ber); % resetting BER calculation object
    awgn_channel.EbNo = EbN0(i); % updating the EbN0 value for the AWGN channel
    mod_data = qammod(tx_data, M, 'UnitAveragePower',true, 'InputType','bit'); % modulation
    rx_sig = awgn_channel(mod_data); % adding noise
    rx_data = qamdemod(rx_sig, M, 'UnitAveragePower',true, 'OutputType','bit'); % demodulation
    err_vec = calc_ber(tx_data,rx_data);
    BER_sim(i) = err_vec(1);
    %scatterplot(rx_sig)
end    

save BER_sim

% plotting BER vs EbN0
figure(i+1)
semilogy(EbN0,BER_sim,'rx-')
hold on
semilogy(EbN0,BER_th,'kx-')
title('ber vs E_b/N_0 of a simulated 16-qam system')
xlabel('E_b/N_0 (dB)')
ylabel('bit error rate')
legend('simulated unfiltered','theoretical')
grid
hold off