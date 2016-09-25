function array = initialize(inputArray)

%INITIALIZE changes the input array into a cell array
%
% Changes the input array to a cell array. The cells with 0's are changed
% to number arrays with all possible solution numbers. Also sets the global
% r (Row) and c (Column) variables and the height and width of each box.

%the number of rows and columns in this puzzle
global r c;
[r,c] = size(inputArray);

%the height and width of each box in this puzzle 
global width height;
if sqrt(length(inputArray))-round(sqrt(length(inputArray)))==0
    width=sqrt(length(inputArray));
    height=sqrt(length(inputArray));
else
    width = length(ainputArrayrray)/3;
    height = 3;
end

%changing input into a cell array and changes the 0's into arrays of
%posssible solutions
for i=1:r
    for j=1:c
        if inputArray(i,j)~=0
            array{i,j}=inputArray(i,j);     %known tiles
        else
            array{i,j} = [1:r];             %unknown tiles
        end
    end
end
