//
//  Game.h
//  LHShooter
//
//  Created by Monica Mollica on 2016-03-20.
//  Copyright © 2016 Sergio Mollica. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Target.h"

@interface Game : NSObject

@property (nonatomic) NSInteger difficulty;
@property (nonatomic) NSInteger time;
@property (nonatomic) float timeLeft;
@property (nonatomic) float score;
@property (nonatomic) float highScore;
@property (nonatomic) float targetInteval;
@property (nonatomic) float targetSpeed;
@property (nonatomic) NSMutableArray *targetArray;
@property (nonatomic) Target *target1;
@property (nonatomic) Target *target2;
@property (nonatomic) Target *target3;
@property (nonatomic) BOOL gameOver;

- (void)startGame;

- (void)createTargets;

- (void)scoreShot;

- (void)scoreMiss1;

- (void)scoreMiss2;

- (void)scoreMiss3;

- (void)checkHighScore;

@end
