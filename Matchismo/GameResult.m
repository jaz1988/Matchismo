//
//  GameResult.m
//  Matchismo
//
//  Created by SCB on 10/11/13.
//  Copyright (c) 2013 SCB. All rights reserved.
//

#import "GameResult.h"

@interface GameResult()
@property (readwrite, nonatomic) NSDate *start;
@property (readwrite, nonatomic) NSDate *end;
@end

@implementation GameResult

#define ALL_RESULTS_KEY @"GameResult_All"
#define START_KEY @"StartDate"
#define END_KEY @"EndDate"
#define SCORE_KEY @"Score"

+ (NSArray *)allGameResults
{
    NSMutableArray *allGameResults = [[NSMutableArray alloc]init];
    
    for (id plist in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] allValues]) {
        GameResult *result = [[GameResult alloc] initFromPropertyList:plist];
        [allGameResults addObject:result];
    }
    
    return allGameResults;
}

//convenience initalizer
- (id) initFromPropertyList:(id)plist
{
    self = [self init];
    if(self) {
        if([plist isKindOfClass:[NSDictionary class]]) {
            NSDictionary *resultsDictionary = (NSDictionary *)plist;
            _start = resultsDictionary[START_KEY];
            _end = resultsDictionary[END_KEY];
            _score = [resultsDictionary[SCORE_KEY] intValue];
            if(!_start || !_end) self = nil;
        }
    }
    return self;
}

- (void)synchronize
{
    //Write results to NSUserDefaults
    //Key: time when started
    NSMutableDictionary *mutableGameResultsFromUserDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] mutableCopy];
    if(!mutableGameResultsFromUserDefaults) mutableGameResultsFromUserDefaults = [[NSMutableDictionary alloc]init];
    mutableGameResultsFromUserDefaults[[self.start description]] = [self asPropertyList]; //method to turn game results into a propertylist
    [[NSUserDefaults standardUserDefaults] setObject:mutableGameResultsFromUserDefaults forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)asPropertyList
{
    return @{ START_KEY : self.start, END_KEY : self.end, SCORE_KEY : @(self.score) };
}

- (id) init
{
    self = [super init];
    if (self)
    {
        _start = [NSDate date];
        _end = _start;
    }
    return self;
}

- (NSTimeInterval)duration
{
    return [self.end timeIntervalSinceDate:self.start];
}

- (void)setScore:(int)score
{
    _score = score;
    self.end = [NSDate date];
    [self synchronize];
}
@end
