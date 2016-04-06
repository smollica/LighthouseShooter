//
//  Target.m
//  LHShooter
//
//  Created by Monica Mollica on 2016-03-20.
//  Copyright © 2016 Sergio Mollica. All rights reserved.
//

#import "Target.h"

@implementation Target

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self typeGenerator];
        [self subTypeGenerator];
        [self startPositionGenerator];
        [self finishPositionGenerator];
        [self pointAssignment];
        _hit = NO;
    }
    return self;
}

- (void)typeGenerator  {
    NSInteger typePercent = arc4random_uniform(100);
    if(typePercent < 25) {
        self.type = 1;
    } else if (typePercent < 55) {
        self.type = 2;
    } else {
        self.type = 3;
    }
    //type 1 = instructor (25%);
    //type 2 = ta (30%);
    //type 3 = student (45%;
}

- (void)subTypeGenerator {
    if(self.type == 1){
        self.subType = arc4random_uniform(3)+1;
        if(self.subType == 1) {
            self.image = [UIImage imageNamed:@"danny"];
        } else if(self.subType == 2) {
            self.image = [UIImage imageNamed:@"cory"];
        } else {
            self.image = [UIImage imageNamed:@"nikita"];
        }
    } else if(self.type == 2) {
        self.subType = arc4random_uniform(5)+1;
        if(self.subType == 1) {
            self.image = [UIImage imageNamed:@"vita"];
        } else if(self.subType == 2) {
            self.image = [UIImage imageNamed:@"shahin"];
        } else if(self.subType == 3) {
            self.image = [UIImage imageNamed:@"sam"];
        } else if(self.subType == 4) {
            self.image = [UIImage imageNamed:@"tomta"];
        } else if(self.subType == 5) {
            self.image = [UIImage imageNamed:@"brett"];
        } else {
            self.image = [UIImage imageNamed:@"willow"];
        }
    } else {
        self.subType = arc4random_uniform(6)+1;
        if(self.subType == 1) {
            self.image = [UIImage imageNamed:@"serginho"];
        } else if(self.subType == 2) {
            self.image = [UIImage imageNamed:@"tiago"];
        } else if(self.subType == 3) {
            self.image = [UIImage imageNamed:@"tom"];
        } else if(self.subType == 4) {
            self.image = [UIImage imageNamed:@"rafael"];
        } else if(self.subType == 4) {
            self.image = [UIImage imageNamed:@"nelson"];
        } else {
            self.image = [UIImage imageNamed:@"sergio"];
        }
    }
}

- (void)startPositionGenerator {
    self.startPosition = arc4random_uniform(100)+1;
}

- (void)finishPositionGenerator {
    self.finishPosition = arc4random_uniform(100)+1;
}

- (void)pointAssignment {
    if(self.type == 1) {
        self.points = 100;
    } else if (self.type == 2){
        self.points = 50;
    } else {
        self.points = 25;
    }
}

@end