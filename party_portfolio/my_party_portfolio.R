library(plyr)
library(dplyr)


card_stats <- read.csv("card_stats.csv")

## convert NA, which is because of blank cells
card_stats[is.na(card_stats)] <- 0

my_party <- c("Mindthief", "Tinkerer", "Brute")

data <- dplyr::filter(card_stats, Class %in% my_party, level < 6)

## summarize total attack, attack_target + attack_hex, range, debuffs, movement

stats <- plyr::ddply(data, ~Class, summarize, 
                     ## turned blanks into zeros, these aren't actually "attack 0"
                     avg_attack = round(mean(Attack[which(Attack > 0)], na.rm = TRUE), 2),
                     max_attack = max(Attack),
                     total_attack_modifier = sum(Attack_Mod),
                     total_attack_aoe = sum(Attack_Hexs, Attack_Targets, na.rm = TRUE),
                     total_range_attacks = sum(ifelse(heal == 0 & range > 0, 1, 0), na.rm = TRUE),
                     total_nonloss_movement = sum(move[which(move > 0 & Loss_Bin != 1)]),
                     total_loss_movement = sum(move[which(move > 0 & Loss_Bin == 1)]),                    
                     total_debuff = sum(ifelse(debuff_type != "", 1, 0)),
                     total_stun = length(debuff_type[grepl(pattern = "stun", x = debuff_type)]),
                     total_muddle = length(debuff_type[grepl(pattern = "muddle", x = debuff_type)]),
                     total_immobilize = length(debuff_type[grepl(pattern = "immobilize", x = debuff_type)]),
                     total_poison = length(debuff_type[grepl(pattern = "poison", x = debuff_type)]),
                     total_wound = length(debuff_type[grepl(pattern = "wound", x = debuff_type)]),
                     total_push_targets = sum(push_target)); head(stats)
                     
