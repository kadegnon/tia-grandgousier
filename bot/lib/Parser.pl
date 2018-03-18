#!/usr/bin/perl
use strict;
use warnings;
use Encode;
use utf8;  # Source is encoded using UTF-8
use open ':std', ':encoding(iso-8859-1)';

open IN,"<dela-fr-public-u8.dic.xml" or die $!;

open NOUN,	">noms.prolog" or die $!;
open ADJ,	">adjectifs.prolog" or die $!;
open ADV,	">adverbes.prolog" or die $!;
open CONJC,	">conjonctions.prolog" or die $!;
open DET,	">determinants.prolog" or die $!;
open PRONOUN,">pronoms.prolog" or die $!;
open VERB,	">verbes.prolog" or die $!;

my $doc = "";
while (<IN>){
	chomp $_;
	$doc .= decode("utf8","$_");
}

my @doct = split /<\/entry>/,$doc;

my %h_noun    = ();
my %h_adj     = ();
my %h_adv     = ();
my %h_conjc   = ();
my %h_det     = ();
my %h_pronoun = ();
my %h_verb    = ();

foreach my $entry (@doct){
	my @t = split /<\/lemma>/,$entry;
	next unless ($#t == 1);

	# $t[0] contient le mot en fin de ligne.
	# $t[1] contient le type du mot, et les formes dérivées.
	my $mot = $1 if ($t[0] =~ m#<lemma>([^ '\d\\]+)$#);
	next unless $mot;
	# Si il y a un simple-quote dans le mot ou un chiffre ou un espace, on ne le référence pas.
	$mot =~ s/\\//;

	my $type;
	$type = $1 if ($t[1] =~ m#<pos name='([^ ']+)'/>#);
	next unless $type;
	next unless ($type eq "noun" || $type eq "adj" || $type eq "adverb" ||
				 $type eq "conjc" || $type eq "det" || $type eq "pronoun" || $type eq "verb");
	# On ne garde que les adjectifs, les noms, les adverbes et les conjonctions de coordinations, les déterminants, les pronoms.
	
	my @inflecteds = split /<\/inflected>/,$entry;

	foreach my $inflected (@inflecteds) {

		my $derivation = $1 if ($inflected =~ m/<form>([^<]+)<\/form>/);
		$derivation    =~ s/\\//;
		
		my $genre    = "";
		my $nombre   = "";
		my $tense    = "";
		my $personne = 0;

		$personne = $1 if ($inflected =~ m/<feat name='person' value='([^ ']+)'\/>/);
		$genre    = $1 if ($inflected =~ m/<feat name='gender' value='([^ ']+)'\/>/);
		$nombre   = $1 if ($inflected =~ m/<feat name='number' value='([^ ']+)'\/>/);
		$tense    = $1 if ($inflected =~ m/<feat name='tense' value='([^ ']+)'\/>/);

		print "$derivation : $personne $genre $nombre ==> " if ($tense eq "ppast");

		if ($type ne "verb") {
			if ($genre ne "" and $nombre ne "") {
				my $genre_et_nombre = "$genre $nombre";
				$personne = "1";
				$personne = "2" if ($genre_et_nombre eq 'feminine singular');
				$personne = "3" if ($genre_et_nombre eq 'masculine plural');
				$personne = "4" if ($genre_et_nombre eq 'feminine plural');
			}
		} else {
			$personne = $personne + 2 if ($nombre eq "plural" and $personne ne "0");
			if ($personne eq "0" or $personne eq "") {
				if ($genre ne "" and $nombre ne "") {
					my $genre_et_nombre = "$genre $nombre";
					$personne = "1";
					$personne = "2" if ($genre_et_nombre eq 'feminine singular');
					$personne = "3" if ($genre_et_nombre eq 'masculine plural');
					$personne = "4" if ($genre_et_nombre eq 'feminine plural');

					print "$derivation : $personne $genre_et_nombre\n" if ($tense eq "ppast");
				}
			}
		}
			# mot(Mot,Personne,FormeCanonique).
		$h_noun{"nom('$derivation', '$personne', '$mot').\n"} = 1 if ($type eq "noun");

			# adjectif(Mot,Personne,FormeCanonique).
		$h_adj{"adj('$derivation', '$personne', '$mot').\n"} = 1 if ($type eq "adj");

			# adverbe(Mot,Personne,FormeCanonique).
		$h_adv{"adv('$derivation', '$personne', '$mot').\n"} = 1 if ($type eq "adverb");

			# conjonction_coordination(Mot,Personne).
		$h_conjc{"conjc('$derivation', '$personne').\n"} = 1 if ($type eq "conjc");

			# determinant(Mot,Personne,FormeCanonique).
		$h_det{"det('$derivation', '$personne', '$mot').\n"} = 1 if ($type eq "det");

			# pronom(Mot,Personne,FormeCanonique).
		$h_pronoun{"pron('$derivation', '$personne', '$mot').\n"} = 1 if ($type eq "pronoun");

			# verbe(Conjugé,Personne,Infinitif,Temps).
		$h_verb{"verbe('$derivation', '$personne', '$mot', '$tense').\n"} = 1 if ($type eq "verb");

	}
}

print NOUN "%% mot(Mot,Personne,FormeCanonique).\n%% \n";
my @t  = keys %h_noun;
my @tt = sort @t;
while (@tt) {
	print NOUN encode("utf8",shift @tt);
}

print ADJ "%% adjectif(Mot,Personne,FormeCanonique).\n%% \n";
@t  = keys %h_adj;
@tt = sort @t;
while (@tt) {
	print ADJ encode("utf8",shift @tt);
}

print ADV "%% adverbe(Mot,Personne,FormeCanonique).\n%% \n";
@t  = keys %h_adv;
@tt = sort @t;
while (@tt) {
	print ADV encode("utf8",shift @tt);
}

print CONJC "%% conjonction_coordination(Mot,Personne).\n%% \n";
@t  = keys %h_conjc;
@tt = sort @t;
while (@tt) {
	print CONJC encode("utf8",shift @tt);
}

print DET "%% determinant(Mot,Personne,FormeCanonique).\n%% \n";
@t  = keys %h_det;
@tt = sort @t;
while (@tt) {
	print DET encode("utf8",shift @tt);
}

print PRONOUN "%% pronom(Mot,Personne,FormeCanonique).\n%% \n";
@t  = keys %h_pronoun;
@tt = sort @t;
while (@tt) {
	print PRONOUN encode("utf8",shift @tt);
}

print VERB "%% verbe(Conjuge,Personne,Infinitif,Temps).\n%% \n";
@t  = keys %h_verb;
@tt = sort @t;
while (@tt) {
	print VERB encode("utf8",shift @tt);
}

close IN;
close NOUN;
close ADJ;
close ADV;
close CONJC;
close DET;
close PRONOUN;
close VERB;