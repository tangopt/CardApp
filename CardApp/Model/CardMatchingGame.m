//
//  CardMatchingGame.m
//  CardApp
//
//  Created by Pablo Dimenza on 29/08/13.
//  Copyright (c) 2013 Pablo Dimenza. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (readwrite, nonatomic) int score;
@property (strong, nonatomic) NSMutableArray *cards; //of Cards
@property (strong, nonatomic) NSString *descriptionOfLastFlip;
@end

@implementation CardMatchingGame

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

@synthesize numOfMatchingCards = _numOfMatchingCards;

-(NSMutableArray *) cards{
    if (!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

-(int) numOfMatchingCards{
    if (!_numOfMatchingCards) _numOfMatchingCards = 2;
    return _numOfMatchingCards;
}

-(void) setNumOfMatchingCards:(int)numOfMatchingCards{
    if (numOfMatchingCards < 2) _numOfMatchingCards = 2;
    else if (numOfMatchingCards > 3) _numOfMatchingCards = 3;
    else _numOfMatchingCards = numOfMatchingCards;
}

-(void)flipCardAtIndex:(NSUInteger)index{
    
    // Logic for the Assignment Task #5 with 2 different game modes
    
    //Get the card which is going to be flipped
    Card *card = [self cardAtIndex:index];
    if (card && !card.isUnplayable){
        //card is not nil and is not already matched in another move
        if (!card.isFaceUp){
            //I'm actually flipping a card to see its face
            NSMutableArray *flippedCards = [[NSMutableArray alloc] init]; //array for the flipped up cards
            for (Card *otherCard in self.cards){
                //Add each of the flipped cards to the arrays
                if (otherCard.isFaceUp && !otherCard.isUnplayable) [flippedCards addObject:otherCard];
            }
            if (flippedCards.count < self.numOfMatchingCards - 1){
               //Nothing to do until numOfMatchingCards are flipped
                self.descriptionOfLastFlip = [NSString stringWithFormat:@"You've just fliped %@",card.contents];
            } else {
                //There are numOfMatchingCards flipped, time to see if the match
                int matchScore = [card matchAll: flippedCards];
                if (matchScore) {
                    //MATCH!
                    //Disable all flippedCards and give score
                    self.descriptionOfLastFlip = [NSString stringWithFormat:@"You've just matched %@ with", card.contents];
                    card.unplayable = YES;
                    for (Card *otherCard in flippedCards){
                        otherCard.unplayable = YES;
                        if ([flippedCards lastObject] == otherCard) self.descriptionOfLastFlip = [self.descriptionOfLastFlip stringByAppendingFormat:@" %@ ",otherCard.contents];
                        else self.descriptionOfLastFlip = [self.descriptionOfLastFlip stringByAppendingFormat:@" %@ and",otherCard.contents];
                    }
                    self.score += matchScore * MATCH_BONUS;
                    self.descriptionOfLastFlip = [self.descriptionOfLastFlip stringByAppendingFormat:@"for a score of %d points and a flip cost of %d point",matchScore * MATCH_BONUS, FLIP_COST];
                } else {
                    //MISMATCH!!!!
                    //Reset the play and give penalty
                    self.descriptionOfLastFlip = [NSString stringWithFormat:@"You've just mismatched %@ with", card.contents];
                    for (Card *otherCard in flippedCards){
                        otherCard.faceUp = NO;
                        if ([flippedCards lastObject] == otherCard) self.descriptionOfLastFlip = [self.descriptionOfLastFlip stringByAppendingFormat:@" %@ ",otherCard.contents];
                        else self.descriptionOfLastFlip = [self.descriptionOfLastFlip stringByAppendingFormat:@" %@ and",otherCard.contents];
                    }
                    self.score -= MISMATCH_PENALTY;
                    self.descriptionOfLastFlip = [self.descriptionOfLastFlip stringByAppendingFormat:@"for a penalty of %d points and a flip cost of %d point",MISMATCH_PENALTY, FLIP_COST];
                }
            }
        }
        else {
            //I'm flipping a card on its back so nothing to do with other cards
            self.descriptionOfLastFlip = @"You've just fliped back a card";
        }
        card.faceUp = !card.isFaceUp;
    }
    //End of logic for Task #5
    
    // Logic for the Assignment Task #4 changed to cope with the reality of 2 different game modes
    /*
    Card *card = [self cardAtIndex:index];
    if (card && !card.isUnplayable){
        //card is not nil and is not already matched in another move
        if (!card.isFaceUp){
            //I'm actually flipping a card to see its face 
            for (Card *otherCard in self.cards){
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    //There are now 2 cards facing up
                    int matchScore = [card match:otherCard];
                    if (matchScore) {
                        //There is a match
                        card.unplayable = YES;
                        otherCard.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        self.descriptionOfLastFlip = [NSString stringWithFormat:@"You've just matched %@ with %@ for %d points and a flip cost of %d point",card.contents, otherCard.contents, matchScore * MATCH_BONUS, FLIP_COST];
                    } else {
                        //There was another card facing up and didn't match the current card flipped
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.descriptionOfLastFlip = [NSString stringWithFormat:@"You've just mismatched %@ with %@ for a penalty of %d points and a flip cost of %d point",card.contents, otherCard.contents, MISMATCH_PENALTY, FLIP_COST];
                    }
                    break;
                }
                else {
                    //I'm flipping just one card
                    self.descriptionOfLastFlip = [NSString stringWithFormat:@"You've just fliped %@ for a flip cost of %d point",card.contents, FLIP_COST];
                }
            }
            self.score -= FLIP_COST;
        }
        else {
            //I'm flipping a card on its back so nothing to do with other cards
            self.descriptionOfLastFlip = @"You've just fliped back a card";
        }
        card.faceUp = !card.isFaceUp;
    }
    */
    //End of logic for Task #4
}

-(Card *)cardAtIndex:(NSUInteger)index{
    return (index < [self.cards count])? self.cards[index] : nil;
}
 
-(id)initWithCardCount:(NSUInteger)count
             usingDeck:(Deck *)deck {
    self = [super init];
    if(self){
        for (int i = 0;i < count;i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                self.cards[i] = card;
            }
            else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

@end
