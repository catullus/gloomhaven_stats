## mindthief_sims
mindthief_attack_deck = c(2,3,1,3,1,2,1,1)
## 
base_modifier_deck <- c(0, 0, 0, 0, 0,0, 1,1,1,1,1,-1,-1,-1,-1,-1, 2, -2, "2x", "miss")

## 2. set augment
mt_augments <- list(minds_weakness = list(attack = 2, debuff = "", buff = ""), 
                    withering_claw = list(attack = 0, debuff = "poison, muddle", buff = ""),
                    feedback_loop = list(attack = 0, debuff = "", buff = "+1 shield"))


minds_weakness_sim1 = replicate(1000, expr = sim_mindthief(modifier_deck = base_modifier_deck, attack_deck = mindthief_attack_deck, augment = mt_augments[[1]], ally = 1))

minds_weakness_sim0 = replicate(1000, expr = sim_mindthief(modifier_deck = base_modifier_deck, attack_deck = mindthief_attack_deck, augment = mt_augments[[1]], ally = 0))

withering_claw_sim1 = replicate(1000, expr = sim_mindthief(modifier_deck = base_modifier_deck, attack_deck = mindthief_attack_deck, augment = mt_augments[[2]], ally = 1))

withering_claw_sim0 = replicate(1000, expr = sim_mindthief(modifier_deck = base_modifier_deck, attack_deck = mindthief_attack_deck, augment = mt_augments[[2]], ally = 0))

minds_weakness_sim2 = replicate(1000, expr = sim_mindthief(modifier_deck = base_modifier_deck, attack_deck = mindthief_attack_deck, augment = mt_augments[[1]], ally = 2))

withering_claw_sim2 = replicate(1000, expr = sim_mindthief(modifier_deck = base_modifier_deck, attack_deck = mindthief_attack_deck, augment = mt_augments[[2]], ally = 2))

par(mfrow=c(3,2))

max_label = max(minds_weakness_sim1, minds_weakness_sim0, withering_claw_sim1, withering_claw_sim0, withering_claw_sim2, minds_weakness_sim2)

hist(minds_weakness_sim2, main = paste("TMW, ally = 2;",mean(minds_weakness_sim2)), xlim = c(0, max_label))
hist(withering_claw_sim2, main = paste("WC, ally = 2;",mean(withering_claw_sim2)), xlim = c(0, max_label))
hist(minds_weakness_sim1, main = paste("TMW, ally = 1;", mean(minds_weakness_sim1)), xlim = c(0, max_label))
hist(withering_claw_sim1, main = paste("WC, ally = 1;",mean(withering_claw_sim1)), xlim = c(0, max_label))
hist(minds_weakness_sim0, main = paste("TMW, ally = 0;",mean(minds_weakness_sim0)), xlim = c(0, max_label))
hist(withering_claw_sim0, main = paste("WC, ally = 0;",mean(withering_claw_sim0)), xlim = c(0, max_label))

