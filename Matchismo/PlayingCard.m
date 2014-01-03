//
//  PlayingCard.m
//  card2
//
//  Created by SCB on 6/11/13.
//  Copyright (c) 2013 SCB. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if([otherCards count] == 1) {
        //lastObject method returns id type
        id otherCard = [otherCards lastObject];
        //Check what class is returned
        if([otherCard isKindOfClass:[PlayingCard class]]) {
            //if it is of PlayingCard class
            //Cast it anyway even if not needed to allow others to
            //know that it is of PlayingCard class
            PlayingCard *otherPlayingCard = (PlayingCard *)otherCard;
            if([otherPlayingCard.suit isEqualToString:self.suit]) {
                score = 1;
            }
            else if(otherPlayingCard.rank == self.rank) {
                score =4;
            }
        }
    }
    
    return score;
}

-(NSString *)contents
{
    //@[] creating Array on the fly
    //@"A" creating NSString on the fly
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; // because we provide setter AND getter

//Class methods
//For utility methods
+(NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

-(void)setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

-(NSString *)suit
{
    return _suit ? _suit : @"?";
}

+(NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSUInteger)maxRank { return [self rankStrings].count-1; }

-(void)setRank:(NSUInteger)rank
{
    if(rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
