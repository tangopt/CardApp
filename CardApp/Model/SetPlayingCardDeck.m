//
//  SetPlayingCardDeck.m
//  CardApp
//
//  Created by Pablo Dimenza on 10/09/13.
//  Copyright (c) 2013 Pablo Dimenza. All rights reserved.
//

#import "SetPlayingCardDeck.h"
#import "SetPlayingCard.h"

@implementation SetPlayingCardDeck

//Create a Set card deck with all the possible cards (81 cards)

- (id) init{
    self = [super init];
    if (self){
        for (NSString *rank in [SetPlayingCard validRanks])
            for (NSString *color in [SetPlayingCard validColors])
                for (NSString *symbol in [SetPlayingCard validSymbols])
                    for (NSString *shading in [SetPlayingCard validShadings]){
                        SetPlayingCard *newCard = [[SetPlayingCard alloc] init];
                        [newCard setRank:rank];
                        [newCard setColor:color];
                        [newCard setSymbol:symbol];
                        [newCard setShading:shading];
                        [self addCard:newCard atTop:NO];
                    }
       
    }
    return self;
}

@end
