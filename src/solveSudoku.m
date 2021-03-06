function [array,time] = solveSudoku(inputArray)

%SOLVESUDOKU Solves sudoku puzzles of any size.
%
% Input:  2-dimensional array of integers with 0's for unknown tiles
% Output: a 2-dimensional array of numbers representing the solved sudoku
%         puzzle and the time taken to solve the puzzle. Also prints
%         recursive depth to the console.
%
% Algorithm:
%  1. Initialize 2-dimensional array with known values in known tiles and
%     an array of possible numbers in unknown tiles
%  2. Eliminate any possible numbers according to Sudoku rules
%  3. Check if puzzle is solved and solvable:
%        a. If solved: return solution to User
%        b. If not solvable: notify User or eliminate guess
%  4. Tentatively guess a possible number for an unknown cell
%  5. Repeat steps 2-5 until a solution is found or shown impossible
%
% Example:
% unsolvedPuzzle =
% [5 0 3 8 1 9 0 2 0; 8 1 0 4 0 0 3 9 5; 0 4 2 0 0 0 7 8 1;
%  6 0 8 3 0 1 0 7 0; 0 0 0 0 0 0 0 0 8; 1 0 9 5 7 0 0 4 6;
%  2 0 0 0 8 0 9 5 3; 0 0 5 0 9 6 0 0 0; 4 0 0 7 0 5 8 6 2]
%
% [S, t] = solveSudoku(unsolvedPuzzle)
%
% S = 
%     5     7     3     8     1     9     6     2     4
%     8     1     6     4     2     7     3     9     5
%     9     4     2     6     5     3     7     8     1
%     6     2     8     3     4     1     5     7     9
%     7     5     4     9     6     2     1     3     8
%     1     3     9     5     7     8     2     4     6
%     2     6     7     1     8     4     9     5     3
%     3     8     5     2     9     6     4     1     7
%     4     9     1     7     3     5     8     6     2
%
% t = 
%    0.0644
%
% See also INITIALIZE, ELIMINATE, GUESS, ISSOLVABLE, ISSOLVED, 

%begin timer
tic;

%initialize the solution cell array
array = initialize(inputArray);

%run method to eliminate impossible solutions
array = eliminate(array);

%run methods to test if puzzle is solved and if it is solvable
solved = isSolved(array);
solvable = isSolvable(array);

%terminate function if it is not solvable
if solvable==false
	array = 'This puzzle is not solvable.';
	return
end

%if unsolved, pass the array on to guess method to recursively guess
%possible numbers for unknown tiles
if solved == false
    %print to console to allow user to see how deeply
    %the program has recursed
    fprintf('Down to 2\n');
	array = guess(array,2);  
end

%test if puzzle is solved and if it is solvable
solved = isSolved(array);
solvable = isSolvable(array);

%if solved, change the cell array into matrix
if solved == true
    array = cell2mat(array);
end

%end timer
time = toc;
