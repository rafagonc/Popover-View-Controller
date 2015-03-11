//
//  LabViewController.m
//  PopoverLab
//
//  Created by Rafael Gonzalves on 3/5/15.
//  Copyright (c) 2015 Rafael Gonzalves. All rights reserved.
//

#import "LabViewController.h"
#import "TestPopoverViewController.h"

@interface LabViewController ()
{
}

@end

@implementation LabViewController


#pragma mark - Constructos
-(instancetype)init {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
    } return self;
}

#pragma mark - Lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:nil action:nil];
    self.navigationItem.leftBarButtonItem = item;
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    
    self.animationType = PopoverViewControllerAnimationTypeCoverVertical;
    self.duration = 0.5;
    self.shadow = YES;
    self.shouldObfuscateSourceViewController = YES;
    self.shouldDismissOnBackgroundTap = YES;
    self.cornerRadius = 0;
}

#pragma mark - Actions
-(IBAction)present:(id)sender {
    TestPopoverViewController *pop = [[TestPopoverViewController alloc] init];
    pop.animationType = self.animationType;
    pop.shadow = self.shadow;
    pop.shouldDismissOnBackgroundTap = self.shouldDismissOnBackgroundTap;
    pop.shouldObfuscateSourceViewController = self.shouldObfuscateSourceViewController;
    pop.duration = self.duration;
    pop.cornerRadius = self.cornerRadius;
    [self presentViewController:pop animated:YES completion:nil];
}
-(IBAction)segmentedChangeValue:(id)sender {
    self.animationType = self.segmentedControl.selectedSegmentIndex;
}
-(IBAction)durationSlider:(UISlider *)sender {
    self.duration = sender.value;
}
-(IBAction)dismissOnTapSwitch:(UISwitch *)sender {
    self.shouldDismissOnBackgroundTap = sender.on;
}
-(IBAction)shadowSwitch:(UISwitch *)sender {
    self.shadow = sender.on;
}
-(IBAction)obfuscateSourceSwitch:(UISwitch *)sender {
    self.shouldObfuscateSourceViewController = sender.on;
}
- (IBAction)cornerRadiusSlider:(UISlider *)sender {
    self.cornerRadius = sender.value;
}

#pragma mark - Dealloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
