BER_BPSK = load('BER_BPSK.mat');
BER_QPSK = load('BER_QPSK.mat');
BER_16QAM = load('BER_16QAM.mat');
EbN0 = -5:10;

% plotting BER vs EbN0
figure
semilogy(EbN0,BER_BPSK.BER_sim,'x-')
hold on
semilogy(EbN0,BER_QPSK.BER_sim,'x-')
semilogy(EbN0,BER_16QAM.BER_sim,'x-')
title('ber vs E_b/N_0 of different modulation schemes (no filter)')
xlabel('E_b/N_0 (dB)')
ylabel('bit error rate')
legend('BPSK','QPSK/4-QAM','16-QAM')
grid
hold off