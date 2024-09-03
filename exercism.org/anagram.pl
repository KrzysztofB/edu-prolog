anagram(Word, [Word], [Word]).
anagram(Word, Candidates, Anagrams):- 
    string_length(Word, WordLen),
    string_lower(Word, WordLower),
    string_chars(WordLower, WordLetters),
    msort(WordLetters, WordLettersSorted),
	findall(X,(
		member(X, Candidates), 
		string_length(X, WordLen),
        string_lower(X, XLower),
        WordLower \== XLower,
        string_chars(XLower, XLetters),
        msort(XLetters, WordLettersSorted)
		), Anagrams).