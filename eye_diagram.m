M = 16; % alphabet size
b = log2(M); % bits per symbol
bits = 1000; % no. of bits generated
sps = 8; % upsampling factor
span = 4; % filter span in symbols
beta = [0, 0.25, 0.35, 0.5, 1]; % rolloff factor

EbN0 = 10; % Eb/N0 in dB
tx_data = randi([0,1],bits,1); % randomly generated sequence of bits
awgn_channel = comm.AWGNChannel('BitsPerSymbol',b); % awgn channel
freq = linspace(0,1,1000);

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

    awgn_channel.EbNo = EbN0; % updating the EbN0 value for the AWGN channel
    mod_data = qammod(tx_data, M, 'UnitAveragePower',true, 'InputType','bit'); % modulation
    mod_filt = filt_tx(mod_data); % filtering tx data
    rx_sig = awgn_channel(mod_filt); % adding noise
    rx_filt = filt_rx(rx_sig); % filtering received signal
    rx_data = qamdemod(rx_filt, M, 'UnitAveragePower',true, 'OutputType','bit'); % demodulation
    %scatterplot(rx_sig)
    %scatterplot(rx_filt)
    %eyediagram(mod_filt,2*sps)
    figure(j)
    freqz(mod_filt)
    ylim([-40,60])
end