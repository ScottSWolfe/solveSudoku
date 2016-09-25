function solvable = isSolvable(array)

%ISSOLVABLE checks if puzzle is solvable
%
% If the puzzle contains conflicts or tiles that cannot be any number,
% returns false. If there are no conflicts and all tiles still have
% possible solutions, returns true.

solvable = true;
global r c;
global height width;

%checking for any empty tiles (no possibilities left)
for i=1:r
    for j=1:c
        if length(array{i,j})==0
            solvable = false;
            return
        end
    end
end


%checking for row and column contradictions
for i=1:r
    for j=1:c
        if length(array{i,j})==1
            for k=1:c                   %checking the row
                if k~=j
                    if length(array{i,k})==1    
                        for l=1:length(array{i,j})
                            if array{i,j}(l)==array{i,k}
                                solvable = false;
                                return  
                            end
                        end
                    end
                end
            end
            for k=1:r                   %checking the column
                if k~=i
                    if length(array{k,j})==1
                        for l=1:length(array{i,j})
                            if array{i,j}(l)==array{k,j}
                                solvable = false;
                                return
                            end
                        end
                    end
                end
            end
        end
    end
end


%Checking for box contradictions
for i=1:r
    for j=1:c
        if length(array{i,j})==1
            %if i is last row in its box
            if mod(i,height)==0
                for k=i:-1:i-2
                    if k~=i
                        if mod(j,width)==0
                            for g=j:-1:j-2          %if j is last column
                                if g~=j
                                    if length(array{k,g})==1
                                        for l=1:length(array{i,j})
                                            if array{i,j}(l)==array{k,g}
                                                solvable = false;
                                                return
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            for g=(j-mod(j,width)+1):(j-mod(j,width)+1)+2 %if j is not last column in box
                                if g~=j
                                    if length(array{k,g})==1
                                        for l=1:length(array{i,j})
                                            if array{i,j}(l)==array{k,g}
                                                solvable = false;
                                                return
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            else
                    %if i is not last row in its box
                for k=(i-mod(i,height)+1):(i-mod(i,height)+1)+2
                    if k~=r
                        if mod(j,width)==0  %if j is last column in box
                            for g=j:-1:j-2
                                if g~=j
                                    if length(array{k,g})==1
                                        for l=1:length(array{i,j})
                                            if array{i,j}(l)==array{k,g}
                                                solvable = false;
                                                return
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            for g=(j-mod(j,width)+1):(j-mod(j,width)+1)+2 %if j is not last column in box
                                if g~=j
                                    if length(array{k,g})==1
                                        for l=1:length(array{i,j})
                                            if array{i,j}(l)==array{k,g}
                                                solvable = false;
                                                return
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
    