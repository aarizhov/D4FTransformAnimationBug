//
//  ViewController.m
//  D4FTransformAnimationBug
//
//  Created by Artem Ryzhov on 3/29/17.
//  Copyright © 2017 Artem Ryzhov. All rights reserved.
//

#import "ViewController.h"


//UIView Animation Jumps at beginning bug.
@interface ViewController (){
    UIView* _view;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _view = [[UIView alloc] initWithFrame:CGRectMake(-50, -50, 100, 100)];
    _view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_view];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    static CGFloat angle = 0.0;
    angle += 90;                    // if don't use change angle, all works fine
    for (UITouch *touch in touches)
    {
        CGPoint point = [touch locationInView:self.view];
        [UIView animateWithDuration:0.5
                         animations:^{
                             _view.transform = CGAffineTransformConcat(CGAffineTransformMakeRotation((angle * M_PI)/180.0f),
                                                                       CGAffineTransformMakeTranslation(point.x, point.y));
                         }];
        break;
    }
}

/*
//UIView Animation Resolve
@interface ViewController ()
{
    UIView* _view;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _view = [[UIView alloc] initWithFrame:CGRectMake(-50, -50, 100, 100)];
    _view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_view];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    static CGFloat angle = 0.0;
    static CGPoint previouslyPosition;
    static CGFloat previouslyAngle;
    angle += 90;
    for (UITouch *touch in touches)
    {
        CGPoint point = [touch locationInView:self.view];
        CGAffineTransform transformSource = CGAffineTransformConcat(CGAffineTransformMakeRotation((previouslyAngle * M_PI)/180.0f),
                                                                    CGAffineTransformMakeTranslation(previouslyPosition.x, previouslyPosition.y));
        CGAffineTransform transformDesctination = CGAffineTransformConcat(CGAffineTransformMakeRotation((angle * M_PI)/180.0f),
                                                                          CGAffineTransformMakeTranslation(point.x, point.y));
        //for resolve "Jumps at beginning bug" we use Key frames animation
        [UIView animateKeyframesWithDuration:0.5
                                       delay:0.0
                                     options:0
                                  animations:^{
                                      [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.01
                                                                    animations:^{
                                                                        _view.transform = transformSource;
                                                                    }];
                                      
                                      [UIView addKeyframeWithRelativeStartTime:0.01 relativeDuration:0.99
                                                                    animations:^{
                                                                        _view.transform = transformDesctination;
                                                                    }];
                                  }
                                  completion:^(BOOL finished){
                                  }];
        previouslyPosition = point;
        previouslyAngle = angle;
        break;
    }
}
*/
@end
