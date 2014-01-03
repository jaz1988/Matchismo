//
//  GameResult.h
//  Matchismo
//
//  Created by SCB on 10/11/13.
//  Copyright (c) 2013 SCB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

+ (NSArray *)allGameResults;

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (nonatomic) int score; //Score is not readonly, dynamic


@end
