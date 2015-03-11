//
//  PopoverViewController.h
//  PopoverLab
//
//  Created by Rafael Gonzalves on 3/5/15.
//  Copyright (c) 2015 Rafael Gonzalves. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 *  Animation type of the popover.
 */
typedef enum : NSUInteger {
    /*!
     *  The popover appears from the bottom of the screen and go straight to the center of the screen.
     */
    PopoverViewControllerAnimationTypeCoverVertical = 0,
    /*!
     *  The popover fade in/fade out the center of the screen.
     */
    PopoverViewControllerAnimationTypeCrossDissolve = 1,
    
}PopoverViewControllerAnimationType;


/*!
 The popover view controller should be subclassed. if you want you can specify the size on the init or viewDidLoad methods. (if you want to use a xib call initWithNibName: bundle:) or story boards.
 */
@interface PopoverViewController : UIViewController

#pragma mark - Constructors
/*!
 *  Default constructor for popover view controller.
 *  Specifies the size of the view that will appear on the center of the screen.
 *  Can be overwritten.
 *
 *  @param size Size of the view.
 *
 *  @return Popover View Controller Instance
 */
-(instancetype)initWithSize:(CGSize)size;

#pragma mark - Customization
/*!
 *  Size of the view, centered in the screen.
 */

@property (nonatomic) CGSize size;
/*!
 *  Specifies if the popover view should have drop shadow.
 */
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



