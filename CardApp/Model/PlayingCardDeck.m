//
//  PlayingCardDeck.m
//  CardApp
//
//  Created by Pablo Dimenza on 28/08/13.
//  Copyright (c) 2013 Pablo Dimenza. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (id) init{
    self = [super init];
    if (self){
        for (NSString *suit in [PlayingCard validSuits]){
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++){
                PlayingCard *newCard = [[PlayingCard alloc] init];
                [newCard setRank:rank];
                [newCard setSuit:suit];
                [self addCard:newCard atTop:NO];
                
            }
        }
    }
    return self;
}

@end
