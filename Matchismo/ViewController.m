//
//  ViewController.m
//  Matchismo
//
//  Created by SCB on 10/11/13.
//  Copyright (c) 2013 SCB. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "GameResult.h"
#import "Social/Social.h"
#import "Accounts/Accounts.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) int flipCount;
@property (strong,nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) GameResult *gameResult;
@end

@implementation ViewController

- (GameResult *)gameResult
{
    if(!_gameResult) _gameResult = [[GameResult alloc]init];
    return _gameResult;
}

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc]initWithCardCount:[self.cardButtons count]
                                                         usingDeck:[[PlayingCardDeck alloc]init]];
    
    return _game;
}

//Setter for cardButtons
- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI
{
    //Controller's fundamental job to make the model match the UI
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.unplayable ? 0.3 : 1.0);
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    self.gameResult.score = self.game.score;
    
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
    
//    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
//    
//    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierSinaWeibo];
//    
//    [accountStore requestAccessToAccountsWithType:accountType options:nil
//                                       completion:^(BOOL granted, NSError *error) {
//        
//        ACAccount *account = [[ACAccount alloc] initWithAccountType:accountType];
//        
//        NSLog(@"%@, %@", account.username, account.description);
//        
//    }];
    
//    if(true) {
//        
//        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
//        
//        SLComposeViewControllerCompletionHandler myBlock = ^(SLComposeViewControllerResult result){
//            
//            if (result == SLComposeViewControllerResultCancelled) {
//                
//                NSLog(@"Cancelled");
//                
//            } else
//                
//            {
//                
//                NSLog(@"Done");
//                
//            }
//            
//            [controller dismissViewControllerAnimated:YES completion:Nil];
//            
//        };
//        
//        controller.completionHandler =myBlock;
//        
//        [controller setInitialText:@"Test Post from mobile.safilsunny.com"];
//        
//        [controller addURL:[NSURL URLWithString:@"http://www.mobile.safilsunny.com"]];
//        
//        [controller addImage:[UIImage imageNamed:@"sw.png"]];
//        
//        [self presentViewController:controller animated:YES completion:Nil];
//        
//    }
//    
//    else{
//        
//        NSLog(@"UnAvailable");
//        
//    }
//    
//    [self postToSocialMedia:SLServiceTypeSinaWeibo];
//    
//    BOOL result = NO;
//    
//    if (NSClassFromString(@"TWTweetComposeViewController")) {
//        result = YES;
//    }
//    
//    NSLog(result ? @"Yes" : @"No");
    
    BOOL result = FALSE;
    //Get all the active input languages from the phone
    NSArray *items = [UITextInputMode activeInputModes];
    
    //Set the strings that need to be matched
    NSArray *languagesToCheck = [NSArray arrayWithObjects:@"zh-Hans",@"zh-Hant",nil];
    
    //Iterate through the items and find out the language
    for (UITextInputMode *item in items) {
        NSString *language = [[items objectAtIndex:[items indexOfObject:item]] primaryLanguage];
        NSLog(@"Language: %@",language);
        
        //Check for:
        //Chinese Simplified: @"zh-Hans"
        //Chinese Traditional: @"zh-Hant"
        //As long as there is 1 match, break the loop
        for (NSString *checkChinese in languagesToCheck) {
            if([checkChinese isEqualToString:language]) {
                //Matched
                NSLog(@"MATCHED");
                goto MATCHED;
            }
            else NSLog(@"NOT MATCHED");
        }
    }
    MATCHED: result = TRUE;
    
    // check whether Sina Weibo is installed or not
    NSString *wbURI = @"sinaweibo://";
    NSURL *url = [NSURL URLWithString:wbURI];
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        // Safe to launch the facebook app
        [[UIApplication sharedApplication] openURL:url];
    }
    else NSLog(@"NO SINA WEIBO APP INSTALLED");
    //Sina Weibo URI scheme: sinaweibo
    
//    [WeiboSDK registerApp:@"89214124"];
//    test
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ROFL"
                                                    message:@"Dee dee doo doo."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateFormat:@"MMM d, yyyy h:mm a"];
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:118800];
    NSLocale *frLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"];
    [dateFormatter setLocale:frLocale];
    NSLog(@"Date for locale %@: %@",
          [[dateFormatter locale] localeIdentifier], [dateFormatter stringFromDate:date]);
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
    if (buttonIndex == 0) {
        // do something here...
        NSLog(@"lalala");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=General"]];
    }
}

- (IBAction)deal {
    self.game = nil;
    self.gameResult = nil;
    self.flipCount = 0;
    [self updateUI];
}

- (BOOL)postToSocialMedia:(NSString *)serviceType {
    
    NSString *message = [NSString stringWithFormat:
                         @"Just had a %@! Overall rating: %d/100.",
                         @"Name",
                         100];
    
//    UIImage *image = [[UIImage alloc] initWithData:[UIImage imageNamed:@"sw.png"]];
//    NSAssert(image != nil, @"Failed to load image.");
    
    if (![SLComposeViewController isAvailableForServiceType:serviceType]) {
        [self displayErrorDialogWithTitle:@"Error" message:@"Social media is not available. It is quite possible that you do not have the corresponding app installed, or that you have not set it up properly."];
        return NO;
    }
    
    SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:serviceType];
    
    if (![controller setInitialText:message]) {
        [self displayErrorDialogWithTitle:@"Error" message:@"Failed to construct the message."];
    }
    
    [controller addImage:[UIImage imageNamed:@"sw.png"]];
//    if (image) {
//        if (![controller addImage:[UIImage imageNamed:@"sw.png"]]) {
//            [self displayErrorDialogWithTitle:@"Error" message:@"Failed to attach the image to the message."];
//        }
//    }
    
    [self presentViewController:controller animated:YES completion:nil];
    
    return YES;
}

- (void)displayErrorDialogWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}


@end
