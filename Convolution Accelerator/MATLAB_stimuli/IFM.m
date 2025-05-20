rows = 28;
cols = 28;

% 1) Start with all zeros, uint8 type
I = zeros(rows, cols, 'uint8');

% 2) Set the central 20¡Á20 block to 1
I(5:24, 5:24) = 1;      % MATLAB is 1-based; corresponds to C indices 4¡­23

% 3) Convert every element to an 8-bit binary string (row-major order)
binStr = dec2bin(I(:), 8);   % 784¡Á8 char matrix
fileID  = fopen('IFM.txt', 'w');
binCell = cellstr(binStr);           % 784¡Á1 cell array, one 8-char string each
fprintf(fileID, '%s\n', binCell{:}); % expands to 784 calls, one per line
fclose(fileID);

disp('IFM.txt generated.');

% Reshape to 28¡Á28 and show the decimal matrix
 I = reshape(I(:), cols, rows).';
 disp('IFM:')
 disp(I);

% 5¡Á5 kernel filled with 255
A = uint8(255 * ones(5));          % 5-by-5

% ---- 2-D convolution -----------------------------------------------
OFM = conv2(double(I), double(A), 'valid');   % 24 ¡Á 24

% Show the result
disp('Output feature-map (24¡Á24) after convolution:');
disp(OFM);

% write OFM to a text file, one value per line --------
ofmID = fopen('OFM.txt','w');
fprintf(ofmID, '%d\n', OFM(:));
fclose(ofmID);
disp('OFM.txt generated.');
