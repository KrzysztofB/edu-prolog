% anagram(Word, Candidates, Anagrams). 
anagram(Word, Candidates, Anagrams):- 
    list_to_string_char(Candidates, RC), 
    string_chars(Word, RW), 
    anagram_list(RW, RC, R), 
    list_to_string_char(Anagrams, R). 
    
list_to_string_char([], []). 

list_to_string_char([H|T], [RH|R]):- 
    list_to_string_char(T, R), 
    string_chars(H, RH). 
    
lower_case_list([], []). 
lower_case_list([H|T], [RH|R]):- 
    lower_case_list(T, R), 
    string_lower(H, RH). 
    
lower2([], []). 
lower2([Head|Tail], [RHead|R]):- 
    lower2(Tail, R), 
    lower_case_list(Head, RHead). 
    
anagram_list(_, [], []). 
anagram_list(Word, [Head|Tail], [Head|R]):- 
    anagram_list(Word, Tail, R), 
    same_length(Head, Word), 
    permutation(Head, Word), 
    Head = Word. 
    
anagram_list(Word, [Head|Tail], [Head|R]):- 
    anagram_list(Word, Tail, R), 
    same_length(Head, Word), 
    lower_case_list(Head, RHead), 
    lower_case_list(Word, RWord), 
    permutation(RHead, RWord), 
    RHead = RWord. 
    
anagram_list(Word, [Head|Tail], R):- 
    anagram_list(Word, Tail, R), 
    Head = Word. 
    
anagram_list(Word, [Head|Tail], R):- 
    anagram_list(Word, Tail, R), 
    + same_length(Head, Word). 
    
anagram_list(Word, [Head|Tail], R):- 
    anagram_list(Word, Tail, R), 
    same_length(Head, Word), 
    + permutation(Head, Word). 

permutation([], []). 
permutation([Head|Tail], R2):- 
    permutation(Tail, R), 
    append(L1, L2, R), 
    append(L1, [Head|L2], R2).