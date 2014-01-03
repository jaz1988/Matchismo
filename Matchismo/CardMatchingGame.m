//
//  CardMatchingGame.m
//  card2
//
//  Created by SCB on 7/11/13.
//  Copyright (c) 2013 SCB. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (readwrite, nonatomic) int score;
@property (strong, nonatomic) NSMutableArray *cards; //of card (does not need to specify which type it is in the array)
@end

@implementation CardMatchingGame

//Lazy instantiaion
- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 2

- (void)flipCardAtIndex:(NSUInteger)index
{
    //Get the card at index
    Card *card = [self cardAtIndex:index];
    
    //Check if card is not nil and is playable
    if(card && !card.isUnplayable) {
        //Check through the card array to find cards that are face up and is still playable
        if(!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if(otherCard.isFaceUp && !otherCard.isUnplayable) {
                    //check if the card flipped and other card for match
                    int matchScore = [card match:@[otherCard]]; //Instantiate an array for parameters for match method using @[], in this case it is a 1 - size array
                    if(matchScore) {
                        //if returned matchScore > 0
                        //set both cards to unplayable
                        card.unplayable = YES;
                        otherCard.unplayable = YES;
                        
                        //add the score
                        self.score += matchScore * MATCH_BONUS;
                    }
                    else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                    }
                    break;
                }
            }
            self.score -= FLIP_COST;
        }
        //set face up value
        card.faceUp = !card.isFaceUp;
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    //Only return cards within the array
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if(self) {
        //Something can go wrong in this initializer
        for(int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if(card) {
            self.cards[i] = card;
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

@end
