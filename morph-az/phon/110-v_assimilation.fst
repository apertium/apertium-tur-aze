%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% $VA$ Voicing assimilation rules
%
% seker-ci 
% sarap-çı
%
% affected analysis sym: <D> (and later <C>)
% interacts with: $FSD$ (needs to be after)
#include "../symbols.fst"

ALPHABET = [#Ssym#] [#pos##infl_feat#] [#BM#]\
           <k><Q><A> <I> [#V_Pal#] \
           <LN> \
           <D>:d <D>:d <C>:c <C>:c

$VA_Dt$ = (.:[#C_uv#] .:[#C##Apos##pos#<>#BM##infl_feat#]*) <D> <=> d
$VA_Cc$ = (.:[#C_uv#] .:[#C##Apos##pos#<>#BM##infl_feat#]*) <C> <=> c

$VA_Dt$ & $VA_Cc$

