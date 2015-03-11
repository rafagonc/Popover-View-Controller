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
    TestPopoverViewController *popover;
}

@end

@implementation LabViewController


#pragma mark - Constructos
-(instancetype)init {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        popover = [[TestPopoverViewController alloc] init];
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

}

#pragma mark - Actions
-(IBAction)present:(id)sender {
    [self presentViewController:popover animated:YES completion:nil];
}
-(IBAction)segmentedChangeValue:(id)sender {
    popover.animationType = self.segmentedControl.selectedSegmentIndex;
}
-(IBAction)durationSlider:(UISlider *)sender {
    popover.duration = sender.value;
}
-(IBAction)dismissOnTapSwitch:(UISwitch *)sender {
    popover.shouldDismissOnBackgroundTap = sender.on;
}
-(IBAction)shadowSwitch:(UISwitch *)sender {
    popover.shadow = sender.on;
}
-(IBAction)obfuscateSourceSwitch:(UISwitch *)sender {
    popover.shouldObfuscateSourceViewController = sender.on;
    
}

#pragma mark - Dealloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
