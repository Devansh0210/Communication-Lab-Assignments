% Converting Text File into bitstream

text_file = fopen("sample_text.txt", 'r');
text = fread(text_file, 'uint8=>uint8');

text_bin = dec2bin(text);
text_bits = reshape(text_bin', [], 1)';



% ----- Verification -----
% size(text_bin)
% size(text_bits)
% text_bin(1, 1:7)
% text_bits(1:7)