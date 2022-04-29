%%% 2.1b

M = 16; % alphabet size
b = log2(M); % bits per symbol
bits = 1e6; % no. of bits generated
sps = 8; % upsampling factor
span = 4; % filter span in symbols
beta = [0, 0.25, 0.35, 0.5, 1]; % rolloff factor

EbN0 = -5:10; % Eb/N0 in dB
BER_sim_filt = zeros(1,length(EbN0)); % array to store simulated BER (with filter)
tx_data = load('tx_data.mat'); % randomly generated sequence of bits

awgn_channel = comm.AWGNChannel('BitsPerSymbol',b); % awgn channel
calc_ber = comm.ErrorRate('ReceiveDelay',sps*2); % bit error rate calculation object

% with rcos filter
for j = 1:length(beta)
    
    % rrc tx filter
    filt_tx = comm.RaisedCosineTransmitFilter('Shape','Square root',...
                                              'RolloffFactor',beta(j),...
                                              'FilterSpanInSymbols',span,...
                                              'OutputSamplesPerSymbol',sps);

    % rrc rx filter
    filt_rx = comm.RaisedCosineReceiveFilter('Shape','Square root',...
                                              'RolloffFactor',beta(j),...
                                              'FilterSpanInSymbols',span,...
                                              'InputSamplesPerSymbol',sps,...
                                              'DecimationFactor',sps);

    for i = 1:length(EbN0)
        reset(calc_ber); % resetting BER calculation object
        awgn_channel.EbNo = EbN0(i); % updating the EbN0 value for the AWGN channel
        mod_data = qammod(tx_data, M, 'UnitAveragePower',true, 'InputType','bit'); % modulation
        mod_filt = filt_tx(mod_data); % filtering tx data
        rx_sig = awgn_channel(mod_filt); % adding noise
        rx_filt = filt_rx(rx_sig); % filtering received signal
        rx_data = qamdemod(rx_filt, M, 'UnitAveragePower',true, 'OutputType','bit'); % demodulation
        err_vec = calc_ber(tx_data,rx_data); % getting BER
        BER_sim_filt(j,i) = err_vec(1); % storing BER in vector for plotting
    end
    %scatterplot(rx_sig)
    %scatterplot(rx_filt)
    eyediagram(rx_filt,2*sps)
end

% plotting BER vs EbN0
% figure
% colors = {'#0072BD','#D95319','#EDB120','#7E2F8E','#77AC30'};
% semilogy(EbN0,BER_sim_filt(1,:),'x-','Color','b')
% hold on
% for i = 2:length(beta)
%     semilogy(EbN0,BER_sim_filt(i,:),'x-','Color',colors{i})
% end
% semilogy(EbN0,BER_sim,'rx-')
% semilogy(EbN0,BER_th,'kx-')
% title('ber vs E_b/N_0 of a simulated 16-qam system with filter')
% xlabel('E_b/N_0 (dB)')
% ylabel('bit error rate')
% legend('simulated (\alpha = 0)','simulated (\alpha = 0.25)','simulated (\alpha = 0.35)','simulated (\alpha = 0.5)','simulated (\alpha = 1)','simulated unfiltered','theoretical')
% grid
% hold off