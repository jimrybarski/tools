WORK=/stor/work/Wilke/rybarskj
CURRENT_PROJECT=final-mempads
OUTPUT=$WORK/$CURRENT_PROJECT/output
SRC=$WORK/$CURRENT_PROJECT/src
LIB=$SRC/libmempads
DATA=$WORK/$CURRENT_PROJECT/data
FIGURES=$WORK/$CURRENT_PROJECT/figures
REPORTS=$FIGURES/reports
FIGURE_DATA=$WORK/$CURRENT_PROJECT/figure-data
ANALYSIS=$WORK/$CURRENT_PROJECT/analysis
SCRATCH=$WORK/$CURRENT_PROJECT/scratch
PLOTS=$WORK/$CURRENT_PROJECT/plot


alias src="cd $SRC"
alias an="cd $ANALYSIS"
alias out="cd $OUTPUT"
alias lib="cd $LIB"
alias data="cd $DATA"
alias fda="cd $FIGURE_DATA"
alias fig="cd $FIGURES"
alias plot="cd $PLOTS"
alias s="cd $SCRATCH"
alias rep="cd $REPORTS"

alias pandoc="$HOME/.cabal/bin/pandoc"

lib
clear
