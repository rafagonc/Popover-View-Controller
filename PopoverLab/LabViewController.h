//
//  LabViewController.h
//  PopoverLab
//
//  Created by Rafael Gonzalves on 3/5/15.
//  Copyright (c) 2015 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopoverViewController.h"

@interface LabViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *widthTextField;
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UISlider *durationSlider;
@property (weak, nonatomic) IBOutlet UISwitch *shadowSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *dimissOnTapSwitch;



#pragma mark - Popover Properties
@property (nonatomic) BOOL shadow;
/*!
 *  The popover animation type.
 *  If you create another animation, I will be happy to recieve a pull request.
 *  If you dont know how to create another animation, email me (rafaelgonc@icloud.com) and I will do it for you.
 */
@property (nonatomic) PopoverViewControllerAnimationType animationType;
/*!
 *  Specifies if the popover should add a black view over the source view controller.
 *  This view also dismiss the popover on tap.
 */
@property (nonatomic) BOOL shouldObfuscateSourceViewController;
/*!
 *  Specifies if the obfuscation view should dimisss the popover on tap.
 */
@property (nonatomic) BOOL shouldDismissOnBackgroundTap;
/*!
 *  Duration of both presenting and dismissing animation.
 */
@property (nonatomic) CGFloat duration;
/*!
 *  Amount of alpha of the obfuscation view.
 */
@property (nonatomic) CGFloat obfuscationAlpha;
/*!
 *  View rounded corner radius
 */
@property (nonatomic) CGFloat cornerRadius;

@end
