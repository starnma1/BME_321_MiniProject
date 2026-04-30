\# Timo's Assessment of the logical and statistical soundness of the analyses

Comments on all four R files



\## part 1 - camouflage in the field -----------------------------------

* overall

  * there is a title, which is however identical to filename - redundancy? (author/date/... missing)
  * tidy, well-readable overall structure
  * every step shortly explained by means of comment
* pipeline

  * setup
  * data import, screening, wrangling

    * raw data stored nowhere
    * no screening after data import (directly data wrangling after import) --> partly justified by data being collected by them
  * data exploration / visualization

    * completely missing
  * model fitting

    * clearly explained with brief comment for each
    * looking at summary before model selection?
  * model selection

    * clearly explained with brief comment for each
  * model validation

    * only checked assumption of normality of residuals 
    * QQ-plot doesn't look good, but is not addressed
  * interpretation

    * potential overconfident result reporting in paper (considering that assumptions were so badly met)
    * code for creating figures shown in paper?



NOTE: all notes on part 1 apply to the subsequent scripts as well,

unless I specifically mention a difference







\## part 2 - colour change experiment\_goby -----------------------------



* overall

  * splitting analysis up into HUE and JND vision clearly indicated
* pipeline

  * setup
  * data import, screening, wrangling

    * minimal screening after data import, even not commented as such
    * log transformation of JND values for green prawns (mentioned in paper)? 
  * model fitting

    * no justification for excluding NA values from model fitting
    * wrong dataset name used (error)
  * model selection
  * model validation

    * only checked assumption of normality of residuals
    * this time QQ-plot looks fairly satisfying
  * interpretation

    * well-written reporting in paper, in particular biological explanations







\## part 2 - colour change experiment\_pollak ---------------------------



* same architecture as part 2.1 (see above)
* correct dataset name used





\## Summary of comments on part 2

* no data exploration at all (except for minimal head())
* model assumptions of linear mixed effects models not checked, except for normality of residuals (QQ plot) - which was in some cases severely violated !
* no null models, only fit two models \[only interested if size significantly affects HUE or JND values and if there is interaction?]
* no code for plot generation







\## part 3 - behavioural choice ----------------------------------------

* overview

  * not entirely clear what script is all about
  * 









