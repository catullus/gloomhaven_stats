## 3. simulation logic
sim_mindthief <- function(modifier_deck, attack_deck = c(2,2), augment, ally=0, ally_attack = c(2, 2)){
    ## realistically, this only simulates the first hit on a creature plus a follow-up hit if there is an ally adjacent and attacking the same creature (ally = 1)
    ## 1. draw a random modifier card
    ## 2. add augment to this, if possible
    ## 3. estimate damage output
    ## 3b. if ally == 1, add base +2 attack PLUS anything from debuff e.g. poison, wound
    ## 4. store total damage output and debuff
    
    ### 1. draw a random card, parse it into a number or result...if miss, then damage = 0, if 2x, then double damage
    output = list()
    card = sample(x = modifier_deck, size = 1)
    card_check = as.integer(card)
    
    ##> branch A1 = card is a string
    if (is.na(card_check)){
        ##>> branch B1a = is ally attacking creature too?
        if (ally == 1){
            if (card == "2x"){
                ## DOUBLE
                damage = (2 * ((sample(x = attack_deck, size = 1) + augment$attack))) + 
                    sample(x = ally_attack, size = 1) + 
                    ifelse(grepl(x = augment$debuff, pattern = "poison"), 1, 0)
                
                #print(paste(damage, "ally=", ally, "ally_attack=", ally_attack, "aug_debuff =",augment$debuff, "aug_attack=", augment$attack))
                return(damage)
            } else if (card == "miss"){
                ## MISS
                damage = 0
                #print(paste(damage, "ally=", ally, "ally_attack=", ally_attack, "aug_debuff =",augment$debuff, "aug_attack=", augment$attack))
                return(damage)
            }
            ##>> branch B1b
        } else if (ally == 0){
            if (card == "2x"){
                ## DOUBLE
                ## if no ally, spread poison damage out over 2 rounds since I haven't tracked state yet
                damage = (2 * ((sample(x = attack_deck, size = 1) + augment$attack))) + 
                    ifelse(grepl(x = augment$debuff, pattern = "poison"), 0.5, 0)
                #print(paste(damage, "ally=", ally, "ally_attack=", ally_attack, "aug_debuff =",augment$debuff, "aug_attack=", augment$attack))
                return(damage)
            } else if (card == "miss"){
                ## MISS
                damage = 0
                #print(paste(damage, "ally=", ally, "ally_attack=", ally_attack, "aug_debuff =",augment$debuff, "aug_attack=", augment$attack))
                return(damage)
            }
        } else if (ally == 2){
            if (card == "2x"){
                ## DOUBLE
                damage = (2 * ((sample(x = attack_deck, size = 1) + augment$attack))) + 
                    sample(x = ally_attack, size = 1) + 
                    ifelse(grepl(x = augment$debuff, pattern = "poison"), 1, 0) + 
                    ## second ally attack
                    sample(x = ally_attack, size = 1) + 
                    ifelse(grepl(x = augment$debuff, pattern = "poison"), 1, 0)
                
                return(damage)
            } else if (card == "miss"){
                ## MISS
                damage = 0
                #print(paste(damage, "ally=", ally, "ally_attack=", ally_attack, "aug_debuff =",augment$debuff, "aug_attack=", augment$attack))
                return(damage)
            }
        } else if (ally == 3){
            if (card == "2x"){
                ## DOUBLE
                damage = (2 * ((sample(x = attack_deck, size = 1) + augment$attack))) + 
                    sample(x = ally_attack, size = 1) + 
                    ifelse(grepl(x = augment$debuff, pattern = "poison"), 1, 0) + 
                    ## second ally attack
                    sample(x = ally_attack, size = 1) + 
                    ifelse(grepl(x = augment$debuff, pattern = "poison"), 1, 0) + 
                    ## second ally attack
                    sample(x = ally_attack, size = 1) + 
                    ifelse(grepl(x = augment$debuff, pattern = "poison"), 1, 0)
                
                return(damage)
            } else if (card == "miss"){
                ## MISS
                damage = 0
                #print(paste(damage, "ally=", ally, "ally_attack=", ally_attack, "aug_debuff =",augment$debuff, "aug_attack=", augment$attack))
                return(damage)
            }
        }
        
    ##> branch A2 = card is an integer   
    } else if (!is.na(card_check)){
        ##>> branch B2a = if ally is attacking same creature
        if (ally == 1){
        damage = as.integer(card) + 
            sample(x = attack_deck, size = 1) + 
            augment$attack + 
            sample(x = ally_attack, size = 1) + 
            ifelse(grepl(x = augment$debuff, pattern = "poison"), 1, 0) 
        
        #print(paste(damage, "ally=", ally, "ally_attack=", ally_attack, "aug_debuff =",augment$debuff, "aug_attack=", augment$attack))
        return(damage)
        ##>> branch B2b
        } else if (ally == 0){
            ## if no ally, spread poison damage out over 2 rounds since I haven't tracked state yet
            damage = as.integer(card) + 
                sample(x = attack_deck, size = 1) + 
                augment$attack + 
                ifelse(grepl(x = augment$debuff, pattern = "poison"), 0.5, 0) 
            
            #print(paste(damage, "ally=", ally, "ally_attack=", ally_attack, "aug_debuff =",augment$debuff, "aug_attack=", augment$attack))
            return(damage)
        } else if (ally == 2){
            damage = as.integer(card) + 
                sample(x = attack_deck, size = 1) + 
                augment$attack + 
                sample(x = ally_attack, size = 1) + 
                ifelse(grepl(x = augment$debuff, pattern = "poison"), 1, 0) +    
                ## second ally attack
                sample(x = ally_attack, size = 1) + 
                ifelse(grepl(x = augment$debuff, pattern = "poison"), 1, 0) 
            
            #print(paste(damage, "ally=", ally, "ally_attack=", ally_attack, "aug_debuff =",augment$debuff, "aug_attack=", augment$attack))
            return(damage)
        } else if (ally == 3){
            damage = as.integer(card) + 
                sample(x = attack_deck, size = 1) + 
                augment$attack + 
                sample(x = ally_attack, size = 1) + 
                ifelse(grepl(x = augment$debuff, pattern = "poison"), 1, 0) +    
                ## second ally attack
                sample(x = ally_attack, size = 1) + 
                ifelse(grepl(x = augment$debuff, pattern = "poison"), 1, 0) +
                ## second ally attack
                sample(x = ally_attack, size = 1) + 
                ifelse(grepl(x = augment$debuff, pattern = "poison"), 1, 0) 
            
            #print(paste(damage, "ally=", ally, "ally_attack=", ally_attack, "aug_debuff =",augment$debuff, "aug_attack=", augment$attack))
            return(damage)
        }
    } ## branch B2
    
} # function closer


### test numeric cards
#sim_mindthief(modifier_deck = base_modifier_deck, augment = mt_augments[[1]], ally = 1)

### test string cards
#sim_mindthief(modifier_deck = "miss", augment = mt_augments[[1]], ally = 1)

