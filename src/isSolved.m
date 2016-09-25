function solved = isSolved(inputArray)

%ISSOLVED checks if puzzle is solved
%
% If the puzzle is solved, returns true. If the puzzle is not solved,
% returns false.

solved = true;
global r c;

%checking if each tile only has one solution number. If not, the puzzle is
%not yet solved.
for i=1:r
    for j=1:c
        if length(inputArray{i,j})~=1
            solved = false;
            return
        end
    end
end
