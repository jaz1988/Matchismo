//
//  Deck.h
//  card2
//
//  Created by SCB on 6/11/13.
//  Copyright (c) 2013 SCB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"


@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *)drawRandomCard;

@end
