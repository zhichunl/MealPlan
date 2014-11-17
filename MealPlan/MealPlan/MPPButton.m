//
//  MPPButton.m
//  MealPlan
//
//  Created by Isaac Lim on 11/16/14.
//  Copyright (c) 2014 X2YZ. All rights reserved.
//

#import "MPPButton.h"

static CGFloat const MPPButton_PaddingX = 40.0;
static CGFloat const MPPButton_PaddingY = 10.0;
static CGFloat const MPPButton_CornerRadius = 25.0;

@implementation MPPButton

+ (instancetype)button {
    return [MPPButton buttonWithType:UIButtonTypeCustom];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = MPPButton_CornerRadius;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 1.0;

        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];

    self.layer.borderColor = (highlighted ? [UIColor lightGrayColor] : [UIColor blackColor]).CGColor;
}

- (CGSize)intrinsicContentSize {
    CGSize superSize = [super intrinsicContentSize];
    return CGSizeMake(superSize.width + 2*MPPButton_PaddingX,
                      superSize.height + 2*MPPButton_PaddingY);
}

@end
