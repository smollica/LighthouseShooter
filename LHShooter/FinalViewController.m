//
//  FinalViewController.m
//  LHShooter
//
//  Created by Monica Mollica on 2016-03-23.
//  Copyright © 2016 Sergio Mollica. All rights reserved.
//

#import "FinalViewController.h"
#import "StartViewController.h"

@interface FinalViewController ()
@property (nonatomic) UIImageView *background;
@property (weak, nonatomic) IBOutlet UIButton *replayButton;
@property (weak, nonatomic) IBOutlet UILabel *finalLabel;

@end

@implementation FinalViewController

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
    
    [self buttonMaker:self.replayButton];
    [self labelMaker:self.finalLabel];
    self.finalLabel.text = [[NSString alloc] initWithFormat:@"FINAL SCORE: %0.0f", self.game.score];
}

//BUTTONS

- (IBAction)replayButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"replay" sender:self];
}

//SEGUE

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    StartViewController *vc = segue.destinationViewController;
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
    [label setFont:[UIFont fontWithName:@"Futura-CondensedExtraBold" size:45]];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 5;
}

@end