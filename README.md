# IOTPay-iOS
#### Online Credit Card Payment Framework for iOS
<br />    
IOTPay-iOS is a smiple to use yet powerful Framework helps you with the online payment for iOS apps.

## 1. Features:
##### -Highly coustomaziable 
#####-Secure
#####-Easy to set up
<br />    
Quick Start:
```
Swift:
cardInfoView = IOTCardInfoViewSingleLine(action: .addCard, style: .roundRect)  
IOTNetworkService.shared.sendRequest(secureId: "Your secureId", cardInfoView: cardInfoView)
```
```
Objc: 
IOTCardInfoViewSingleLine *cardInfoView = [[IOTCardInfoViewTripleLineNCardView alloc] initWithAction: IOTNetworkRequestActionOneTimePurchase style: IOTCardInfoViewStyleRoundRect];
[IOTNetworkService.shared sendRequestWithSecureId: @"Your secureId" cardInfoView:self.cardInfoView];
```

<br />  
<br />  
![alt text](https://github.com/IOTPaySDK/IOTPay-iOS/blob/main/simpleGIF.gif "Logo Title Text 1") ![alt text](https://github.com/IOTPaySDK/IOTPay-iOS/blob/main/TripleGif.gif "Logo Title Text 1")
<br />  
<br />  
<br />  

##2. Integration walkthought
####2.1: Install Framework
The easiset way to install the framework and keep it upon date is using cocoaPod. 
CocoaPod is one of the most commonly used Xcode library & framework depandency managment software.
For Pod reference and how-to install pod, please follow this link:
https://guides.cocoapods.org/using/the-podfile.html
<br />  
Once you have cocoaPod installed, open the Terminal (Mac command line/CLI) and set the directory to your project, one level above the MyProject.xcodeproj file.
```
cd ~/Floder/Floder/Floder/MyProject
```
A easier way to do so is type cd, space, and drag the project folder to the Terminal, then input enter.
<br />  
Once it set to the project directory, enter the follow line to initiate the pod:
```
pod init
```
The pod init command will make a Podfile in your project folder. This text file is the manager of the framework and libray for you app. Now let's try to editting it by tap on Podfile or type "open Podfile' in Terminal.
<br />  
Open the pod file by any text editor, then enter the following lines
```
target 'MyApp' do
    pod 'IOTPayiOS', '~> 4.0'
end
```
The first and last line is probolecy be there already, so you will just need to fill in the middle line.
<br />  

And finaly, save and close the text editor, then enter the following command in Terminal.
```
pod install
```
The cocoaPod will start installing.
<br />  
<br />      

# 2 Integrade "Add Card" Event

What you will need:
- installed IOTPayiOS Framework  (refer to the first part in this guide)
- Merchant account with IOTPay (register @ https://iotpay.ca/1666-2/)

Optional:
- Merchant Server (refer to https://develop.iotpay.ca)
	
For production, client should build their own "Merchant Server", which will generate the "secureId". For testing phase, there is a shortcut to generate testing secureId without Merchant server. Please check 5.1 Temporary solution to get secureId at the end of this guide.    

## 2.1 Import framework
```
Swift:
import IOTPayiOS
```
```
Objc: (in .h)
#import <IOTPayiOS/IOTPayiOS-Swift.h>
```
<br />    

#2.2 Setup View
Declare the view before viewDidLoad. This is not mandatory for display the view, but you will need it for the send request event in step 3.
```
Swift:
var cardInfoView: IOTCardInfoViewSingleLine!
```
```
Objc: (in .h, Between @interface & @end)
@property (nonatomic, retain) IOTCardInfoViewTripleLineNCardView *cardInfoView;
```

Add following code in ViewController after viewDidLoad
```
Swift:
cardInfoView = IOTCardInfoViewSingleLine(action: .addUser, style: .roundRect)
cardInfoView.Delegate = self
view.addSubview(cardInfoView)
```
```
Objc: (in .m)
self.cardInfoView = [[IOTCardInfoViewTripleLineNCardView alloc] initWithAction: IOTNetworkRequestActionOneTimePurchase style: IOTCardInfoViewStyleRoundRect];
self.cardInfoView.delegate = self;
[self.view addSubview: self.cardInfoView];
```
This will start the interface for user to fillin the card info.
<br />    


<br />      

#2.3: Send the Request
After user filling the card info, sending the request by:
```
Swift
let shard = IOTNetworkManager.shared
shard.delegate = self
shard.sendRequest(secureId: "your secureId", cardInfoPrivder: cardInfoView)

Objc
IOTNetworkService *shard = IOTNetworkService.shared;
shard.delegate = self;
[shard sendRequestWithSecureId: @"Your secureId" cardInfoView:self.cardInfoView];
```
That's all we need for basic setup to add a card!
(You will need to set up a button for sendRequest after user filling the info)
For sample example, please check sampleExample. 
- SimpleDemo 

For more usage, such as delegate to let you know user filling the vliad info and complete, or more style/layout settings, please check the other examples:
- TripleLineDemo
- DelegateDemo 
- StylingDemo (NOT yet)




<br />      

## Quick Data reference:
#action: 
```
enum IOTNetworkRequestAction {
	case addCard           // add card, you will receive desensitizated card info after the network request.
	case oneTimePurchase   // one time payment, without saving user's payment method
}
```


#style: 
```
enum IOTCardInfoViewStyle {
	case roundRect
	case infoLight
	case infoDark   // for nightmode
}
```

#cardInfoPrivder: 
```
IOTCardInfoView
```
Should fill in the name/pointer of the view that user filling in the info, this is required for sending the request.

#secureId:<br />   

You will need a secureId to for "sendRequest".

For production, client should build their own "Merchant Server", which will generate the "secureId". 
For testing, you can use the following temporary solution to get secureId:    

## - Step 1: Get Merchant Id   
Register an IOTPay account to get the "Merchant Id", "Merchant Key" and "loginName"    

## - Step 2: Get Temporary secureId   
For "one time purchase", please visit:   https://develop.iotpay.ca/new/v3dev/purchase.html   
For "add card", please visit   https://develop.iotpay.ca/new/v3dev/addcard.html    
Fill in the account info requested on the page, then press "Submit" button. Check the URL in the borwer, it will looks like following:   https://ccdev.iotpaycloud.com/cc/addcard?key=cf383bf97a7288f4a4f6a2741ec56df51a1cacb48a90b77f6b9198d928fc84f2   

Copy the string after "addcard?key=", and use it as the tempory secureId. This seccureId will be valid for an hour   
		
