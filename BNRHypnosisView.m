//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by Tom Anderson on 9/16/14.
//  Copyright (c) 2014 Maritom LLC. All rights reserved.
//

#import "BNRHypnosisView.h"

@interface BNRHypnosisView ()

@property (nonatomic, strong) UIColor *circleColor;

@end

@implementation BNRHypnosisView

- (void) setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor;
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGRect bounds = self.bounds;
    
    //Figure out the center of the bounds rectangle
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    // the largest circle will circumscribe teh view
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];

    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        [path moveToPoint: CGPointMake(center.x + currentRadius, center.y)];
        [path addArcWithCenter:center radius:currentRadius startAngle:0.0 endAngle:M_PI * 2 clockwise:YES];
    }
    // Configre line width to 10 points
    path.lineWidth = 10;
    [self.circleColor setStroke];
    
    // Draw the line
    [path stroke];
    
    // Let's put in a shadow
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext);
    CGContextSetShadow(currentContext, CGSizeMake(4, 7), 3);
    // Work with logo
    UIImage *logo = [UIImage imageNamed:@"320px-Batman_symbol.png"];
    CGRect logoBounds = CGRectMake(bounds.size.width/2.0 - logo.size.width/2.0, bounds.size.height/2.0 - logo.size.height/2.0, logo.size.width, logo.size.height);
    [logo drawInRect:logoBounds];
    CGContextRestoreGState(currentContext);
}

// When a finger touches the screen
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ was touched", self);
    
    // Get 3 random number between 0 and 1
    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    
    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.circleColor = randomColor;
}

@end
