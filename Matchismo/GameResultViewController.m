//
//  GameResultViewController.m
//  Matchismo
//
//  Created by SCB on 10/11/13.
//  Copyright (c) 2013 SCB. All rights reserved.
//

#import "GameResultViewController.h"
#import "GameResult.h"

@interface GameResultViewController ()
@property (weak, nonatomic) IBOutlet UITextView *display;
@property (weak, nonatomic) IBOutlet UIButton *scoreLabel;

@end

@implementation GameResultViewController

-(void) viewDidLoad {
   [self.scoreLabel setTitle:NSLocalizedString(@"You like?", nil) forState:UIControlStateNormal];
}

- (void)updateUI
{
    NSString *displayText = @"";
    for (GameResult *result in [GameResult allGameResults]) {
        displayText = [displayText stringByAppendingFormat:@"Score: %d (%@, %0g", result.score, result.end, round(result.duration)];
    }
    self.display.text = displayText;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)setup
{
    //initialization that cant wait until viewDidLoad
}

- (void) awakeFromNib
{
    [self setup];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setup];
    return self;
}

@end
