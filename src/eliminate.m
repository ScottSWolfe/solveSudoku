function array = eliminate(inputArray)

%ELIMINATE eliminates possibile numbers in unknown tiles.
%
% Eliminates possible numbers in unknown tiles by checking each unknown
% tile's row, column, and box for a matching known number. Also attempts to
% deduce only possible number for each tile by checking if the tile is the
% only tile in its row, column, and box to contain a number as a possilbe
% solution.

array = inputArray;
change = true;          %tracks if progress has been made
global r c;             %the number of rows and columns
global height width;    %the height and width of each box

%continue running algorithm while progress is being made
while change == true
change = false;
    
%Checking the Rows and Columns to eliminate possibilities
for i=1:r
    for j=1:c
        if length(array{i,j})>1
            for k=1:c                   %checking the row
                if k~=j
                    if length(array{i,k})==1    
                        for l=1:length(array{i,j})
                            if array{i,j}(l)==array{i,k}
                                array{i,j}(l)=[];
                                change = true;
                                break;  
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
                                array{i,j}(l)=[];
                                change = true;
                                break;
                            end
                        end
                    end
                end
            end
        end
    end
end


%Checking the box to eliminate possibilities
for i=1:r
    for j=1:c
        if length(array{i,j})>1
            %if i is last row in its box
            if mod(i,height)==0
                for k=i:-1:i-height+1
                     
                        if mod(j,width)==0
                            for g=j:-1:j-width+1          %if j is last column
                                if ~(k==i && g==j)
                                    if length(array{k,g})==1
                                        for l=1:length(array{i,j})
                                            if array{i,j}(l)==array{k,g}
                                                array{i,j}(l)=[];
                                                change = true;
                                                break;
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            for g=(j-mod(j,width)+1):(j-mod(j,width)+1)+width-1  %if j is not last column in box
                                if ~(k==i && g==j)
                                    if length(array{k,g})==1
                                        for l=1:length(array{i,j})
                                            if array{i,j}(l)==array{k,g}
                                                array{i,j}(l)=[];
                                                change = true;
                                                break;
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    
                end
            else
                    %if i is not last row in its box
                for k=(i-mod(i,height)+1):(i-mod(i,height)+1)+height-1
                    
                        if mod(j,width)==0  %if j is last column in box
                            for g=j:-1:j-width+1
                                if ~(k==i && g==j)
                                    if length(array{k,g})==1
                                        for l=1:length(array{i,j})
                                            if array{i,j}(l)==array{k,g}
                                                array{i,j}(l)=[];
                                                change = true;
                                                break;
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            for g=(j-mod(j,width)+1):(j-mod(j,width)+1)+width-1 %if j is not last column in box
                                if ~(k==i && g==j)
                                    if length(array{k,g})==1
                                        for l=1:length(array{i,j})
                                            if array{i,j}(l)==array{k,g}
                                                array{i,j}(l)=[];
                                                change = true;
                                                break;
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


%Finding tiles that have be a specific number

%Checking the Rows and Columns to deduce number
for i=1:r
    for j=1:c
        if length(array{i,j})>1
            for z=1:length(array{i,j})           %checking each possibility
                for k=1:c                   %checking the row
                    isZ = false;
                    if k~=j
                        for l=1:length(array{i,k})
                            if array{i,k}(l)==array{i,j}(z)
                                isZ = true;
                                break
                            end
                        end
                    end
                    if isZ == true
                        break
                    end
                end
                if isZ == false
                    array{i,j}=array{i,j}(z);
                    change = true;
                    break
                end
                for k=1:r                   %checking the column
                    isZ = false;
                    if k~=i
                        for l=1:length(array{k,j})
                            if array{k,j}(l)==array{i,j}(z)
                                isZ = true;
                                break
                            end
                        end
                    end
                    if isZ == true
                        break
                    end
                end
                if isZ == false
                    array{i,j}=array{i,j}(z);
                    change = true;
                    break
                end
            end
        end
    end
end



%Checking the box to deduce number
for i=1:r
    %cycling over through the columns
    for j=1:c
        %only if the current tile has not been solved (more than one possiblity remaining)
        if length(array{i,j})>1
            %cycling through the remaining possibilities for current tile
            for z=1:length(array{i,j})
                isZ=false;
                
                %if current tile is last row in its box
                if mod(i,height)==0
                    %cycling through rows in the box
                    for k=i:-1:i-height+1
                        %if current column is last column in its box
                    	if mod(j,width)==0
                            %cycling through columns in its box
                        	for g=j:-1:j-width+1
                                %making sure not to compare to current tile
                            	if ~(k==i && g==j)
                                    %cycling through possibilities of comparing tile
                                	for l=1:length(array{k,g})
                                        %checking if tile being compared
                                        %has same number as current possibility
                                    	if array{k,g}(l)==array{i,j}(z)
                                        	isZ = true; %if comparing tile possibility matches z, then it's not solution
                                            break;
                                        end
                                    %ending cycle through possiblities of comparing tile    
                                    end
                                %end if ~(k==i && g==j)  
                                end
                                if isZ==true
                                	break;
                                end
                            end
                        %if j is not last column in box    
                        else
                        	for g=(j-mod(j,width)+1):(j-mod(j,width)+1)+width-1 
                            	if ~(k==i && g==j)
                                	for l=1:length(array{k,g})
                                    	if array{k,g}(l)==array{i,j}(z)
                                        	isZ = true;
                                        	break;
                                        end
                                    end
                                end
                                if isZ==true
                                    break;
                                end
                            end
                        end
                        if isZ==true
                            break;
                        end
                    end
                    
                    
                    
                %if i is not last row in its box    
                else
                    for k=(i-mod(i,height)+1):(i-mod(i,height)+1)+height-1
                        %if current column is last column in its box
                    	if mod(j,width)==0
                            %cycling through columns in its box
                        	for g=j:-1:j-width+1
                                %making sure not to compare to current tile
                            	if ~(k==i && g==j)
                                    %cycling through possibilities of comparing tile
                                	for l=1:length(array{k,g})
                                        %checking if tile being compared
                                        %has same number as current possibility
                                    	if array{k,g}(l)==array{i,j}(z)
                                        	isZ = true; %if comparing tile possibility matches z, then it's not solution
                                            break;
                                        end
                                    %ending cycle through possiblities of comparing tile    
                                    end
                                %end if ~(k==i && g==j)  
                                end
                                if isZ==true
                                	break;
                                end
                            end
                        %if j is not last column in box    
                        else
                        	for g=(j-mod(j,width)+1):(j-mod(j,width)+1)+width-1 
                            	if ~(k==i && g==j)
                                	for l=1:length(array{k,g})
                                    	if array{k,g}(l)==array{i,j}(z)
                                        	isZ = true;
                                        	break;
                                        end
                                    end
                                end
                                if isZ==true
                                    break;
                                end
                            end
                        end
                        if isZ==true
                            break;
                        end
                    end
                end
                if isZ==false
                	array{i,j}=array{i,j}(z);
                    break;
                end
                
            end         %end z=1:length(i,j)
        end         %end if length{i,j}>1
    end         %end j=1:c
end        %end i=1:r       

end     %ending the while loop
