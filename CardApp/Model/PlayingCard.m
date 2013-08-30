//
//  PlayingCard.m
//  CardApp
//
//  Created by Pablo Dimenza on 28/08/13.
//  Copyright (c) 2013 Pablo Dimenza. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

+ (NSArray *)validSuits{
    return @[@"♥",@"♠",@"♦",@"♣"];
}
+ (NSArray *)validRanks{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"J",@"Q",@"K"];
}
+ (NSUInteger)maxRank{
    return [self validRanks].count - 1;
}

- (int) match:(PlayingCard *)otherCard{
    int score = 0;
    if ([otherCard.suit isEqualToString:self.suit]) score += 1;
    if (otherCard.rank == self.rank) score += 4;
    return score;

}

- (NSString *) contents {
    return [[[PlayingCard validRanks] objectAtIndex:self.rank] stringByAppendingString:self.suit];
}
- (void)setSuit:(NSString *)suit{
    
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}
- (NSString *) suit {
    return _suit ? _suit : @"?";
}
- (void) setRank:(NSUInteger)rank{
    if (rank <= [PlayingCard maxRank]) _rank = rank;
}

@end
