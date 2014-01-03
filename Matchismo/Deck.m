//
//  Deck.m
//  card2
//
//  Created by SCB on 6/11/13.
//  Copyright (c) 2013 SCB. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards; //of Card
@end

@implementation Deck

//Implement the Getter so the compiler will not do the implementation
//Lazy instantiation
-(NSMutableArray *)cards
{
    //Ensure that self.cards will never return a nil
    //init should always be nested with alloc, do not seperate them
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if(card) {
        if(atTop) {
            [self.cards insertObject:card atIndex:0];
        }
        else {
            [self.cards addObject:card];
        }
    }
}

//Choose 1 random card from the deck that we have (NSMutableArray)
-(Card *)drawRandomCard
{
    //Local variables start out as 0,nil
    Card *randomCard = nil;
    
    if(self.cards.count) {
        unsigned index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
    
}

@end
