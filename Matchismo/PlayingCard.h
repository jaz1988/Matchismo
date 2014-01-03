//
//  PlayingCard.h
//  card2
//
//  Created by SCB on 6/11/13.
//  Copyright (c) 2013 SCB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
