# Popover View Controller

  The Popover View Controller is a a UIViewController subclass intended to work as an really simple cross-device popover solution since the apple's popover only works on iPad. 

###Usage

Subclass the PopoverViewController and set the size of the popover on the init/constructor or viewDidLoad(Storyboard) methods. (It will be centered on the screen). 

Example:
```
-(instancetype)init {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        self.size = CGSizeMake(200, 200);
    } return self;
}
```

###Animations

The currently avaliable animations type are:
* `Cross Dissolve` : Fade In / Fade Out
* `Cover Vertical` : From Bottom To Center


###Customization

* `shadow` : Specifies if the popover should have drop shadow.
* `duration` : Duration of both presenting and dimissing the popover.
* `shouldDismissOnBackgroundTap` : Specifies if the obfuscation view should dimisss the popover on tap.
* `shouldObfuscateSourceViewController` : Specifies if the popover should add a black view over the source view controller. This view also dismiss the popover on tap.
* `obfuscationAlpha` : Amount of alpha of the obfuscation view.


###Full Reference

To check the full reference of the Popover View Controller go to the index.html on the /help.
