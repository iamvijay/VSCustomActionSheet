# VSCustomActionSheet
This will allow you to create custom action sheet where you can press some menu and based on that index you can do the action which you want.

# Installation

Just drag and drop the "VSCustomActionSheet.swift"file into your project, and make sure you check the "Copy items into destination group's folder" box

# Usage

Creation is very simple, just call the actionsheet initialisation with action sheet menus in array format

```swift
@IBAction func showCustomSheet(_ sender: Any) {
           
  let selectOption = VSCustomActionSheet.init(title : "Choose Photo", cancelButtonTitle: "Cancel", otherButtonTitle: ["Take a                       photo","Pick from gallery","Remove photo"], completion: { buttonSelected in
                     if(buttonSelected == 3){
                         print("selected index 3")
                     } else if(buttonSelected == 2) {
                        print("selected index 2")
                     } else {
                        print("selected index 1")
                     }
                 })
          selectOption.showButtons(self.view)
 }
``` 
As like above create object and call the function where the menu UI will created and presented. And also when you tap button you will get the index value based on the index value you can do corresponding action which you want.


If you want to change animation speed or color of any of the object you can change the following 

```swift
let SHEET_TITLE_HEIGHT : Int = 20
let LAST_BUTTON_PADDING : Int = 20
let NOTCH_BOTTOM_VALUE : Int = 30

let SPRING_DAMPING_ANIMATION_DURATION_SCREENSHOT : CGFloat = 0.8
let SPRING_VELOCITY_DURATION_SCREENSHOT : CGFloat = 0.5

let SPRING_DAMPING_ANIMATION_DURATION_BUTTON_CONTAINER : CGFloat = 0.8
let SPRING_VELOCITY_DURATION_BUTTON_CONTAINER : CGFloat = 0.7

let BUTTON_HEIGHT : Int = 60

let NORMAL_BUTTON_BG_COLOR = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
let CANCEL_BUTTON_BG_COLOR = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
let SHEET_TITLE_TEXT_COLOR = #colorLiteral(red: 0.5764705882, green: 0.6431372549, blue: 0.6784313725, alpha: 1)
let SHEET_BUTTON_TOP_BORDER_COLOR = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
let CANCEL_BUTTON_TEXT_COLOR = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
let NORMAL_BUTTON_TEXT_COLOR = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
```

Note : This is my first library so please feel free to comment or even you can suggest me if i have to improve anything in the code. Thanks

# Get in touch
If you want to contact me, mail at vijays1107@gmail.com or Just tweet me : @iam_vijay7

# License

 The MIT License (MIT)
 
 Copyright (c) 2019 Vijay Subramaniyam
 
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
