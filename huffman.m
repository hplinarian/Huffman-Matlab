
letters=['a','e','i','k','l','r','n','m','˝','t','s','y','d','u','o','b','˛','¸','Á','z','g','p','h','c','v','ˆ','','f','j'];

probabilities = [0.1277 0.092 0.0778 0.0718 0.064 0.0602 0.0543 0.0536 0.0424 0.0418 0.0352 0.029 0.0278 0.0267 0.0251 0.0201 0.0192 0.0174 0.0157 0.0155 0.0144 0.0135 0.011 0.0103 0.0101 0.0081 0.0078 0.0068 0.0007];

% cell array which includes empty vectors with index
% binaryletters=[][][].... 29 tane
binaryletters=cell(1,length(probabilities));
binaryletters_reversed=cell(1,length(probabilities));

% a cell array which elements of it are index of themself
% set_contents=[1][2][3]... 29 
set_contents1=(1:1:length(probabilities));
set_contents=num2cell(set_contents1);

%Store the probability associated with this set
% probability_keeper= 0.1277 0.092 ..... probabilities
%probability_keeper(index) = probabilities(index);
probability_keeper = probabilities(:);

disp('==========================================================================');


disp('The letters and their probabilities are:')
for set_index = 1:length(probability_keeper)
    disp([num2str(probability_keeper(set_index)),'    ',letters(set_index)]);
end
disp('==========================================================================');

disp('The Turkish letters with information respectively:')

information=log2(1./(probabilities));
for set_index = 1:length(probability_keeper)
    disp([num2str(information(set_index)),'    ',letters(set_index)]);
end

disp('==========================================================================');

% Calculate the symbol entropy
entropy = sum(probabilities.*log2(1./probabilities));
disp('The entropy of Turkish:')
disp(entropy)
disp('Entropy of Turkish more than entropy of English because there is more letters in Turkish ')







% Keep going until all the sets have been merged into one
while length(set_contents) > 1
    
    % Determine which sets have the lowest total probabilities
    % sorted_incices keeps numbers which represents real places of
    % probabilities, temp is a sorted list of probabilities
    [temp, sorted_indices] = sort(probability_keeper);
    

    % Get the set having the lowest probability
    % sorted_incdices(1) gives us index of lowest probability, 
    % set_contents gives us that number (index)
    lowest_set_index = set_contents{sorted_indices(1)};

    % Get lowest probability
    lowest_probability = probability_keeper(sorted_indices(1));
    
    % For binary letters with lowest probability +
    for binaryletter_index = 1:length(lowest_set_index)
        % +append a zero
        binaryletters{lowest_set_index(binaryletter_index)} = [binaryletters{lowest_set_index(binaryletter_index)}, 0]; 
        
    end
    
    % Get the set having the second lowest probability
    one_set = set_contents{sorted_indices(2)};
    % Get that probability
    one_probability = probability_keeper(sorted_indices(2));
    % For binary letters with second lowest probability +
    for binaryletter_index = 1:length(one_set)
        % +append a one
        binaryletters{one_set(binaryletter_index)} = [binaryletters{one_set(binaryletter_index)}, 1];       
    end

    
    
    % Remove the two sets having the lowest probabilities...
    set_contents(sorted_indices(1:2)) = [];
    % ...and merge them into a new set
    
    
    set_contents{length(set_contents)+1} = [lowest_set_index, one_set];
    
    % Remove the two lowest probabilities...
    probability_keeper(sorted_indices(1:2)) = [];
    % ...and give their sum to the new set
    probability_keeper(length(probability_keeper)+1) = lowest_probability + one_probability;
            
    
    
    
end

disp('==========================================================================');
disp('The letters, their probabilities and the allocated Huffman binary numbers are:');

% implementation of huffman gives us reversed order of binary numbers 
% we need to reverse them
for index = 1:length(binaryletters)
    
binaryletters_reversed{index}=fliplr(binaryletters{index});

end

% For each letter probabilities and binary response
for index = 1:length(binaryletters)
    disp([num2str(letters(index)), '    ', num2str(probabilities(index)),'    ',num2str(binaryletters_reversed{index})]);
end

disp('==========================================================================');


disp('A source coding mapping for the Turkish alphabet.')

for set_index = 1:length(letters)
    fixedbinaries=dec2bin(set_index,5);
    disp([letters(set_index),'    ',num2str(fixedbinaries)]);
end

disp('==========================================================================');

disp('The expected length of bits for the code developed');

binaryletterslength=[];
for index = 1:length(binaryletters)
    binaryletterslength=[binaryletterslength,length(binaryletters_reversed{index})];
    
end
disp(sum(probabilities.*binaryletterslength));
disp('Its more than entropy with 0,272 difference')

%veri yazmay˝ ve almay˝ ˆren

