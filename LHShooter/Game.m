//
//  Game.m
//  LHShooter
//
//  Created by Monica Mollica on 2016-03-20.
//  Copyright © 2016 Sergio Mollica. All rights reserved.
//

#import "Game.h"

@implementation Game

- (instancetype)init
{
    self = [super init];
    if (self) {
        _gameOver = NO;
    }
    return self;
}

- (void)startGame {
    if(self.difficulty == 1) {
        self.targetInteval = 1.00;
    } else if(self.difficulty == 2) {
        self.targetInteval = 0.75;
    } else {
        self.targetInteval = 0.50;
    }
    self.targetSpeed = self.targetInteval * 2.9;
}

- (void)createTargets {
    self.targetArray = [NSMutableArray new];
    NSInteger numberOfTargets = self.time / self.targetInteval;
    for (int i = 0; i < numberOfTargets; i++) {
        Target *target = [Target new];
        [self.targetArray addObject:target];
    }
}

- (void)scoreShot {
    if(self.target1.hit == YES) {
        self.score = self.score + self.target1.points;
        self.target1.points = 0;
    }
    if(self.target2.hit == YES) {
        self.score = self.score + self.target2.points;
        self.target2.points = 0;
    }
    if(self.target3.hit == YES) {
        self.score = self.score + self.target3.points;
        self.target3.points = 0;
    }
}

- (void)scoreMiss1 {
    if(self.target1.hit == NO) {
        self.score = self.score - self.target1.points/2;
    }
}

- (void)scoreMiss2 {
    if(self.target2.hit == NO) {
        self.score = self.score - self.target2.points/2;
    }
}

- (void)scoreMiss3 {
    if(self.target3.hit == NO) {
        self.score = self.score - self.target3.points/2;
    }
}

- (void)checkHighScore {
    if(self.score > self.highScore) {
        self.highScore = self.score;
    }
}

@end
