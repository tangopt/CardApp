//
//  CardMatchingGame.h
//  CardApp
//
//  Created by Pablo Dimenza on 29/08/13.
//  Copyright (c) 2013 Pablo Dimenza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

//Designated initializer
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic) int numOfMatchingCards;
@property (readonly, nonatomic) int score;
@property (readonly, nonatomic) NSString *descriptionOfLastFlip;

@end
