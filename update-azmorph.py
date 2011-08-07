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

tag_files = {
	'adjectives': '<adj>',
	'adverbs.dix': '<adv>',
	'cnjadv': '<cnjadv>',
	'cnjcoo': '<cnjcoo>',
	'cnjsub': '<cnjsub>',
	'det': '<det>',
	'interjections': '<ij>',
	'nouns': '<n>',
	'pn_acr': '<np><acr>',
	'pn_ant': '<np><ant>',
	'pn_cog': '<np><cog>',
	'pn_org': '<np><org>',
	'postpositions': '<postp>',
	'postpositions_infl': '<postp>',
	'pronouns': '<prn>',
	'proper_nouns': '<np>',
	'toponyms': '<np><top>',
	'verbs': '<v>',
	'verbs_iv': '<v><iv>',
	'verbs_tv': '<v><tv>'
};

tags_stems = {};

extra_files_common = ['lexicon/misc']

LTEXPAND = 'lt-expand';

if len(sys.argv) < 3: #{
	print 'update.py <bidix> <azmorph dir>';
	sys.exit(-1);
#}

bidix = sys.argv[1];		# An apertium bilingual dictionary
azmorph = sys.argv[2] + '/';	# Directory of TRmorph
azout = './morph-az/'; 		# Output directory

retval = commands.getstatusoutput(LTEXPAND + ' ' + bidix);
for line in retval[1].split('\n'): #{

	if line.count(':>:') > 0: #{
		row = line.split(':>:');
	elif line.count(':<:') > 0: #{
		row = line.split(':<:');
	else:
		row = line.split(':');
	#}
		
	left = row[0];
	right = row[1];
	tags = '<' + '<'.join(row[1].split('<')[1:]);
	lema = row[1].split('<')[0];	

	if tags not in tags_stems: #{
		tags_stems[tags] = [];
	#}
	tags_stems[tags].append(lema);
#}

for tags in tags_stems.keys(): #{
	print tags , len(tags_stems[tags]);
#}

for f in tag_files.keys(): #{
	print '\n*' , f + ':';
	# Read lexicon file and check to see if there is an entry for each line in the bidix	

	if tag_files[f] not in tags_stems: #{
		continue;
	#}

	if not os.path.exists(azmorph + '/lexicon/' + f): #{
		continue
	#}
	if f.count('.dix') > 0: #{
		outfile = file(azout + '/lexicon/' + f.replace('.dix', ''), 'w+');
	else: #{
		outfile = file(azout + '/lexicon/' + f, 'w+');
	#}
	for line in file(azmorph + '/lexicon/' + f).read().split('\n'): #{
		if line == '': #{
			continue;
		#}
		lema = '';
		if line.count('#') > 0: #{
			lema = line.split('#')[1].strip();
		elif line.count('<e lm="') > 0: #{
			lema = line.split('lm="')[1].split('"')[0].strip();
		else: #{
			lema = line.strip();
		#}
		if lema in tags_stems[tag_files[f]]: #{
			print '+' , f , lema , line;
			if line.count('\t') > 0: #{
				outfile.write(line.split('\t')[0] + '\n');
			elif line.count('<i>') > 0: #{
				outfile.write(line.split('<i>')[1].split('</i>')[0].replace('<s n="', '<').replace('"/>', '>').replace('<b/>', ' ') + '\n');
			else: #{
				outfile.write(line + '\n');
			#}
		else: #{
			print '-' , f , lema , line;
		#}
	#}
	outfile.close();
#}
