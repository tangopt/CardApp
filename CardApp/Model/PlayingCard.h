//
//  PlayingCard.h
//  CardApp
//
//  Created by Pablo Dimenza on 28/08/13.
//  Copyright (c) 2013 Pablo Dimenza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validRanks;
+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
