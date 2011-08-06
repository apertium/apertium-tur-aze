#!/usr/bin/python
# coding=utf-8
# -*- encoding: utf-8 -*-

###############################################################################
## Dictionary trimming script for TRmorph style transducers
###############################################################################

import sys, codecs, copy, commands;

sys.stdin  = codecs.getreader('utf-8')(sys.stdin);
sys.stdout = codecs.getwriter('utf-8')(sys.stdout);
sys.stderr = codecs.getwriter('utf-8')(sys.stderr);

LTEXPAND = 'lt-expand';

# Relationship between tag in the bilingual dictionary and 
# lexicon file in the morphological transducer.
lexica = {
	'<adj>': 'adjectives',
	'<adv>': 'adverbs',
	'<cnjadv>': 'cnjadv',
	'<cnjcoo>': 'cnjcoo',
	'<cnjsub>': 'cnjsub',
	'<det>': 'det',
	'<ij>': 'interjections',
	'<n>': 'nouns',
	'<postp>': 'postpositions',
	'<prn>': 'pronouns',
	'<np>': 'proper_nouns',
	'<v>': 'verbs'
	#'': 'misc',
};

if len(sys.argv) < 4: #{
	print 'update.py <bidix> <trmorph dir> <azmorph dir>';
	sys.exit(-1);
#}

bidix = sys.argv[1];	# An apertium bilingual dictionary
trmorph = sys.argv[2];	# Directory of TRmorph
azmorph = sys.argv[3];	# Directory of AZmorph

trlexpath = trmorph + '/lexicon/';	# Path to the lexicon files
azlexpath = azmorph + '/lexicon/';	# Path to the lexicon files

troutpath = './morph-tr/lexicon/';	# Output path
azoutpath = './morph-az/lexicon/';	# Output path

for pos in lexica: #{

	# Remove all existing entries from the trimmed lexica
	cmd = 'echo "" > ' + troutpath + lexica[pos];
	retval = commands.getstatusoutput(cmd);
	cmd = 'echo "" > ' + azoutpath + lexica[pos];
	retval = commands.getstatusoutput(cmd);
#}	

# Expand the bilingual dictionary using lt-expand
retval = commands.getstatusoutput(LTEXPAND + ' ' + bidix);

for line in retval[1].split('\n'): #{

	# Check if the line has a direction restriction
	r = '-';
	if line.count(':>:') > 1: #{
		r = 'LR';
	elif line.count(':<:') > 1: #{
		r = 'RL';
	#}

	row = [];

	if r == 'LR': #{
		row = line.split(':>:');
	elif r == 'RL': #{
		row = line.split(':<:');
	else: #{
		row = line.split(':');
	#}	

	left = row[0];
	right = row[1];

	llema = left.split('<')[0];
	rlema = right.split('<')[0];
	ltags = '<' + '<'.join(left.split('<')[1:]);
	rtags = '<' + '<'.join(right.split('<')[1:]);

	if ltags not in lexica: #{
		print >> sys.stderr , '[l] Warning: Tag combination ' + ltags + ' not found.';
		continue;
	#}
	if rtags not in lexica: #{
		print >> sys.stderr , '[r] Warning: Tag combination ' + rtags + ' not found.';
		continue;
	#}

	lexleft = trlexpath + lexica[ltags];
	lexright = azlexpath + lexica[ltags];

	cmd = 'cat ' + lexleft + ' | grep "^' + llema + '$" >> ' + troutpath + lexica[ltags];
	retval = commands.getstatusoutput(cmd);

	cmd = 'cat ' + lexright + ' | grep "^' + rlema + '$" >> ' + azoutpath + lexica[rtags];
	retval = commands.getstatusoutput(cmd);

	print llema , ltags , r , rlema , rtags ;
	
#}
