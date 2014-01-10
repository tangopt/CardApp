//
//  SetPlayingCard.m
//  CardApp
//
//  Created by Pablo Dimenza on 09/09/13.
//  Copyright (c) 2013 Pablo Dimenza. All rights reserved.
//

#import "SetPlayingCard.h"

@implementation SetPlayingCard

NSString *const COLOR_1 = @"red";
NSString *const COLOR_2 = @"green";
NSString *const COLOR_3 = @"blue";
NSString *const SHADING_1 = @"solid";
NSString *const SHADING_2 = @"striped";
NSString *const SHADING_3 = @"open";


//  Class methods implementations to get the general informations about a Set playing card such as the possible ranks, symbols, shadings and colors.
+ (NSArray *) validRanks {
    return @[@"1",@"2",@"3"];
}

+ (NSArray *)validSymbols {
    return @[@"▲",@"■",@"●"];
}

+ (NSArray *)validShadings {
    return @[SHADING_1,SHADING_2,SHADING_3];
}

+ (NSArray *)validColors {
    return @[COLOR_1,COLOR_2,COLOR_3];
}

// Instance methods

// Setters validate that the values are permitted
- (void) setRank:(NSString *)rank{
    if ([[[self class] validRanks] containsObject:rank]) _rank = rank;
}
- (void) setSymbol:(NSString *)symbol{
    if ([[[self class] validSymbols] containsObject:symbol]) _symbol = symbol;
}
- (void) setShading:(NSString *)shading{
    if ([[[self class] validShadings] containsObject:shading]) _shading = shading;
}
- (void) setColor:(NSString *)color{
    if ([[[self class] validColors] containsObject:color]) _color = color;
}

// Here is the logic to match other card, however, since the logic of the Set game matches a set of 3 cards with the same relationship (equal or different in all the attributes), exists the need for a much useful match:otherCard and:anotherCard. The match:otherCard method is for the (too easy) 2-card mode.

- (BOOL) isEqualToSetPlayingCard:(SetPlayingCard *)otherCard{
    return ([otherCard.rank isEqualToString:self.rank] &&
            [otherCard.symbol isEqualToString:self.symbol] &&
            [otherCard.shading isEqualToString:self.shading] &&
            [otherCard.color isEqualToString:self.color]);
}

- (BOOL) isAllDifferentToSetPlayingCard:(SetPlayingCard *)otherCard{
    return (![otherCard.rank isEqualToString:self.rank] &&
            ![otherCard.symbol isEqualToString:self.symbol] &&
            ![otherCard.shading isEqualToString:self.shading] &&
            ![otherCard.color isEqualToString:self.color]);
}


- (int) match:(SetPlayingCard *)otherCard{
    int score = 0;
    if (//all atttributes are equal
        [self isEqualToSetPlayingCard:otherCard]
        ||
        //or all attributes are different
        [self isAllDifferentToSetPlayingCard:otherCard])
        score += 1;
    return score;
}

- (int) match:(SetPlayingCard *)otherCard and:(SetPlayingCard *)anotherCard{
    int score = 0;

    if (//all atttributes are equal, if A=B and A=C then B=C
        ([self isEqualToSetPlayingCard:otherCard] &&
         [self isEqualToSetPlayingCard:anotherCard])
        ||
        //or all attributes are different. in this case we also have to check other card with anothercard. if A<>B and A<>C cannot say that B<>C
        ([self isAllDifferentToSetPlayingCard:otherCard] &&
         [self isAllDifferentToSetPlayingCard:anotherCard] &&
         [otherCard isAllDifferentToSetPlayingCard:anotherCard]))
        score += 1;
    
     return score;
}

- (int) matchAll:(NSArray *)arrayOfCards{
    
    int score = 0;
    if (arrayOfCards.count == 2) score += [self match: arrayOfCards[0] and: arrayOfCards[1]];
    if (arrayOfCards.count == 1) score += [self match: arrayOfCards[0]];
      
    return score;
}

- (NSString *) contents{
    //Basic model of contents, just the face with the attributes following, like "▲▲▲ solid green"
    NSString *content = @"";
    for (int i = 0; i < [[self rank] intValue]; i++){
        content = [content stringByAppendingString: [self symbol]];
    }
    content = [content stringByAppendingString: @" "];
    content = [content stringByAppendingString: [self shading]];
    content = [content stringByAppendingString: @" "];
    content = [content stringByAppendingString: [self color]];
    return content;
}

- (NSAttributedString *) formattedContents{
    //Advanced model of contents, with the actual face of the card using NSAttributedString.
    //Can be implemented on the Controller instead of the model using the Class valid* methods and the getters of each card
    //DOES THIS VIOLATES MVC??? INTENDED TO BE IMPLEMENTED IN THE CONTROLLER???
    
    //Setting the color of the text, using ifs instead of switch statements because switch does not work on strings.
    //Black is the default color in case there is no color setted
    //Have to set the foregroung color and the stroke color for the open and striped shading options
    UIColor *color = [UIColor blackColor];
    if ([self color] == COLOR_1) color = [UIColor redColor];
    else if ([self color] == COLOR_2) color = [UIColor greenColor];
    else if ([self color] == COLOR_3) color = [UIColor blueColor];
   
    //Setting the shading of the text, again, using ifs instead of switch statements because switch does not work on strings
    //Have to set the stroke with to -5 (inner stroke) and using the alpha component to set the shading, 1.0 for solid, 0.5 for striped and 0.0 for open.
    if ([self shading] == SHADING_1) color = [color colorWithAlphaComponent:1.0];
    else if ([self shading] == SHADING_2) color = [color colorWithAlphaComponent:0.5];
    else if ([self shading] == SHADING_3) color = [color colorWithAlphaComponent:0.0];
    
    NSDictionary *attributes = @{NSStrokeWidthAttributeName: @-5,
                                 NSForegroundColorAttributeName: color,
                                 NSStrokeColorAttributeName: [color colorWithAlphaComponent:1.0]};
    
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] init];
    //Repeat the symbol as much times as the number
    for (int i = 0; i < [[self rank] intValue]; i++){
           [content appendAttributedString: [[NSAttributedString alloc] initWithString: [self symbol]]];
    }
    [content addAttributes:attributes range:(NSRange){0,[content length]}];
    return content;
}


@end
