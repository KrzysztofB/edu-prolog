
%% find anagrams:
%% - ignore case
%% - same word is not an anagram
%% anagram(InputWord, AnagramCandidates, ResultAnagrams)
anagram(Word, Candidates, Anagrams):- 
    string_length(Word, WordLen),           % precalculation of length
    string_lower(Word, WordLower),          
    string_chars(WordLower, WordLetters),   
    msort(WordLetters, WordLettersSorted),  % sorted letters of lowercased word
    findall(X,(
        member(X, Candidates),              % get next candidate X
        string_length(X, WordLen),          % candidate length must match word length
        string_lower(X, XLower),            
        WordLower \== XLower,               % make sure its not the same word ignoring case
        string_chars(XLower, XLetters),
        msort(XLetters, WordLettersSorted)  % same sorted list of letters, so X is an anagram
    ), Anagrams).