//
//  PlayingCardDeck.m
//  card2
//
//  Created by SCB on 6/11/13.
//  Copyright (c) 2013 SCB. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

-(id)init
{
    //Create the 52 playing cards
    self = [super init];
    
    if(self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for(NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card atTop:YES];
            }
        }
    }
    
    return self;
}

@end
