//
//  GameViewController.m
//  LHShooter
//
//  Created by Monica Mollica on 2016-03-22.
//  Copyright © 2016 Sergio Mollica. All rights reserved.
//

#import "GameViewController.h"
#import "FinalViewController.h"

@interface GameViewController ()

@property (nonatomic) UITapGestureRecognizer *shoot;
@property (nonatomic) UIImageView *background;
@property (nonatomic) UIImageView *bulletView;
@property (nonatomic) UIImageView *bulletImage;
@property (nonatomic) UIImageView *targetView1;
@property (nonatomic) UIImageView *targetView2;
@property (nonatomic) UIImageView *targetView3;
@property (nonatomic) UILabel *hitPoints;
@property (nonatomic) UILabel *missPoints;
@property (nonatomic) NSInteger currentTarget;
@property (nonatomic) UIImageView *cover;
@property (nonatomic) CGFloat target1TransX;
@property (nonatomic) CGFloat target2TransX;
@property (nonatomic) CGFloat target3TransX;
@property (nonatomic) CGFloat target1TransY;
@property (nonatomic) CGFloat target2TransY;
@property (nonatomic) CGFloat target3TransY;
@property (nonatomic) UILabel *score;
@property (nonatomic) UILabel *highScore;
@property (nonatomic) UILabel *difficulty;
@property (nonatomic) UILabel *timer;
@property (nonatomic) NSTimer *fire;
@property (nonatomic) NSTimer *move;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //GRAPHICS
    
    self.background = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.background];
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
    
    self.cover = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.cover];
    self.cover.userInteractionEnabled = NO;
    self.cover.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.targetView1 = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.cover addSubview:self.targetView1];
    self.targetView1.userInteractionEnabled = YES;
    self.targetView1.translatesAutoresizingMaskIntoConstraints = NO;
    self.targetView1.backgroundColor = [UIColor clearColor];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.targetView1
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:80.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.targetView1
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:80.0]];
    
    self.targetView2 = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.cover addSubview:self.targetView2];
    self.targetView2.userInteractionEnabled = YES;
    self.targetView2.translatesAutoresizingMaskIntoConstraints = NO;
    self.targetView2.backgroundColor = [UIColor clearColor];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.targetView2
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.targetView1
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.targetView2
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.targetView1
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    self.targetView3 = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.cover addSubview:self.targetView3];
    self.targetView3.userInteractionEnabled = YES;
    self.targetView3.translatesAutoresizingMaskIntoConstraints = NO;
    self.targetView3.backgroundColor = [UIColor clearColor];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.targetView3
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.targetView1
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.targetView3
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.targetView1
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    //LABELS
    
    self.difficulty = [[UILabel alloc] initWithFrame:CGRectZero];
    if(self.game.difficulty == 1) {
        self.difficulty.text = @"EASY";
    } else if(self.game.difficulty == 2) {
        self.difficulty.text = @"MEDIUM";
    } else {
        self.difficulty.text = @"HARD";
    }
    [self.cover addSubview:self.difficulty];
    [self labelMaker:self.difficulty];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.difficulty
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:30.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.difficulty
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:160.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.difficulty
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.background
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.difficulty
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.background
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    self.score = [[UILabel alloc] initWithFrame:CGRectZero];
    self.score.text = [[NSString alloc] initWithFormat:@"SCORE %0.0f", self.game.score];
    [self.cover addSubview:self.score];
    [self labelMaker:self.score];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.score
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.difficulty
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.score
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.difficulty
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.score
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.background
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.score
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.background
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    self.highScore = [[UILabel alloc] initWithFrame:CGRectZero];
    self.highScore.text = [[NSString alloc] initWithFormat:@"RECORD %0.0f", self.record];
    [self.cover addSubview:self.highScore];
    [self labelMaker:self.highScore];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.highScore
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.difficulty
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.highScore
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.difficulty
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.highScore
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.background
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.highScore
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.background
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    self.timer = [[UILabel alloc] initWithFrame:CGRectZero];
    self.timer.text = [[NSString alloc] initWithFormat:@"TIME %0.0f", self.game.timeLeft];
    [self.cover addSubview:self.timer];
    [self labelMaker:self.timer];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.timer
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.difficulty
                                                          attribute:NSLayoutAttributeHeight
                                                         multiplier:1.0
                                                           constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.timer
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.difficulty
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.timer
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.background
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.timer
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.background
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    //TIMERS
    
    self.fire = [NSTimer scheduledTimerWithTimeInterval:self.game.targetInteval
                                     target:self
                                   selector:@selector(fireTarget)
                                   userInfo:nil
                                    repeats:YES];
    
    self.move = [NSTimer scheduledTimerWithTimeInterval:self.game.targetSpeed/100
                                     target:self
                                   selector:@selector(moveTarget)
                                   userInfo:nil
                                    repeats:YES];
    
    //GESTURES
    
    self.shoot = [[UITapGestureRecognizer alloc]
                  initWithTarget:self
                  action:@selector(tapShoot:)];
    
    [self.view addGestureRecognizer:self.shoot];
    
    //GAME RESOURCES
    
    self.currentTarget = 1;
}

//TIMER ACTIONS

- (void)fireTarget {
    if([self.game.targetArray count] > 0) {
        if(self.currentTarget == 1) {
            [self.game scoreMiss1];
            [self updateScore];
            
            if(self.game.target1.points != 0) {
                [self fireEachTarget:self.game.target1 andTargetView:self.targetView1];
            }
            
            self.game.target1 = [self.game.targetArray firstObject];
            self.target1TransX = (0-self.targetView1.bounds.size.width)/2;
            self.target1TransY = (self.game.target1.startPosition * (self.view.bounds.size.height - self.targetView1.bounds.size.width) / 100);
            self.targetView1.image = self.game.target1.image;
            self.targetView1.alpha = 1.0;
            [self.game.targetArray removeObjectAtIndex:0];
        
        } else if(self.currentTarget == 2) {
            [self.game scoreMiss2];
            [self updateScore];
            
            if(self.game.target2.points != 0) {
                [self fireEachTarget:self.game.target2 andTargetView:self.targetView2];
            }
            
            self.game.target2 = [self.game.targetArray firstObject];
            self.target2TransX = (0-self.targetView2.bounds.size.width)/2;
            self.target2TransY = (self.game.target2.startPosition * (self.view.bounds.size.height - self.targetView2.bounds.size.width) / 100);
            self.targetView2.image = self.game.target2.image;
            self.targetView2.alpha = 1.0;
            [self.game.targetArray removeObjectAtIndex:0];
            
        } else {
            [self.game scoreMiss3];
            [self updateScore];
            
            if(self.game.target3.points != 0) {
                [self fireEachTarget:self.game.target3 andTargetView:self.targetView3];
            }
            
            self.game.target3 = [self.game.targetArray firstObject];
            self.target3TransX = (0-self.targetView3.bounds.size.width)/2;
            self.target3TransY = (self.game.target3.startPosition * (self.view.bounds.size.height - self.targetView3.bounds.size.width) / 100);
            self.targetView3.image = self.game.target3.image;
            self.targetView3.alpha = 1.0;
            [self.game.targetArray removeObjectAtIndex:0];
            
        }
        self.currentTarget += 1;
        if(self.currentTarget == 4) {
            self.currentTarget = 1;
        }
    } else {
        self.game.gameOver = YES;
    }
}

- (void)moveTarget {
   
    self.target1TransX = self.target1TransX + (self.view.bounds.size.width-(0 - self.targetView1.bounds.size.width)/2)/100;
    self.target1TransY = self.target1TransY + ((self.game.target1.finishPosition * (self.view.bounds.size.height - self.targetView1.bounds.size.width) / 100)-(self.game.target1.startPosition * (self.view.bounds.size.height - self.targetView1.bounds.size.width) / 100))/100;
    self.targetView1.frame = CGRectMake(self.target1TransX, self.target1TransY, self.targetView1.frame.size.width, self.targetView1.frame.size.height);
    
    self.target2TransX = self.target2TransX + (self.view.bounds.size.width-(0 - self.targetView2.bounds.size.width)/2)/100;
    self.target2TransY = self.target2TransY + ((self.game.target2.finishPosition * (self.view.bounds.size.height - self.targetView2.bounds.size.width) / 100)-(self.game.target2.startPosition * (self.view.bounds.size.height - self.targetView2.bounds.size.width) / 100))/100;
    self.targetView2.frame = CGRectMake(self.target2TransX, self.target2TransY, self.targetView2.frame.size.width, self.targetView2.frame.size.height);
    
    self.target3TransX = self.target3TransX + (self.view.bounds.size.width-(0 - self.targetView3.bounds.size.width)/2)/100;
    self.target3TransY = self.target3TransY + ((self.game.target3.finishPosition * (self.view.bounds.size.height - self.targetView3.bounds.size.width) / 100)-(self.game.target3.startPosition * (self.view.bounds.size.height - self.targetView3.bounds.size.width)/ 100))/100;
    self.targetView3.frame = CGRectMake(self.target3TransX, self.target3TransY, self.targetView3.frame.size.width, self.targetView3.frame.size.height);
    if(self.game.timeLeft > 0) {
        self.game.timeLeft = self.game.timeLeft - self.game.targetSpeed/100;
        self.timer.text = [[NSString alloc] initWithFormat:@"TIME %0.0f", self.game.timeLeft];
    } else {
        self.game.timeLeft = 0;
        self.timer.text = [[NSString alloc] initWithFormat:@"GAME OVER"];
        
        UILabel *gameOver = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.cover addSubview:gameOver];
        [self labelMaker:gameOver];
        [gameOver setFont:[UIFont fontWithName:@"Futura-CondensedExtraBold" size:60]];
        gameOver.text = @"GAME OVER";
        gameOver.alpha = 0.0;
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:gameOver
                                                              attribute:NSLayoutAttributeCenterX
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeCenterX
                                                             multiplier:1.0
                                                               constant:0.0]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:gameOver
                                                              attribute:NSLayoutAttributeCenterY
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeCenterY
                                                             multiplier:1.0
                                                               constant:0.0]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:gameOver
                                                              attribute:NSLayoutAttributeWidth
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:1.0
                                                               constant:400.0]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:gameOver
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:1.0
                                                               constant:100.0]];
        
        [UIView animateWithDuration:2.0 animations:^{
            gameOver.alpha = 0.85;
        }];

       [NSTimer scheduledTimerWithTimeInterval:2.5
                                        target:self
                                      selector:@selector(endGame)
                                      userInfo:nil
                                       repeats:NO];
    }
    
    if(CGRectIntersectsRect(self.bulletView.frame, self.targetView1.frame) && self.game.target1.hit == NO) {
        self.bulletImage.image = [UIImage imageNamed:@"bullethit"];
        self.game.target1.hit = YES;
        self.targetView1.alpha = 0.0;
        self.hitPoints.text = [[NSString alloc] initWithFormat:@"+%0.0f", self.game.target1.points];
        self.missPoints = nil;
    } else if(CGRectIntersectsRect(self.bulletView.frame, self.targetView2.frame) && self.game.target2.hit == NO) {
        self.bulletImage.image = [UIImage imageNamed:@"bullethit"];
        self.game.target2.hit = YES;
        self.targetView2.alpha = 0.0;
        self.hitPoints.text = [[NSString alloc] initWithFormat:@"+%0.0f", self.game.target2.points];
        self.missPoints = nil;
    } else if(CGRectIntersectsRect(self.bulletView.frame, self.targetView3.frame) && self.game.target3.hit == NO) {
        self.bulletImage.image = [UIImage imageNamed:@"bullethit"];
        self.game.target3.hit = YES;
        self.targetView3.alpha = 0.0;
        self.hitPoints.text = [[NSString alloc] initWithFormat:@"+%0.0f", self.game.target3.points];
        self.missPoints = nil;
    } else if(!(CGRectIntersectsRect(self.bulletView.frame, self.targetView1.frame) && self.game.target1.hit == NO) && !(CGRectIntersectsRect(self.bulletView.frame, self.targetView2.frame) && self.game.target2.hit == NO) && !(CGRectIntersectsRect(self.bulletView.frame, self.targetView3.frame) && self.game.target3.hit == NO)) {
        self.bulletImage.image = [UIImage imageNamed:@"bulletmiss"];
    } else {
        self.bulletImage.image = nil;
    }
    
    [self.game scoreShot];
    [self.game checkHighScore];
    [self updateScore];
    
    [UIView animateWithDuration:1.5 animations:^{
        self.bulletImage.alpha = 0.0;
        self.hitPoints.alpha = 0.0;
        self.bulletView = nil;
        self.bulletImage = nil;
    }];
}

//GESTURES

- (void)tapShoot:(UIPanGestureRecognizer*)recognizer {
    self.bulletView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.bulletView.userInteractionEnabled = YES;
    self.bulletView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.bulletView];
    
    CGFloat shootLocationX = [recognizer locationInView:self.view].x - self.view.bounds.size.width/2;
    CGFloat shootLocationY = [recognizer locationInView:self.view].y - self.view.bounds.size.height/2;
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bulletView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:shootLocationX+5]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bulletView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:shootLocationY]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bulletView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:15.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bulletView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:15.0]];
    
    self.bulletImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.bulletImage.userInteractionEnabled = YES;
    self.bulletImage.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.bulletImage];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bulletImage
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:shootLocationX]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bulletImage
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:shootLocationY]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bulletImage
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:65.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bulletImage
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:65.0]];
    
    self.hitPoints = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.hitPoints];
    [self hitPointsMaker:self.hitPoints];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.hitPoints
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:25.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.hitPoints
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:50.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.hitPoints
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.bulletImage
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.hitPoints
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.bulletImage
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.0
                                                           constant:0.0]];
}

//LABELS

- (void)updateScore {
    self.score.text = [[NSString alloc] initWithFormat:@"SCORE %0.0f", self.game.score];
    if(self.game.score > self.record) {
        self.highScore.text = [[NSString alloc] initWithFormat:@"RECORD %0.0f", self.game.highScore];
        self.record = self.game.highScore;
    } else {
        self.highScore.text = [[NSString alloc] initWithFormat:@"RECORD %0.0f", self.record];
    }
}

//END GAME

- (void)endGame {
    [self.fire invalidate];
    self.fire = nil;
    [self.move invalidate];
    self.move = nil;
    [self performSegueWithIdentifier:@"lastScreen" sender:self];
}

//SEGUE

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"lastScreen"]) {
        FinalViewController *vc = segue.destinationViewController;
        vc.game = self.game;
        vc.record = self.record;
    }
}

//FORMATTING

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

- (void)hitPointsMaker:(UILabel*)label {
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.textColor = [UIColor blackColor];
    [label setFont:[UIFont fontWithName:@"Futura-CondensedExtraBold" size:20]];
    label.textAlignment = NSTextAlignmentCenter;
}

//REPETITION

-(void)fireEachTarget:(Target*)target andTargetView:(UIImageView*)targetView {
        self.missPoints = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.view addSubview:self.missPoints];
        [self hitPointsMaker:self.missPoints];
        self.missPoints.textColor = [UIColor redColor];
        self.missPoints.text = [[NSString alloc] initWithFormat:@"-%0.0f", target.points/2];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.missPoints
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:1.0
                                                               constant:25.0]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.missPoints
                                                              attribute:NSLayoutAttributeWidth
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:1.0
                                                               constant:50.0]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.missPoints
                                                              attribute:NSLayoutAttributeRight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1.0
                                                               constant:0.0]];
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.missPoints
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:(target.finishPosition * (self.view.bounds.size.height - targetView.bounds.size.width) / 100) + targetView.bounds.size.width/2]];
        
        [UIView animateWithDuration:1.5 animations:^{
            self.missPoints.alpha = 0.0;
        }];
    }

@end
