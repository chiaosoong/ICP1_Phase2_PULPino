% generate_constant_binary_grid.m  (fixed)
rows = 28;
cols = 28;
numLines = rows * cols;                 % 784

% deterministic pattern: 0¡­255 repeating
data    = uint8(mod(0:numLines-1, 256));   % 784¡Á1 column

% convert to 8-bit binary (char matrix, still 784¡Á8)
binStr  = dec2bin(data, 8);

% ---- WRITE FILE, one row per line --------------------------------------
fileID  = fopen('IFM.txt', 'w');

binCell = cellstr(binStr);           % 784¡Á1 cell array, one 8-char string each
fprintf(fileID, '%s\n', binCell{:}); % expands to 784 calls, one per line
fclose(fileID);

disp('IFM.txt generated.');

% Reshape to 28¡Á28 and show the decimal matrix
I = reshape(data, cols, rows).';
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








