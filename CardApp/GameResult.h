//
//  GameResult.h
//  CardApp
//
//  Created by Pablo Dimenza on 10/09/13.
//  Copyright (c) 2013 Pablo Dimenza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

@property (readonly, nonatomic) NSString *gameType;
@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (nonatomic) int score;
@property (readonly, nonatomic) NSTimeInterval duration;

// Designated initializer
-(id)initForGameType:(NSString *)gameType;

+ (NSArray *) allGameResults; //of GameResult

@end
