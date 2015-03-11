//
//  TestPopoverViewController.m
//  PopoverLab
//
//  Created by Rafael Gonçalves on 06/03/15.
//  Copyright (c) 2015 Rafael Gonzalves. All rights reserved.
//

#import "TestPopoverViewController.h"

@interface TestPopoverViewController ()

@end

@implementation TestPopoverViewController

#pragma mark - Constructors
-(instancetype)init {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        self.size = CGSizeMake(280, 400);
    } return self;
}

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark - Actions
-(IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Dealloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
