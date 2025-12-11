--- STEAMODDED HEADER
--- MOD_NAME: GGLM
--- MOD_ID: GGLM
--- MOD_AUTHOR: [StarChaser]
--- MOD_DESCRIPTION: Friend Group Mod that turns people into jokers
--- PREFIX:
----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas{
    key = 'Jokers',
    path = 'Jokers.png',
    px = 71,
    py = 95
}

    SMODS.Joker{
        key = 'joker2',
        loc_txt = {
            name = 'Joker: The Sequal',
            text = {
                'When Blind is Selected,',
                'create a {C:attention}Joker{}',
                '{X:Mult,C:white}X#1#{} Mult'
            }
        },
        atlas = 'Jokers',
        rarity = 4,
        cost = 20,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternalcombat = false,
        perisable_combat = false,
        pos = {x = 0, y = 0},
        config = { extra = {
        Xmult = 1000
        }
        },
        loc_vars = function(self,info_quene,center)
            return {vars = {center.ability.extra.Xmult}}
        end,
        calculate = function(self,card,context)
            if context.joker_main then 
                return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.Mult
            }
        end
        
        if context.setting_blind then
            local new_card = create_card('Joker', G.jokers, nil,nil,nil,nil,'j_joker')
            new_card:add_to_deck()
            G.jokers:emplace(new_card)
        end
    end,
        in_pool = function(self,wawa,wawa2)
        --whether or not this card is in the pool, return true if it is, return false if its not
        return false
    end
}
SMODS.Atlas{
    key = 'Salve',
    path = 'Jokers.png',
    px = 71,
    py = 95
}



    SMODS.Joker{
    key = 'Salve',
    loc_txt = {
        name = 'Salve',
        text = {
            'All {C:attention}Aces{} drawn after',
            'selecting blind become',
            '{C:dark_edition}Glass Polychrome{}'
        }
    },
    atlas = 'Salve',
    rarity = 4,
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 1, y = 0},
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.base.id == 14 then
                -- If already polychrome, add glass
                if context.other_card.edition and context.other_card.edition.polychrome then
                    context.other_card:set_ability(G.P_CENTERS.m_glass, true)
                    return {
                        extra = {message = "Glass!", colour = G.C.DARK_EDITION},
                        card = context.other_card
                    }
                -- If not polychrome yet, make it polychrome
                elseif not context.other_card.edition then
                    context.other_card:set_edition({polychrome = true}, true, true)
                    return {
                        extra = {message = "Polychrome!", colour = G.C.DARK_EDITION},
                        card = context.other_card
                    }
                end
            end
        end
    end,
    in_pool = function(self)
        return true
    end
}