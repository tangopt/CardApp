//
//  Card.h
//  CardApp
//
//  Created by Pablo Dimenza on 28/08/13.
//  Copyright (c) 2013 Pablo Dimenza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject 

@property (strong,nonatomic) NSString *contents;

@property (nonatomic, getter=isFaceUp) BOOL faceUp;
@property (nonatomic, getter=isUnplayable) BOOL unplayable;

- (int) match:(Card *)card;
- (int) matchAny:(NSArray *)arrayOfCards;
- (int) matchAll:(NSArray *)arrayOfCards;

@end
