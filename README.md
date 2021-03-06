# IOTPay-iOS
#### IOTPay - Online Credit Card Payment Framework for iOS/Android/php
<br />    
- [1 Features](#1.0)
- [2. Integration Walkthrough](#2.0)
	- [2.1 Install Framework](#2.1)
	- [2.2 Import Framework](#2.2)
	- [2.3 Event Flow and Options](#2.3)
	- [2.4 "Recurring Purchase" Option](#2.4)
	- [2.5 "Simple Purchase" Option](#2.5)
- [3 Layout, Style and Anition options](#3.0)



<a name="1.0"><a/>
## 1. Features:
#### *-Highly customizable*
#### *-Secure*
#### *-Easy to set up*<br />   


Quick Start:<br />   
```
For Swift:
import IOTPayiOS
	
let cardInfoView = IOTCardInfoViewSingleLineNCardIcon(action: .addCard, style: .autoDarkModeSupport)  
IOTNetworkService.shared.sendRequest(secureId: "Your secureId", cardInfoView: cardInfoView)
```
```
For Objc: 
#import <IOTPayiOS/IOTPayiOS-Swift.h>
	
IOTCardInfoViewTripleLineNCardView *cardInfoView = [[IOTCardInfoViewTripleLineNCardView alloc] initWithAction: IOTNetworkRequestActionOneTimePurchase 
											       style:  IOTCardInfoViewStyleAutoDarkModeSupport];	
[IOTNetworkService.shared sendRequestWithSecureId: @"Your secureId" cardInfoView: cardInfoView];
```
<br /> 
<br />  

![alt text](https://github.com/IOTPaySDK/IOTPay-iOS/blob/main/ReadmeImages/simpleGIF.gif "Logo Title Text 1") ![alt text](https://github.com/IOTPaySDK/IOTPay-iOS/blob/main/ReadmeImages/TripleGif.gif "Logo Title Text 1")

<br />  
<br />  
<br />  
<a name="2.0"><a/>
## 2. Integration Walkthrough:
<a name="2.1"><a/>
### 2.1 Install Framework
The easiest way to install the IOTPayframework and keep it upon date is using cocoaPod. CocoaPod is one of the most commonly used Xcode library & framework dependency management software. For Pod reference and how-to install pod, please follow this link:
<br /> 
https://guides.cocoapods.org/using/the-podfile.html
<br />  

Once you have cocoaPod installed, open the Terminal (Mac command line/CLI) and set the directory to your project, one level above the MyProject.xcodeproj file.
```
cd ~/Path/to/Folder/MyApp
```
A easier way to do so is type cd, space, and drag the project folder to the Terminal, then input enter. In this case, MyApp folder contains the .xcodeproj file.

<br /> 

Next, enter the follow line in Terminal to initiate the pod:
```
pod init
```
The pod init command will make a Podfile in your project folder. This text file is the manager of the framework and library for you app. Now let's try to editing it by tap on Podfile or type "open Podfile' in Terminal, then enter the following lines:
```
target 'MyApp' do    
	use_frameworks! 
	pod 'IOTPayiOS', '~> 8.1.0'
end
```
"use_frameworks!" is required for objective-c.
The first and last line is probably there already, so you will just need to fill in the middle line.<br />  
And finally, save and close the text editor, then enter the following command in the Terminal.
```
pod install
```
The cocoaPod will start installing the IOTPayiOS framework.
The cocoaPod will also generate a .xcworkspace file same, this should be the root file to open the project in the futrue.
<br />  <br />      




<a name="2.2"><a/>
### 2.2 Import Framework
```
Swift:
import IOTPayiOS
```
```
Objc: (in .h)
#import <IOTPayiOS/IOTPayiOS-Swift.h>
```
<br />    

<a name="2.3"><a/>
### 2.3 Event Flow and Options
<br /> 
Now IOTPay is installed and imported. Next step is your choice with two options for the payment, "Recurring Purchase" and "Simple Purchase". Please choose the one based on your needs.<br /> 

### Option A: "Simple Purchase"
This is a simpler solution, that users should enter their card info each time for the purchase. 
This framework should be used/re-init for each simple purchase event.

![alt text](https://github.com/IOTPaySDK/IOTPay-iOS/blob/main/ReadmeImages/APIV3MobileAppSDK0.png "Logo Title Text 3")


<br />  
### Option B: Recurring Purchase
Recurring Purchase start with "Add Card" to save payment info, and then use "Purchase with token" for future transaction.
<br />  
Once the user adds a card successfully, the IOTPay server will send back a response that includes desensitized card info. After Add card Event, the App will only need to send a request to your own mechant server, which will interact with IOTPay server and get response/receipt to the App. This framework should not be used again, unless the user wants to add another card, or do a one time purchase with another card. 
<br /> 

![alt text](https://github.com/IOTPaySDK/IOTPay-iOS/blob/main/ReadmeImages/APIV3MobileAppSDK1.png "Logo Title Text 3")
![alt text](https://github.com/IOTPaySDK/IOTPay-iOS/blob/main/ReadmeImages/APIV3MobileAppSDK2.png "Logo Title Text 3")

Please check this link for detailed explanation and requirements for the parameters.
https://develop.iotpay.ca/credit_card_v3.html

To start the next step, you will need:
- IOTPayiOS Framework Installed  (Refer to the first part in this guide)
- A Merchant account from IOTPay (Register @ https://iotpay.ca/1666-2/)
- Merchant Server (refer to https://develop.iotpay.ca/credit_card_v3.html#sign-generate-and-check)	
<br /> 
 :exclamation: important: Merchant/client should build their own "Merchant Server", which will generate the "secureId". This should be done before try to install the iOS or Android SDK, otherwise, there won't be a vilad "secureId" for network request.
<br />  




<br />
<a name="2.4"><a/>
	
### 2.4 Recurring Purchase Option
	
Recurring Purchase is recommended as users will only need to enter their card info once, after that IOTServer will remember user info and make payment without user entering info again. The desensitization card info such as card number will be provided at the end of the add card event, which can be used as title or hint for the user's future payment, but your app should not try to record the user's full card number.
Once the add card event is done, this SDK is end of duty, and future purchase requests should happen by sending requests using your own server to the IOTPay server. Please check the chart above and check the IOTPayPhp for more info.https://github.com/IOTPaySDK/IOTPay-PHP

IMPORTANT: In another word, in this route the SDK only prived users to be added to the "recurring purchase" list, unlike "simple purchase option", there is no "purchase" action happening with the SDK in this option.
	
(Please check the AddCardSwiftExample or AddCardObjcExample in the examples folder for finished code.)
	
#### 2.4.1 Setup Card Info View:

Declare the view before viewDidLoad. 

This is not mandatory for displaying the view, but you will need this view's point to send a request in the next step.

```
Swift:
var cardInfoView: IOTCardInfoViewTripleLineNCardView!
```
```
Objc: 
(in .h, Between @interface & @end) 
@property (nonatomic, retain) IOTCardInfoViewTripleLineNCardView *cardInfoView;
```
Add following code in ViewController after viewDidLoad
```
Swift:
cardInfoView = IOTCardInfoViewTripleLineNCardView(action: .addCard, style: .autoDarkModeSupport)
cardInfoView.delegate = self
view.addSubview(cardInfoView)
```
```
Objc: (in .m)
self.cardInfoView = [[IOTCardInfoViewTripleLineNCardView alloc] initWithAction: IOTNetworkRequestActionAddCard 
									 style: IOTCardInfoViewStyleAutoDarkModeSupport];
self.cardInfoView.delegate = self;
[self.view addSubview: self.cardInfoView];
```

This will start the interface for the user to fill in the card info.<br />    

#### 2.4.2 Card Info View Delegate:

The card Info View delegate (IOTCardInfoViewDelegate) has one func in protocol:  onDidCompleteValidate()


This will be called once the user's inputted card info is valid. in all the required info viliadly, so you know when to make the "Add Card" button ready for user input.
```
Swift:
// This Swift sample code is using extension, which should add at the end of the code out side ViewController class.
// If you want to write the those function in the ViewController class, simply add the IOTNetworkServiceDelegate to class declaration line of ViewController,
// For example: "class ViewController: UIViewController, IOTNetworkServiceDelegate { "
	
extension ViewController: IOTCardInfoViewDelegate {	
	func onDidCompleteValidate() {		
		// User did complete card info view Validate, we should enable the button		
		button.setTitle("Add Card", for: .normal)		
		button.isUserInteractionEnabled = true	
	}
}
```
```
Objc: .h
@interface ViewController : UIViewController <IOTCardInfoViewDelegate>

.m
- (void)onDidCompleteValidate {	
	// User did complete card info view Validate, we should enable the button	
	[self.button setTitle: @"Add Card" forState: UIControlStateNormal];	
	[self.button setUserInteractionEnabled: true];
}
```
Please don't forget to add "IOTCardInfoViewDelegate" in the previous step.<br />  


#### 2.4.3 NetworkService Response Delegate:
```
Swift:	
// This Swift sample code is using extension, which should add at the end of the code out side ViewController class.
extension ViewController: IOTNetworkAddCardDelegate {	

	func onDidAddCardSuccess(msg: String, desensitizedCardInfo: IOTDesensitizedCardInfo, redirectUrl: String) {
		print("Request Successed! \n")
		print("cardId: \(desensitizedCardInfo.cardId)")
		print("cardNumber: \(desensitizedCardInfo.cardNumber)")
		print("holderName: \(desensitizedCardInfo.holderName)")
		print("redirectUrl: \(redirectUrl)")
	}

	func onDidAddCardFail(msg: String) {
		NSLog("Request Failed! msg: \(msg)");
	}
}
```
```
Objc: .h
@interface ViewController : UIViewController <IOTCardInfoViewDelegate, IOTNetworkAddCardDelegate>

.m
- (void)onDidAddCardFailWithMsg:(NSString * _Nonnull)msg {
	NSLog(@"Request Failed! msg: %@", msg);
}

- (void)onDidAddCardSuccessWithMsg:(NSString * _Nonnull)msg 
	      desensitizedCardInfo:(IOTDesensitizedCardInfo * _Nonnull) desensitizedCardInfo
		       redirectUrl:(NSString * _Nonnull)redirectUrl {

	NSLog(@"Request Successed! \n");
	NSLog(@"cardId: %@", desensitizedCardInfo.cardId);
	NSLog(@"cardNumber %@", desensitizedCardInfo.cardNumber);
	NSLog(@"holderName %@", desensitizedCardInfo.holderName);
	NSLog(@"redirectUrl %@", redirectUrl);
}


```
You should record some of that info to associate the user account/device to your Merchant Server. The future purchase should use "purchase with token" from now on, except your user wants to add or pay with a new card.
Please check the AddUserSwiftExample or AddUserObjcExample in the examples folder for finished code.
	


#### 2.4.4 Send the Request
After user filling the card info and tap on the "Add User" sending the request by:
```
Swift:
let shard = IOTNetworkService.shared
shard.addCardDelegate = self
shard.sendRequest(secureId: "your secureId", cardInfoView: cardInfoView)
```
```
Objc:
IOTNetworkService *shard = IOTNetworkService.shared;
shard.addCardDelegate = self;
[shard sendRequestWithSecureId: @"Your secureId" cardInfoView:self.cardInfoView];
```
As you noted, we added the delegate again and set it to self in the above code. This time, the delegate will help you to receive the server response.
The secureId is generated after your server connects with IOTPay server, please check the Flow Chart above and IOTPayPhp (https://github.com/IOTPaySDK/IOTPay-PHP) for more info regarding how to get the "secureId".

<br   />
	
#### 2.4.5 Response Data

```

class IOTDesensitizedCardInfo: NSObject {
	let cardId: String
	let cardNumber: String
	let holderName: String
	
	var info: String {
		return "cardId: \(cardId), cardNumber: \(cardNumber), holderName: \(holderName)"
	}
}


```
	
<br    />
Use desensitizedCardInfo.info to easily log out the return data.
Please check the AddCardSwiftExample or AddCardObjcExample in the examples folder for finished code.
The SDK only provide TestFields. Buttons and ViewControllers are for demo only. It's highly recommended to use your own customized button for payment/addCard request and have a loading animation view ready while waiting for network response.
	
<br />
<br />

<a name="2.5"><a/>
### 2.5 "Simple Purchase" Option:

(Please check the SimplePurchaseSwiftExample or SimplePurchaseObjcExample in the examples folder for finished code.)
	
	
#### 2.5.1 Setup Card Info View:
Declare the view before viewDidLoad. This is not mandatory for displaying the view, but you will need this view's point to send a request in the next step.
```
Swift:
var cardInfoView: IOTCardInfoViewSingleLineNCardIcon!
```
```
Objc: 
(in .h, Between @interface & @end)
@property (nonatomic, retain) IOTCardInfoViewTripleLineNCardView *cardInfoView;
```

Add following code in ViewController after viewDidLoad
```
Swift:
cardInfoView = IOTCardInfoViewSingleLineNCardIcon(action: .oneTimePurchase, style: .autoDarkModeSupport)
cardInfoView.delegate = self
view.addSubview(cardInfoView)
```
```
Objc: (in .m)
self.cardInfoView = [[IOTCardInfoViewTripleLineNCardView alloc] initWithAction: IOTNetworkRequestActionOneTimePurchase
									 style: IOTCardInfoViewStyleAutoDarkModeSupport];
self.cardInfoView.delegate = self;
[self.view addSubview: self.cardInfoView];
```
This will start the interface for the user to fill in the card info.<br />   

#### 2.5.2 Card Info View Delegate:
The card Info View delegate (IOTCardInfoViewDelegate) has one func in protocol:  func onDidCompleteValidate() { }
This func will be called once after users' fill in all the required info viliadly, so you know when to make the "Add Card" button ready for user input.
```
Swift:
extension ViewController: IOTCardInfoViewDelegate {	
	func onDidCompleteValidate() {		
		// User did complete card info view Validate, we should enable the button		
		button.setTitle("Purchase", for: .normal)		
		button.isUserInteractionEnabled = true	
	}
}
```
```
Objc: .h
@interface ViewController : UIViewController <IOTCardInfoViewDelegate>

.m
- (void)onDidCompleteValidate {	
	// User did complete card info view Validate, we should enable the button	
	[self.button setTitle: @"Purchase" forState: UIControlStateNormal];	
	[self.button setUserInteractionEnabled: true];
}
```
Please don't forget to add "IOTCardInfoViewDelegate" in the previous step.<br />   

#### 2.5.3 NetworkService Response Delegate:
```
Swift:
extension ViewController: IOTNetworkPurchaseDelegate {	
	func onDidPurchaseSuccess(msg: String, purchaseReceipt: IOTPurchaseReceipt, redirectUrl: String) {
		print("Request Successed! \n")
		print(purchaseReceipt.info)
		print("redirectUrl: \(redirectUrl)")
	}


	func onDidPurchaseFail(msg: String) {
		print("Request Failed! msg: \(msg)");
	}

	func onDidPurchaseUnknow(msg: String) {
		print("Request Failed! msg: \(msg)");
		print("""
			This is a rarely happening case where bank's network may has problems. This transition
			may or may NOT go thought. You should content with IOTPay customer service to get the
			payment result."
			""");
	}

}
```
```
Objc: in .h
@interface ViewController : UIViewController <IOTCardInfoViewDelegate, IOTNetworkPurchaseDelegate>

in .m
- (void)onDidPurchaseFailWithMsg:(NSString * _Nonnull)msg {
	NSLog(@"Request Failed! msg: %@", msg);
}

- (void)onDidPurchaseSuccessWithMsg:(NSString * _Nonnull)msg 
		    purchaseReceipt:(IOTPurchaseReceipt * _Nonnull)purchaseReceipt 
			redirectUrl:(NSString * _Nonnull)redirectUrl {
	NSLog(@"Request Successed! \n");
	NSLog(@"%@", purchaseReceipt.info);

}

- (void)onDidPurchaseUnknowWithMsg:(NSString * _Nonnull)msg {
	NSLog(@"Request Failed! msg: %@", msg);
	NSString *str = @"This is a rarely happening case where bank's network may has problems. "
			 "This transition may or may NOT go thought. You should content with IOTPay "
			 "customer service to get the details of this transition";
	NSLog(@"%@", str);
}
```
onDidPurchaseUnknowWithMsg may only happen in the extreme case, which doesn't have a result to indicate if the transition is done.


	
#### 2.5.4 Send the Request
After user filling the card info and tap on the "Add User" sending the request by:
```
Swift:
let shard = IOTNetworkService.shared
shard.purchaseDelegate = self
shard.sendRequest(secureId: "your secureId", cardInfoView: cardInfoView)
```
```
Objc:
IOTNetworkService *shard = IOTNetworkService.shared;
shard.purchaseDelegate = self;
[shard sendRequestWithSecureId: @"Your secureId" cardInfoView:self.cardInfoView];
```
As you noted, we added the delegate again and set it to self in the above code. This time, the delegate will help you to receive the server response.
The secureId is generated after your server connects with IOTPay server, please check the Flow Chart above and IOTPayPhp (https://github.com/IOTPaySDK/IOTPay-PHP) for more info regarding how to get the "secureId".
	
	
<br   />
#### 2.5.5 Response Data
<br   />

```

class IOTPurchaseReceipt: NSObject {
	let amount: Int   //Int in cent example: 134 //which is ($1.34)
	let authorizationNumber: String
	let cardNumber: String // desensitizated example: 424242XXXXXX4242
	let cardType: String  // V=Visa, M=Master, D=Interact
	let currency: String // example: "CAD"
	let invoiceNumber: String 
	let merchantOrderNumber: String
	let originalOrderId: String
	let payOrderId: String
	let paySuccessTime: String // example "2021-04-16 03:33:16";
	let payType: String // example pay;
	let refundable: Int   //Int in cent
	let status: Int   //example: 2.  (either 2 or 3)
	let transitionNumber: String

	public var info: String {
		// print the whole data as a single String
	}

}

```

<br   />
Use purchaseReceipt.info to easily log out the return data.
Please check the SimplePurchaseSwiftExample or SimplePurchaseObjcExample in the examples folder for finished code.
The SDK only provide TestFields. Buttons and ViewControllers are for demo only. It's highly recommended to use your own customized button for payment/addCard request and have a loading animation view ready while waiting for network response.


	
<br   />     
<br   />     
<a name="3.0"><a/>
## 3 Layout, Style and Action options:

The cardInfoView has 3 layout, which are:
```
IOTCardInfoViewTripleLineNCardView
IOTCardInfoViewTripleLineOnCardView
IOTCardInfoViewSingleLineNCardIcon
```
The frame required to display the view is in decsending order. Beside the frame and layout, that are all the same and have same func's.
<br />  

#action: 
```
enum IOTNetworkRequestAction {	
	case addCard           // add card, you will receive desensitization card info after the network request.	
	case simplePurchase    // one time payment, without saving user's payment method
}
```
The action should be either .purchase for "Simple Purchase" or .addCard for "recurring Purchase".
<br />  


#style: 

The sytle is a enum that has following options:
```
@objc
public enum IOTCardInfoViewStyle: Int {
	case autoDarkModeSupport = 0
	case forceLightMode
	case forceDarkMode
}
```
It's recommended to use .autoDarkModeSupport, as it will support not only the Dark/Ligh mode, but also support the device which use outdated iOS version that even don't has dark mode.

<br />  

#cardInfoPrivder: 
```
IOTCardInfoView
```
Should fill in the name/pointer of the view that the user is filling in the info, this is required for sending the request.




