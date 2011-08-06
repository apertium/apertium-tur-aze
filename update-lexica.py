#!/usr/bin/python
# coding=utf-8
# -*- encoding: utf-8 -*-

###############################################################################
## Dictionary trimming script for TRmorph style transducers
###############################################################################

import sys, codecs, copy, commands, os;

sys.stdin  = codecs.getreader('utf-8')(sys.stdin);
sys.stdout = codecs.getwriter('utf-8')(sys.stdout);
sys.stderr = codecs.getwriter('utf-8')(sys.stderr);

LTEXPAND = 'lt-expand';

# Relationship between tag in the bilingual dictionary and 
# lexicon file in the morphological transducer.
lexica = {
	'<adj>': ['adjectives'],
	'<adv>': ['adverbs'],
	'<cnjadv>': ['cnjadv'],
	'<cnjcoo>': ['cnjcoo'],
	'<cnjsub>': ['cnjsub'],
	'<det>': ['det'],
	'<ij>': ['interjections'],
	'<n>': ['nouns'],
	'<postp>': ['postpositions', 'postpositions_infl'],
	'<prn>': ['pronouns'],
	'<np>': ['proper_nouns'],
	'<np><top>': ['toponyms'],
	'<np><cog>': ['pn_cog'],
	'<np><acr>': ['pn_acr'],
	'<np><org>': ['pn_org'],
	'<np><ant>': ['pn_ant'],
	'<v>': ['verbs'],
	'<v><iv>': ['verbs_iv'],
	'<v><tv>': ['verbs_tv']
	#'': 'misc',
};

extra_files_common = ['lexicon/misc']
extra_files_common = ['lexicon/misc']

if len(sys.argv) < 4: #{
	print 'update.py <bidix> <trmorph dir> <azmorph dir>';
	sys.exit(-1);
#}

bidix = sys.argv[1];		# An apertium bilingual dictionary
trmorph = sys.argv[2] + '/';	# Directory of TRmorph
azmorph = sys.argv[3] + '/';	# Directory of AZmorph

trlexpath = trmorph + '/lexicon/';	# Path to the lexicon files
azlexpath = azmorph + '/lexicon/';	# Path to the lexicon files

troutpath = './morph-tr/';	# Output path
azoutpath = './morph-az/';	# Output path

troutlexpath = './morph-tr/lexicon/';	# Output path
azoutlexpath = './morph-az/lexicon/';	# Output path

# Update .fst files from originals

cmd = 'cp ' + azmorph + '/*.fst ' + azoutpath;
retval = commands.getstatusoutput(cmd);
cmd = 'cp ' + trmorph + '/*.fst ' + troutpath;
retval = commands.getstatusoutput(cmd);

# Update phon files from originals 

cmd = 'cp ' + azmorph + '/phon/* ' + azoutpath + '/phon/';
retval = commands.getstatusoutput(cmd);
cmd = 'cp ' + trmorph + '/phon/* ' + troutpath + '/phon/';
retval = commands.getstatusoutput(cmd);

for f in extra_files_common: #{
	cmd = 'cp ' + trmorph + f + ' ' + troutpath + f;
	retval = commands.getstatusoutput(cmd);
	cmd = 'cp ' + azmorph + f + ' ' + azoutpath + f;
	retval = commands.getstatusoutput(cmd);
#}

for pos in lexica: #{

	# Remove all existing entries from the trimmed lexica
	for f in lexica[pos]: #{
		if os.path.exists(trlexpath + '/' + f): 
			cmd = 'echo "" > ' + troutlexpath + f;
			retval = commands.getstatusoutput(cmd);
		if os.path.exists(azlexpath + '/' + f): 
			cmd = 'echo "" > ' + azoutlexpath + f;
			retval = commands.getstatusoutput(cmd);
	#}
#}	

# Expand the bilingual dictionary using lt-expand
retval = commands.getstatusoutput(LTEXPAND + ' ' + bidix);
# Example output:
#  yani<cnjadv>:yəni<cnjadv>
#  ne var ki<cnjadv>:nə var ki<cnjadv>
#  olsun<cnjadv>:olsun<cnjadv>
#  
for line in retval[1].split('\n'): #{

	# Check if the line has a direction restriction
	r = '-';
	if line.count(':>:') > 1: #{
		r = 'LR';
	elif line.count(':<:') > 1: #{
		r = 'RL';
	#}

	row = [];

	# Split the line into two
	if r == 'LR': #{
		row = line.split(':>:');
	elif r == 'RL': #{
		row = line.split(':<:');
	else: #{
		row = line.split(':');
	#}	

	left = row[0];			# The left side, e.g. yani<cnjadv>
	right = row[1];			# The right side, e.g. yəni<cnjadv>

	llema = left.split('<')[0]; 	# The left lemma, e.g. yani
	rlema = right.split('<')[0];	# The right lemma, e.g. yəni

	ltags = '<' + '<'.join(left.split('<')[1:]); # All the tags on the left, e.g. <cnjadv>
	rtags = '<' + '<'.join(right.split('<')[1:]); # All the tags on the right, e.g. <cnjadv>

	# Skip the line in the bidix if there is a set of tags that we don't know where 
	# the stems should be in the TR/AZmorph lexicon files
	if ltags not in lexica: #{
		print >> sys.stderr , '[l] Warning: Tag combination ' + ltags + ' not found.';
		continue;
	#}
	if rtags not in lexica: #{
		print >> sys.stderr , '[r] Warning: Tag combination ' + rtags + ' not found.';
		continue;
	#}

	# The left side tag lexicon is found here
	lexleft = '';
	for f in lexica[ltags]: #{
		if os.path.exists(trlexpath + f): #{
			lexleft = lexleft + trlexpath + f + ' ';
		#}
	
		# Grep the lemma out of the original lexicon, and into the trimmed one
		cmd = 'cat ' + lexleft + ' | grep "^' + llema + '$" >> ' + troutlexpath + f;
		retval = commands.getstatusoutput(cmd);
	#}
	# The right side tag lexicon is found here
	lexright = '';
	for f in lexica[ltags]: #{
		if os.path.exists(azlexpath + f): #{
			lexright = lexright + azlexpath + f + ' ';
		#}
		# Grep the lemma out of the original lexicon, and into the trimmed one
		cmd = 'cat ' + lexright + ' | grep "^' + rlema + '$" >> ' + azoutlexpath + f;
		retval = commands.getstatusoutput(cmd);
	#}



	print llema , ltags , r , rlema , rtags ;
#}
