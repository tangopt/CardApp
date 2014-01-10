//
//  GameResult.m
//  CardApp
//
//  Created by Pablo Dimenza on 10/09/13.
//  Copyright (c) 2013 Pablo Dimenza. All rights reserved.
//

#import "GameResult.h"

@interface GameResult()
@property (readwrite, nonatomic) NSDate *start;
@property (readwrite, nonatomic) NSDate *end;
@end

@implementation GameResult

#define ALL_RESULTS_KEY @"GameResult_All"
#define START_KEY @"StarDate"
#define END_KEY @"EndDate"
#define SCORE_KEY @"Score"
#define GAMETYPE_KEY @"GameType"

+ (NSArray *) allGameResults{
    NSMutableArray *gameResults = [[NSMutableArray alloc] init];
    
    for (id plist in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] allValues]){
        GameResult *result = [[GameResult alloc] initFromPropertyList: plist];
        [gameResults addObject: result];
    }
    return gameResults;
}

// Designated initializer
-(id)initForGameType:(NSString *)gameType{
    self = [super init];
    if (self) {
        _start = [NSDate date];
        _end = _start;
        _gameType = gameType;
    }
    return self;
}


-(id)init{
    self = [super init];
    if (self) {
        _start = [NSDate date];
        _end = _start;
    }
    return self;
}

// Convenient initializer
-(id)initFromPropertyList:(id)plist{
    self = [super init];
    if(self){
        if ([plist isKindOfClass:[NSDictionary class]]){
            NSDictionary *resultDictionary = (NSDictionary *)plist;
            _start = resultDictionary[START_KEY];
            _end = resultDictionary[END_KEY];
            _score = [resultDictionary[SCORE_KEY] intValue];
            _gameType = resultDictionary[GAMETYPE_KEY];
            if (!_start || !_end) self =nil;
        }
    }
    return self;
}

- (NSTimeInterval)duration{
    return [self.end timeIntervalSinceDate: self.start];
}

// End is set when the score is set
- (void)setScore:(int)score{
    _score = score;
    self.end = [NSDate date];
    [self syncronize];
}

-(void)syncronize{
    NSMutableDictionary *mutableGameResultFromUserDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] mutableCopy];
    if(!mutableGameResultFromUserDefaults) mutableGameResultFromUserDefaults = [[NSMutableDictionary alloc] init];
    mutableGameResultFromUserDefaults[[self.start description]] = [self asPropertyList];
    [[NSUserDefaults standardUserDefaults] setObject:mutableGameResultFromUserDefaults forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
} 

-(id)asPropertyList{
    return @{START_KEY: self.start, END_KEY: self.end, SCORE_KEY: @(self.score), GAMETYPE_KEY: self.gameType};
}

@end
