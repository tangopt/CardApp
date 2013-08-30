//
//  Deck.h
//  CardApp
//
//  Created by Pablo Dimenza on 28/08/13.
//  Copyright (c) 2013 Pablo Dimenza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (Card *)drawRandomCard;

@end
