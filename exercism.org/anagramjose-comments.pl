% anagram(Word, Candidates, Anagrams). by Jose C.  with my comments
anagram(Word, Candidates, Anagrams):- 
    list_to_string_char(Candidates, CandidatesAsChars), 
    string_chars(Word, WordAsChars), 
    anagram_list(WordAsChars, CandidatesAsChars, R), 
    list_to_string_char(Anagrams, R). 
    

%% manual map(): strings to char lists
%% 1) what about memory performance / tail recursion
%% 2) I need map(data, transform) function in prolog
list_to_string_char([], []).  
list_to_string_char([H|T], [RH|R]):- 
    list_to_string_char(T, R), 
    string_chars(H, RH). 

%% char list to lowercase char list
%% using mapping high order function
lower_case_list(CharList, LowerCaseCharList):- 
    maplist(string_lower, CharList, LowerCaseCharList).

%% char lists to lowercase char lists
%% manual map, tail recursive (makes sense when using deterministic functions)
%% https://www.metalevel.at/prolog/fun
lower2([], []).
lower2([Head|Tail], [RHead|R]):- 
    lower_case_list(Head, RHead),
    lower2(Tail, R). 
    
anagram_list(_, [], []). 

% positve anagram match just by length and letter permutation
anagram_list(Word, [Head|Tail], [Head|R]):- 
    anagram_list(Word, Tail, R), 
    same_length(Head, Word), 
    permutation(Head, Word), 
    Head = Word. 
    
%positive anagram match by length and lovercase letter permutation
anagram_list(Word, [Head|Tail], [Head|R]):- 
    anagram_list(Word, Tail, R), 
    same_length(Head, Word), 
    lower_case_list(Head, RHead), 
    lower_case_list(Word, RWord), 
    permutation(RHead, RWord), 
    RHead = RWord. 

%same word is not anagram ?
anagram_list(Word, [Head|Tail], R):- 
    anagram_list(Word, Tail, R), 
    Head = Word. 

% skip head, ? (+ do not fall to other function versions?)
anagram_list(Word, [Head|Tail], R):- 
    anagram_list(Word, Tail, R), 
    + same_length(Head, Word).      % what does + means here?
    
anagram_list(Word, [Head|Tail], R):- 
    anagram_list(Word, Tail, R), 
    same_length(Head, Word), 
    + permutation(Head, Word). 
    
% ???
permutation([], []). 
permutation([Head|Tail], R2):- 
    permutation(Tail, R), 
    append(LastSkipped, LastOnly, R), 
    append(LastSkipped, [Head|LastOnly], R2).