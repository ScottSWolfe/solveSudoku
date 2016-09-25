function [array,status] = guess(inputArray,inLevel)

%GUESS guesses a number for an unknown tile.
%
% Guesses a number for an unknown tile and checks if the puzzle is solved
% and if the puzzle is solvable. If solved, guess returns the solved
% puzzle. If unsolvable, guess tells its calling function that the puzzle
% is unsolvable in its current state. If unsolved but still solvable, guess
% recursively passes the puzzle on to the guess method to take another
% guess.
%
% Output
%   array:   the solved puzzle
%   status:  true if puzzle is solved, false if puzzle is unsolvable

array = inputArray;
global r c;
solved = false;
solvable = true;

%continue algorithm while puzzle is not solved but still solvable
while solved == false && solvable == true

    %finding the tile with the least number of possible solutions      
    lowest = [1:r+1];
    for m=1:r
        for n=1:c
            if length(array{m,n})<length(lowest) && length(array{m,n})>1
                lowest = array{m,n};
                i = m;
                j = n;
            end
            if length(lowest)==2
                break
            end
        end
        if length(lowest)==2
            break
        end
    end
                 
    %iterate through the tile's possible solutions
    while length(array{i,j})>1
    
        %creating a test puzzle on which to take a tentative guess
        testArray=array;
    
        %taking the tentative guess
        testArray{i,j}=array{i,j}(1);
    
        %checking solution status after tentative guess
        testArray = eliminate(testArray);
        solved = isSolved(testArray);
        solvable = isSolvable(testArray);

        %if the puzzle is not solved but still solvable, recursively call the
        %guess method
        if solved==false && solvable==true
            fprintf('Down to %d\n',inLevel+1);
            [testArray,status] = guess(testArray,inLevel+1);
        
            %if guess method returns an unsolvable puzzle, eliminate the
            %previous guessed number as a solution
            if status == false
                array{i,j}(1)=[];
                continue
        
            %if guess method returns a solved puzzle, return the solved puzzle
            elseif status == true
                array = testArray;
                fprintf('Up to %d\n',inLevel-1);
                return
            end
        end
     
        %if the puzzle is not solvable, eliminate the guessed number as a
        %solution
        if solvable==false
        	array{i,j}(1)=[];
        	continue
        end
    
        %if the puzzle is solved, return the solved puzzle
        if solved == true
         	array = testArray;
         	status = true;
            fprintf('Up to %d\n',inLevel-1);
            return
        end
        
    end %end iterating through tile's possible solutions

    %checking if puzzle is still solvable after iterating through tile's
    %possible solutions; if not solvable return
    solvable = isSolvable(array);
    if solvable == false
       status = false;
       fprintf('Up to %d\n',inLevel-1);
       return
    end

end     %end solved == false && solvabe == true while loop
