#include "symbols.fst"

$half$ = yarım

$n0$ = sıfır
$n1-1$ = (iki|üç|dörd|beş|altı|yeddi|səkkiz|doqquz) $half$?
$n1$ = (bir | $n1-1$) $half$?
$n10$ = (on|iyirmi|otuz|qırx|əlli|altmış|yetmiş|səksən|doxsan)
$n100$ = yüz
$n1k$ = min
$n1m$ = milyon
$n1g$ = milyard
$n1t$ = trilyon


$N10$ = $n10$ $n1$?
$N100$ = $n1-1$? $n100$ $N10$?
$N1K$ = ($n1-1$|$N10$|$N100$)? $n1k$ ($N100$|$N10$|$n1$)?
$N1M$ = ($n1$|$N10$|$N100$)? $n1m$ ($N1K$|$N100$|$N10$|$n1$)?
$N1G$ = ($n1$|$N10$|$N100$)? $n1g$ ($N1M$|$N1K$|$N100$|$N10$|$n1$)?
$N1T$ = ($n1$|$N10$|$N100$)? $n1t$ ($N1G$|$N1M$|$N1K$|$N100$|$N10$|$n1$)?

% TODO: this is too liberal

$Num$ = [#Perc#]? [#Digit#] [#Digit##Nsep#]*

($n0$ | $n1$ | $N10$ | $N100$ | $N1K$ | $N1M$ | $N1G$ | $N1T$ )  \
| $Num$
