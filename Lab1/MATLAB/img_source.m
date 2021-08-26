% Converting Image into Bitstream

Img = imread("bits_img.jfif");
Img = rgb2gray(Img);

Img_bin = dec2bin(Img);
Img_bits = reshape(Img_bin', [], 1)';



% ---- Verification ----
% image(Img)
% Img_bin(1, :)
% Img_bits(1:8)