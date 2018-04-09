# Flags: skip welcome, optimize, run goal (expects arg)
PROLOG 	= swipl --quiet -O

CRISP 	= $(PROLOG) -s 'bot/test/_lib/crisp.pl' -g

CRISP_LIB = 'bot/test/_lib/includes'

all: trim tests

trim:
	# Remove trailing whitespace and such. Not vital.
	- trim_and_clean **/*.pl

tests:
	clear
	@$(CRISP) "['api/test/*.spec*','bot/test/*.spec*'], crisp, halt"

	
stay:
	clear
	@$(CRISP) "['api/test/*.spec*','bot/test/*.spec*'], crisp"

	
test_api:
	clear
	$(CRISP) "['api/test/*.spec.*'], crisp, halt"

	
test_bot:
	clear
	$(CRISP) "['bot/test/*.spec.*'], crisp, halt"
