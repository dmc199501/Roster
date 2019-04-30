//
//  ZKLDrawerController.m
//  ZKLDrawerController
//
//  Created by zkl on 2018/1/4.
//  Copyright © 2018年 zkl. All rights reserved.
//

#import "ZKLDrawerController.h"

static CGFloat LeftWidthScale     = 0.8f;
static CGFloat MaxCoverAlpha      = 0.3;
static CGFloat MinActionSpeed     = 500.0;
static CGFloat AnimationDuration  = 0.25;

@interface ZKLDrawerController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIViewController *centerVC;
@property (nonatomic, strong) UIViewController *leftVC;
//遮盖视图
@property (nonatomic, strong) UIView *coverView;
//每次滑动 中间视图的起始中心点的位置
@property (nonatomic, assign) CGPoint originalPoint;
//左边视图的宽度 默认是屏幕的80%宽
@property (nonatomic, assign, readonly) CGFloat leftWidth;
//留白宽度
@property (nonatomic, assign, readonly) CGFloat emptyWidth;

@end

@implementation ZKLDrawerController
#pragma mark - init
- (instancetype)initWithCenterViewController:(UIViewController *)centerVC leftViewController:(UIViewController *)leftVC {
    if (self = [super init]) {
        self.centerVC = centerVC;
        self.leftVC = leftVC;
    }
    return self;
}

#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configChildViewController];
    [self addPanTouch];
    [self addTapTouch];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateLeftViewFrame];
}

#pragma mark - private method
- (void)configChildViewController {
    [self addChildViewController:self.centerVC];
    [self addChildViewController:self.leftVC];
    
    self.centerVC.view.frame = self.view.bounds;
    self.leftVC.view.frame = CGRectMake(-self.leftWidth, 0, self.leftWidth, self.view.frame.size.height);
    
    [self.view addSubview:self.leftVC.view];
    [self.view addSubview:self.centerVC.view];
    [self.centerVC.view addSubview:self.coverView];
}

- (void)addTapTouch {
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    tapGR.numberOfTapsRequired = 1;
    tapGR.numberOfTouchesRequired = 1;
    [self.coverView addGestureRecognizer:tapGR];
}

- (void)addPanTouch {
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    panGR.delegate = self;
    [self.view addGestureRecognizer:panGR];
}

#pragma mark - touch event
-(void)tap {
    [self showCenterView];
}

-(void)pan:(UIPanGestureRecognizer *)sender {
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            self.originalPoint = self.centerVC.view.center;
            break;
        case UIGestureRecognizerStateChanged:
            [self moveWithPanGestureRecognizer:sender];
            break;
        case UIGestureRecognizerStateEnded:
            [self moveEndWithPanGestureRecognizer:sender];
            break;
        default:
            break;
    }
}

- (void)moveWithPanGestureRecognizer:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:self.view];
    self.centerVC.view.center = CGPointMake(self.originalPoint.x+translation.x, self.originalPoint.y);
    if ((!self.leftVC && CGRectGetMinX(self.centerVC.view.frame) >= 0) || CGRectGetMinX(self.centerVC.view.frame) < 0) {
        self.centerVC.view.frame = self.view.bounds;
    }
    if (CGRectGetMinX(self.centerVC.view.frame) > self.leftWidth) {
        CGFloat centerX = self.centerVC.view.frame.size.width/2+self.leftWidth;
        self.centerVC.view.center = CGPointMake(centerX, self.centerVC.view.center.y);
    }
    if (CGRectGetMinX(self.centerVC.view.frame) > 0) {
        [self updateLeftViewFrame];
        self.coverView.hidden = NO;
        self.coverView.alpha = CGRectGetMinX(self.centerVC.view.frame) / self.leftWidth * MaxCoverAlpha;
    }
}

- (void)moveEndWithPanGestureRecognizer:(UIPanGestureRecognizer *)sender {
    CGFloat speedX = [sender velocityInView:sender.view].x;
    if (ABS(speedX) > MinActionSpeed) {
        [self handleFastSliding:speedX];
        return;
    }
    if (CGRectGetMinX(self.centerVC.view.frame) > self.leftWidth/2) {
        [self showLeftView];
    }else {
        [self showCenterView];
    }
}

- (void)handleFastSliding:(CGFloat)speedX {
    BOOL slidRignt = speedX > 0;
    if (slidRignt) {
        [self showLeftView];
    }else {
        [self showCenterView];
    }
}

- (void)showCenterView {
    CGRect frame = self.centerVC.view.frame;
    frame.origin.x = 0;
    [UIView animateWithDuration:AnimationDuration animations:^{
        self.centerVC.view.frame = frame;
        [self updateLeftViewFrame];
        self.coverView.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.coverView.hidden = YES;
    }];
}

- (void)showLeftView {
    if (!self.leftVC) return;
    self.coverView.hidden = NO;
    [UIView animateWithDuration:AnimationDuration animations:^{
        CGFloat centerX = self.centerVC.view.frame.size.width/2+self.leftWidth;
        self.centerVC.view.center = CGPointMake(centerX, self.centerVC.view.center.y);
        self.leftVC.view.frame = CGRectMake(0, 0, self.leftWidth, self.view.frame.size.height);
        self.coverView.alpha = MaxCoverAlpha;
    }];
}

- (void)updateLeftViewFrame {
    CGFloat centerX = CGRectGetMinX(self.centerVC.view.frame)/2;
    self.leftVC.view.center = CGPointMake(centerX, self.centerVC.view.center.y);
}

#pragma mark - gestureRecognizer delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint location = [touch locationInView:self.view];
        if (location.x <= self.emptyWidth || location.x >= self.leftWidth ) {
            return YES;
        }else {
            return NO;
        }
    }
    return YES;
}

#pragma mark - getters & setters
- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:self.centerVC.view.bounds];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0.0;
        _coverView.hidden = YES;
    }
    return _coverView;
}

- (CGFloat)leftWidth {
    return self.view.frame.size.width*LeftWidthScale;
}

- (CGFloat)emptyWidth {
    return self.view.frame.size.width * (1 - LeftWidthScale);
}
@end
