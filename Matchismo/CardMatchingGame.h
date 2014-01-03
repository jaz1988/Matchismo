//
//  CardMatchingGame.h
//  card2
//
//  Created by SCB on 7/11/13.
//  Copyright (c) 2013 SCB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

//Think of the public API first
//What can the card matching game do?

//Information that I need, how many cards?
//Designated intializer
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck*)deck;

//Flip the card up, check if match, flip card back
//Or increase the score
- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

//There is no setter, only getter in terms of public API
@property (readonly, nonatomic) int score;
@end
