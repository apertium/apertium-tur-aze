
#include "../symbols.fst"

#Non_V# = #C##pos##Apos##infl_feat#<>#BM#


ALPHABET = [#Ssym#] [#pos##BM##infl_feat#]\
           <Q>:<x> <Q>:<k> <A> <I> [#V_Pal#] \
           <C><D><K> \
           <c><p><t><k><g><x> \
           <LN> \
           <dup>
           
$CH_Qk$ = (.:[#V_b#]  [#Non_V#]*) <Q> <=> <x>


$CH_Qk$


