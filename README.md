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

**Warning** : Due memory management, dont use popover view controller as an ivar/property or a class instance variable. Instantiate a new one every time you present.

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
* `cornerRadius` : View rounded corner radius

###Full Reference

To check the full reference of the Popover View Controller go to the index.html on the /help.

###License

The MIT License (MIT)

Copyright (c) <year> <copyright holders>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
