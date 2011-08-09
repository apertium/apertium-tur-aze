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
	'adjectives': ['<adj>'],
	'adverbs': ['<adv>'],
	'cnjadv': ['<cnjadv>'],
	'cnjcoo': ['<cnjcoo>'],
	'cnjsub': ['<cnjsub>'],
	'det': ['<det>'],
	'interjections': ['<ij>'],
	'nouns': ['<n>'],
	'pn_acr': ['<np><acr>'],
	'pn_ant': ['<np><ant>'],
	'pn_cog': ['<np><cog>'],
	'pn_org': ['<np><org>'],
	'postpositions': ['<postp>'],
	'postpositions_infl': ['<postp>'],
	'pronouns': ['<prn>', '<prn><dem>', '<prn><pers>', '<prn><locp>', '<prn><qst>'],
	'proper_nouns': ['<np>'],
	'toponyms': ['<np><top>'],
	'verbs': ['<v>'],
	'verbs_iv': ['<v><iv>'],
	'verbs_tv': ['<v><tv>']
};

tags_stems = {};

extra_files_common = ['lexicon/misc']

LTEXPAND = 'lt-expand';

if len(sys.argv) < 3: #{
	print 'update.py <bidix> <trmorph dir>';
	sys.exit(-1);
#}

bidix = sys.argv[1];		# An apertium bilingual dictionary
trmorph = sys.argv[2] + '/';	# Directory of TRmorph
trout = './morph-tr/'; 		# Output directory

retval = commands.getstatusoutput(LTEXPAND + ' ' + bidix);
for line in retval[1].split('\n'): #{
	row = line.split(':');
	left = row[0];
	tags = '<' + '<'.join(row[0].split('<')[1:]);
	lema = row[0].split('<')[0];	

	if tags not in tags_stems: #{
		tags_stems[tags] = [];
	#}
	tags_stems[tags].append(lema);
#}

for tags in tags_stems.keys(): #{
	print tags.decode('utf-8') , len(tags_stems[tags]);
#}

for f in tag_files.keys(): #{
	print '\n*' , f.decode('utf-8') + ':';
	# Read lexicon file and check to see if there is an entry for each line in the bidix	


	outfile = file(trout + '/lexicon/' + f, 'w+');
	outfile.close();
	for tag in tag_files[f]: #{
		if tag not in tags_stems: #{
			continue;
		#}

		outfile = file(trout + '/lexicon/' + f, 'a+');
		for line in file(trmorph + '/lexicon/' + f).read().split('\n'): #{
			if line == '': #{
				continue;
			#}
			lema = '';
			if line.count('#') > 0: #{
				lema = line.split('#')[1].strip();
			else: #{
				lema = line.strip();
			#}
			if lema in tags_stems[tag]: #{
				print '+' , f.decode('utf-8') , lema.decode('utf-8') , line.decode('utf-8');
				if line.count('\t') > 0: #{
					outfile.write(line.split('\t')[0] + '\n');
				else: #{
					outfile.write(line + '\n');
				#}
			else: #{
				print '-' , f.decode('utf-8') , lema.decode('utf-8') , line.decode('utf-8');
			#}
		#}
		outfile.close();
	#}
#}
