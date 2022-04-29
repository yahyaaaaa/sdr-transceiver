%%% 2.1b

M = 2; % alphabet size
b = log2(M); % bits per symbol
bits = 1000; % no. of bits generated
sps = 8; % upsampling factor
span = 4; % filter span in symbols
beta = [0, 0.25, 0.35, 0.5, 1]; % rolloff factor

EbN0 = 10; % Eb/N0 in dB
tx_data = randi([0,1],bits,1); % randomly generated sequence of bits
awgn_channel = comm.AWGNChannel('BitsPerSymbol',b); % awgn channel
mod_qpsk = comm.PSKModulator(M,0,'BitInput',true); % qpsk modulator object
demod_qpsk = comm.PSKDemodulator(M,0,'BitOutput',true); % qpsk demodulator object

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

    awgn_channel.EbNo = EbN0; % updating the EbN0 value for the AWGN channel
    mod_data = mod_qpsk(tx_data); % modulation
    mod_filt = filt_tx(mod_data); % filtering tx data
    rx_sig = awgn_channel(mod_filt); % adding noise
    rx_filt = filt_rx(rx_sig); % filtering received signal
    rx_data = demod_qpsk(rx_filt); % demodulation
    %eyediagram(mod_filt,2*sps)
    figure(j)
    freqz(mod_filt)
    ylim([-40,60])
end
