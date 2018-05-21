Mindthief Augment Simulation, First Round Damage: TMW vs WC
================

Question
--------

-   Gloomhaven Mindthief (MT) class guides almost unanimously recommend using the augment card "The Mind's Weakness" (TMW) over all other augments for the majority of combat situations
-   The primary reason: TMW's +2 damage for every melee attack means "monsters are dying faster, causing less damage to the MT and other party members"
-   I wanted to explore to what extent this communal wisdom broke down, if at all, through simple simulations because:
    1.  The game seems to be well balanced, how could the design come up so short when it comes to the utility of other augment cards?
    2.  There must be certain sitations where augments other than TMW are "more optimal" to deploy
-   For this very simple simulation, **"more optimal" means 'the augment card that leads to more damage in a single round of combat'**

![](mindthief_sim_firststrike_rmd_files/figure-markdown_github/unnamed-chunk-1-1.png)

Setup
-----

### Simulation Assumptions

-   The Mindthief attacks first for every iteration of the simulation
-   This is only the first round of combat
-   I do not simulate:
    -   time to kill (ttk), the number of actions or number of rounds it takes to kill a hypothetical monster
    -   a "full round" of combat, the amount of damage the party does PLUS the damage monsters deal (i.e. this would be a more realistic way of simulating how Withering Claw's muddle effect might reduce incoming damage)

### Input Variables

-   The following variables were considered in this simulation:
    -   Mindthief level 1 card attack values = \[2,3,1,3,1,2,1,1\]
    -   Base Attack Modifier Deck = \[0, 0, 0, 0, 0,0, 1,1,1,1,1,-1,-1,-1,-1,-1, 2, -2, "2x", "miss"\]
    -   Two Augment Cards = The Mind's Weakness (TMW) and Withering Claw (WC)
    -   Allies = accounts for damage dealt by other party members, ranges from 0 (no party members adding damage) to 3 (all party members attacking the same monster)
        -   For now, we very simply assume an ally adds +2 damage to the monster with no deck modifiers

### Damage Model

-   The damage model is thus:
    -   total first round damage = `R(MT attack card) + R(attack modifier) + (augment_card) + (ally_damage)`
    -   My notation `R(variable)` indicates that the variable is a single random value drawn from the "pool" of character or attack modifier cards
    -   If `augment_card` = "Withering Claw", `(ally_damage)` = 2 + 1 (+1, from poison) *for each ally's attack*
    -   If `augment_card` = "The Mind's Weakness", `(ally_damage)` = 2
