//
//  StartViewController.m
//  LHShooter
//
//  Created by Monica Mollica on 2016-03-22.
//  Copyright © 2016 Sergio Mollica. All rights reserved.
//

#import "StartViewController.h"
#import "Game.h"
#import "GameViewController.h"

@interface StartViewController ()
@property (nonatomic) UIImageView *background;
@property (weak, nonatomic) IBOutlet UILabel *gameLabel;
@property (weak, nonatomic) IBOutlet UIButton *startEasyButton;
@property (weak, nonatomic) IBOutlet UIButton *startMediumButton;
@property (weak, nonatomic) IBOutlet UIButton *startHardButton;
@property (nonatomic) Game *game;

@end


@implementation StartViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //GRAPHICS
    
    self.background = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.view insertSubview:self.background atIndex:0];
    self.background.image = [UIImage imageNamed:@"background"];
    self.background.userInteractionEnabled = YES;
    self.background.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.background
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.background
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.background
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.background
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self labelMaker:self.gameLabel];
    [self buttonMaker:self.startEasyButton];
    [self buttonMaker:self.startMediumButton];
    [self buttonMaker:self.startHardButton];
    self.gameLabel.text = @"LIGHTHOUSE SHOOTER";
    //self.gameLabel.text = @"HUSBAND SHOOTER";
}

// BUTTONS

- (IBAction)startEasyPressed:(id)sender {
    [self performSegueWithIdentifier:@"startEasy" sender:self];
}

- (IBAction)startMediumPressed:(id)sender {
    [self performSegueWithIdentifier:@"startMedium" sender:self];
}

- (IBAction)startHardPressed:(id)sender {
    [self performSegueWithIdentifier:@"startHard" sender:self];
}

//SEGUE

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    self.game = [Game new];
    self.game.time = 60;
    self.game.timeLeft = self.game.time;
    
    if([segue.identifier isEqualToString:@"startEasy"]) {
        self.game.difficulty = 1;
    } else if([segue.identifier isEqualToString:@"startMedium"]) {
        self.game.difficulty = 2;
    } else if([segue.identifier isEqualToString:@"startHard"]) {
        self.game.difficulty = 3;
    }
    
    [self.game startGame];
    [self.game createTargets];
    self.game.highScore = self.record;
    self.game.target1.finishPosition = 1000;
    self.game.target2.finishPosition = 1000;
    self.game.target3.finishPosition = 1000;
    
    GameViewController *vc = segue.destinationViewController;
    vc.game = self.game;
    vc.record = self.record;
}

//FORMATTING

- (void)buttonMaker:(UIButton*)button {
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button.backgroundColor = [UIColor grayColor];
    button.tintColor = [UIColor blackColor];
    button.alpha = 0.70;
    button.layer.borderColor = [UIColor redColor].CGColor;
    button.layer.borderWidth = 2;
    [button setFont:[UIFont fontWithName:@"Futura-CondensedExtraBold" size:22]];
    button.layer.cornerRadius = 10;
}

- (void)labelMaker:(UILabel*)label {
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.backgroundColor = [UIColor grayColor];
    label.textColor = [UIColor whiteColor];
    label.alpha = 0.85;
    label.layer.borderColor = [UIColor blackColor].CGColor;
    label.layer.borderWidth = 2;
    [label setFont:[UIFont fontWithName:@"Futura-CondensedExtraBold" size:22]];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 5;
}

@end
