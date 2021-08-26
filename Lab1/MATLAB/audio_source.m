% Converting Audio Signal into Bitstream

[sample_audio, Fs] = audioread("sample_audio.wav");


% Using only Left Channel Audio Samples
L_ch = sample_audio(1:end, 1);

audio_bin = dec2bin(L_ch); % Converting decimal numbers to 8 bit bin number
audio_bits = reshape(audio_bin', [], 1)'; % bits represented as char array of '0' and '1'

% ----- Verification -----
% size(audio_bits)
% audio_bin(1, 1:end)
% audio_bits(1:8)
% sound(L_ch, Fs);