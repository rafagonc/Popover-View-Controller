//
//  PopoverViewController.m
//  PopoverLab
//
//  Created by Rafael Gonzalves on 3/5/15.
//  Copyright (c) 2015 Rafael Gonzalves. All rights reserved.
//

#import "PopoverViewController.h"


@interface PopoverViewControllerTransitionAnimator : NSObject <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning> {
    id<UIViewControllerContextTransitioning> context;
}@end
@interface PopoverViewController ()
@property (nonatomic,strong) PopoverViewControllerTransitionAnimator *animator;
@property (nonatomic) BOOL shouldLayoutSubviews;
@end
@interface PopoverViewControllerTransitionAnimator ()

@property (nonatomic,strong) PopoverViewController *popover;
@property (nonatomic) BOOL presenting;

#pragma mark - Customization
@property (nonatomic) PopoverViewControllerAnimationType animationType;
@property (nonatomic) BOOL shouldObfuscateSourceViewController;
@property (nonatomic) BOOL shouldDismissOnBackgroundTap;
@property (nonatomic) CGFloat duration;
@property (nonatomic) CGFloat obfuscationAlpha;
@property (nonatomic) CGSize size;
@property (nonatomic) BOOL shouldLayoutSubviews;
@property (nonatomic,readonly) CGRect frame;

#pragma mark - User Interface
@property (nonatomic,strong) UIView *obfuscationView;

@end
@implementation PopoverViewControllerTransitionAnimator

#pragma mark - Constructors
-(instancetype)init {
    self = [super init];
    if (self) {
        self.presenting = YES;
    }
    return self;
}

#pragma mark - Animation Delegate

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.presenting = NO;
    return self;
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.presenting = YES;
    return self;
}
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    switch (self.animationType) {
        case PopoverViewControllerAnimationTypeCoverVertical:
            [self coverVerticalAnimationWithTransitionContext:transitionContext];
            break;
        case PopoverViewControllerAnimationTypeCrossDissolve:
            [self crossDissolveAnimationWithTransitionContext:transitionContext];
            break;
        default:
            [self coverVerticalAnimationWithTransitionContext:transitionContext];
            break;
    }

}

#pragma mark - Animation Types
-(void)coverVerticalAnimationWithTransitionContext:(id <UIViewControllerContextTransitioning>)transitionContext {
    context = transitionContext;
    UIView *container = [transitionContext containerView];
    UIViewController *destinationViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *sourceViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    self.shouldLayoutSubviews = NO;

    
    if (self.presenting) {
        [container addSubview:destinationViewController.view];
        destinationViewController.view.frame = CGRectMake(screenBounds.size.width/2 - self.frame.size.width/2, screenBounds.size.height + 70, self.frame.size.width, self.frame.size.height);
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:.8 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            destinationViewController.view.frame = self.frame;
            [self obfuscateViewController:container];
            [container bringSubviewToFront:destinationViewController.view];
        } completion:^(BOOL finished) {
            self.shouldLayoutSubviews = YES;
            [transitionContext completeTransition:finished];
        }];
    } else {
        [container addSubview:sourceViewController.view];
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:.8 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            sourceViewController.view.frame = CGRectMake(screenBounds.size.width/2 - self.frame.size.width/2, screenBounds.size.height + 70, self.frame.size.width, self.frame.size.height);
            [self unobfuscateViewController:container];

        } completion:^(BOOL finished) {
            self.shouldLayoutSubviews = YES;
            [transitionContext completeTransition:finished];
        }];
    }
    

}
-(void)crossDissolveAnimationWithTransitionContext:(id <UIViewControllerContextTransitioning>)transitionContext {
    context = transitionContext;
    UIView *container = [transitionContext containerView];
    UIViewController *sourceViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *destinationViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    if (self.presenting) {
        [container addSubview:destinationViewController.view];
        destinationViewController.view.frame = self.frame;
        destinationViewController.view.alpha = 0;
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:.8 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            destinationViewController.view.alpha = 1;
            [self obfuscateViewController:container];
            [container bringSubviewToFront:destinationViewController.view];
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:finished];
        }];


    } else {
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:.8 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            sourceViewController.view.alpha = 0;
            [self unobfuscateViewController:container];
            [container bringSubviewToFront:sourceViewController.view];
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:finished];
            sourceViewController.view.alpha = 1;
        }];
    }
}

#pragma mark - Getters And Setters
-(CGRect)frame {
    return CGRectMake([UIScreen mainScreen].bounds.size.width/2 - self.size.width/2, [UIScreen mainScreen].bounds.size.height/2 - self.size.height/2 , self.size.width, self.size.height);
}
-(void)setShouldLayoutSubviews:(BOOL)shouldLayoutSubviews {
    _shouldLayoutSubviews = shouldLayoutSubviews;
    [self.popover setShouldLayoutSubviews:shouldLayoutSubviews];
}

#pragma mark - Methods
-(void)obfuscateViewController:(UIView *)view {
    self.obfuscationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 1000)];
    self.obfuscationView.backgroundColor = self.shouldObfuscateSourceViewController ? [UIColor blackColor] : [UIColor clearColor];
    self.obfuscationView.alpha = 0.0;
    [view addSubview:self.obfuscationView];
    [UIView animateWithDuration:self.duration animations:^{
        self.obfuscationView.alpha = self.obfuscationAlpha;
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissByTappingBackground)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    [self.obfuscationView addGestureRecognizer:tap];
}
-(void)unobfuscateViewController:(UIView *)view {
    [view addSubview:self.obfuscationView];
    [UIView animateWithDuration:self.duration animations:^{
        self.obfuscationView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.obfuscationView removeGestureRecognizer:self.obfuscationView.gestureRecognizers.firstObject];
        [self.obfuscationView removeFromSuperview];
    }];
    
}

#pragma mark - Actions
-(void)dismissByTappingBackground {
    if (self.shouldDismissOnBackgroundTap) {
        [[context viewControllerForKey:UITransitionContextToViewControllerKey] dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
@implementation PopoverViewController

#pragma mark - Constructor
-(instancetype)init {
    if (self = [super init]) {
        [self commonInit];
        self.size = CGSizeMake(280, 400);
    } return self;
}
-(instancetype)initWithSize:(CGSize)size {
    if (self = [super init]) {
        [self commonInit];
        self.size = size;
        
    } return self;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self commonInit];
    } return self;
}
-(void)commonInit {
    self.animator = [[PopoverViewControllerTransitionAnimator alloc] init];
    self.animationType = PopoverViewControllerAnimationTypeCoverVertical;
    self.duration = 0.5;
    self.shouldDismissOnBackgroundTap = YES;
    self.obfuscationAlpha = 0.8;
    self.shouldObfuscateSourceViewController = YES;
    self.shouldLayoutSubviews = YES;
    
    self.modalPresentationStyle = UIModalPresentationCustom;
    [self setTransitioningDelegate:self.animator];

}

#pragma mark - Layout
-(void)viewDidLoad {
    [super viewDidLoad];
//    self.shadow = YES;
//    self.cornerRadius = 0;
}
-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    if (self.shouldLayoutSubviews) self.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - self.size.width/2, [UIScreen mainScreen].bounds.size.height/2 - self.size.height/2 , self.size.width, self.size.height);

}

#pragma mark - Overrides
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setAnimator:_animator];
    [self setTransitioningDelegate:self.animator];
}
-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    [super dismissViewControllerAnimated:flag completion:^{
        if (completion) completion();
        [self setTransitioningDelegate:nil];
    }];
}

#pragma mark - Getters And Setters
-(void)setShadow:(BOOL)shadow {
    _shadow = shadow;
    if (shadow) {
        self.view.layer.shadowColor = [UIColor blackColor].CGColor;
        self.view.layer.shadowRadius = 10.0;
        self.view.layer.shadowOpacity = .4;
        self.view.layer.shadowOffset = CGSizeMake(.5, .5);
    } else {
        self.view.layer.shadowColor = [UIColor blackColor].CGColor;
        self.view.layer.shadowRadius = 10.0;
        self.view.layer.shadowOpacity = 0;
        self.view.layer.shadowOffset = CGSizeMake( 0, 0);
    }
}
-(void)setSize:(CGSize)size {
    _size = size;
    [self.animator setSize:size];
}
-(void)setDuration:(CGFloat)duration {
    _duration = duration;
    [self.animator setDuration:duration];
}
-(void)setObfuscationAlpha:(CGFloat)obfuscationAlpha {
    _obfuscationAlpha = obfuscationAlpha;
    [self.animator setObfuscationAlpha:obfuscationAlpha];
}
-(void)setShouldObfuscateSourceViewController:(BOOL)shouldObfuscateSourceViewController {
    _shouldObfuscateSourceViewController = shouldObfuscateSourceViewController;
    [self.animator setShouldObfuscateSourceViewController:shouldObfuscateSourceViewController];
}
-(void)setShouldDismissOnBackgroundTap:(BOOL)shouldDismissOnBackgroundTap {
    _shouldDismissOnBackgroundTap = shouldDismissOnBackgroundTap;
    [self.animator setShouldDismissOnBackgroundTap:shouldDismissOnBackgroundTap];
}
-(void)setAnimationType:(PopoverViewControllerAnimationType)animationType {
    _animationType = animationType;
    [self.animator setAnimationType:animationType];
}
-(void)setAnimator:(PopoverViewControllerTransitionAnimator *)animator {
    _animator = animator;
    [_animator setPopover:self];
    [_animator setShouldDismissOnBackgroundTap:_shouldDismissOnBackgroundTap];
    [_animator setShouldObfuscateSourceViewController:_shouldObfuscateSourceViewController];
    [_animator setObfuscationAlpha:_obfuscationAlpha];
    [_animator setDuration:_duration];
    [_animator setAnimationType:_animationType];
}
-(void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.view.layer.masksToBounds = YES;
    self.view.layer.cornerRadius = cornerRadius;
}

#pragma mark - Dealloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc {
    [self setAnimator:nil];
}

@end


