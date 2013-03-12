%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% $eph$: vowel epenthesis: burun -> burnu
%
#include "../symbols.fst"

ALPHABET = [#Ssym#] [#pos##BM##infl_feat#]\
           <Q><A> <I> [#V_Pal#] \
           <C><D><K> \
           <c><p><t><k><g> \
           <LN> \
           <dup>\
           <del>:<> [#V#]:<>

(<del>:<>) [#V#] <=> <> ([#C##C_xx#<LN>] [#pos##BM##infl_feat#]* [#V#<A><I>]) 
