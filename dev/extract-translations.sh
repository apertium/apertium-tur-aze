CORP=/home/fran/corpora/turkish/tr.crp

#188474
echo "" > /tmp/tr.crp.orig
echo "" > /tmp/tr.crp.trans
LINES=`cat $CORP  |wc -l`;

seq 1 $LINES > /tmp/tr.lines
cat $CORP | tee /tmp/tr.crp.orig | apertium -d ../ tr-az > /tmp/tr.crp.trans
paste /tmp/tr.lines /tmp/tr.crp.orig /tmp/tr.lines /tmp/tr.crp.trans | sed 's/$/\n/g' | sed 's/\t/\n/2' > /tmp/tr-az.TESTS
cat /tmp/tr-az.TESTS
