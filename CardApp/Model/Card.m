//
//  Card.m
//  CardApp
//
//  Created by Pablo Dimenza on 28/08/13.
//  Copyright (c) 2013 Pablo Dimenza. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int) match:(Card *)card{
//All subclasses of Card can implement a different algorithm for scoring the match, by default, if the contents are the same the score is 1.
    int score = 0;
    if ([card.contents isEqualToString:self.contents]) score = 1;

    return score;
}

//Returns the sum of the score of the matching of any card in the arrayOfCards, 0 if no card match
- (int) matchAny:(NSArray *)arrayOfCards{
    int score = 0;
    for (Card *card in arrayOfCards) {
        score += [self match:card];
    }
    return score;
}

//Return the score if matches all the cards in arrayOfCards or 0 if any of them does not match
- (int) matchAll:(NSArray *)arrayOfCards{
    int score = 0;
    for (Card *card in arrayOfCards) {
        int match = [self match:card];
        if (!match) {
            score = 0;
            break;
        }
        score += match;
    }
    return score;
}

//Description for Cards are their contents
- (NSString *) description{
    return [self contents];
}

@end
