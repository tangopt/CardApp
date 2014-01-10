//
//  SetPlayingCard.h
//  CardApp
//
//  Created by Pablo Dimenza on 09/09/13.
//  Copyright (c) 2013 Pablo Dimenza. All rights reserved.
//

#import "Card.h"

@interface SetPlayingCard : Card

@property (strong, nonatomic) NSString *rank;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) NSString *color;

+ (NSArray *) validSymbols;
+ (NSArray *) validShadings;
+ (NSArray *) validColors;
+ (NSArray *) validRanks;

- (NSString *) contents;
- (NSAttributedString *) formattedContents;
- (int) match:(SetPlayingCard *)otherCard;
- (int) match:(SetPlayingCard *)otherCard and:(SetPlayingCard *)anotherCard;

@end
