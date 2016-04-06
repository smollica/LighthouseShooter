//
//  Target.h
//  LHShooter
//
//  Created by Monica Mollica on 2016-03-20.
//  Copyright © 2016 Sergio Mollica. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Target : NSObject

@property (nonatomic) NSInteger type;
@property (nonatomic) NSInteger subType;
@property (nonatomic) NSInteger startPosition;
@property (nonatomic) NSInteger finishPosition;
@property (nonatomic) float points;
@property (nonatomic) UIImage *image;
@property (nonatomic) BOOL hit;

@end
