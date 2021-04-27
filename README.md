# IOTPay-iOS
#### Online Credit Card Payment Framework for iOS
<br />    
IOTPay-iOS is a smiple to use yet powerful Framework helps you with the online payment for iOS apps.

## 1. Features:
#### *-Highly coustomaziable*
#### *-Secure*
#### *-Easy to set up*
<br />    
Quick Start:<br />   

```
For Swift:
cardInfoView = IOTCardInfoViewSingleLine(action: .addCard, style: .roundRect)  

IOTNetworkService.shared.sendRequest(secureId: "Your secureId", cardInfoView: cardInfoView)
```
```
For Objc: 
IOTCardInfoViewSingleLine *cardInfoView = [[IOTCardInfoViewTripleLineNCardView alloc] 
	initWithAction: IOTNetworkRequestActionOneTimePurchase style:  IOTCardInfoViewStyleRoundRect];
	
[IOTNetworkService.shared sendRequestWithSecureId: @"Your secureId" cardInfoView: self.cardInfoView];
```

<br />  
<br />  

![alt text](https://github.com/IOTPaySDK/IOTPay-iOS/blob/main/ReadmeImages/simpleGIF.gif "Logo Title Text 1") ![alt text](https://github.com/IOTPaySDK/IOTPay-iOS/blob/main/ReadmeImages/TripleGif.gif "Logo Title Text 1")
<br />  
<br />  
<br />  

## 2. Integration Walkthrough:
### 2.1: Install Framework
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


### 2.2 Import framework
```
Swift:
import IOTPayiOS
```
```
Objc: (in .h)
#import <IOTPayiOS/IOTPayiOS-Swift.h>
```
<br />    

### 2.3 Event Flow and Options
IOTPay provide two options for the payment, "Simple Purchase" and "Add Card & Purchase with token". Please choose the one based on your needs, or incloud both and let user choose pick their options.
<br />  
"Simple Purchase" Flow:
≈
This is a simpler solution, that user should enter their card info each time for the purchase. This framework should be used/re-init for each simple purchase event.

![alt text](https://github.com/IOTPaySDK/IOTPay-iOS/blob/main/ReadmeImages/APIV3MobileAppSDK2.png "Logo Title Text 3")

<br />  
"Add Card & Purchase with token" Flow:
<br />  
Once the user add a card successcefly, the IOTPay server will send back a response that include desensitized card info. Your app and server should save those desensitized info for users' futrue purchase.
<br /> 
![alt text](https://github.com/IOTPaySDK/IOTPay-iOS/blob/main/ReadmeImages/APIV3MobileAppSDK0.png "Logo Title Text 3")
![alt text](https://github.com/IOTPaySDK/IOTPay-iOS/blob/main/ReadmeImages/APIV3MobileAppSDK1.png "Logo Title Text 3")

<br />
 Upone recevied the desensitized card info, the App will only need to send request to your own mechant server, which will interact with IOTPay server and get response/receipt to the App. This framework should not be used again, unless user want to add another card, or do a one time purchase with other card.
 
<br />  
To start the next step, you will need:
- IOTPayiOS Framework Installed  (refer to the first part in this guide)
- A Merchant account from IOTPay (register @ https://iotpay.ca/1666-2/)

Optional:
- Merchant Server (refer to https://develop.iotpay.ca)
	
For production, Merchant/client should build their own "Merchant Server", which will generate the "secureId". For testing phase, there is a shortcut to generate Testing secureId without Merchant server. Please check 5.1 Temporary solution to get secureId at the end of this guide.    
<br />  

### 2.4 "Add Card" + "Purchase Token" Option/Event

#### 2.4.1, Setup Card Info View:
Declare the view before viewDidLoad. This is not mandatory for display the view, but you will need this view's point to send request in the next step.
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
cardInfoView = IOTCardInfoViewSingleLine(action: .addCard, style: .roundRect)
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

#### 2.4.2, Card Info View Delegate:
The card Info View delegate (IOTCardInfoViewDelegate) has one func in protocl:  
func onDidCompleteValidately() { }
This func will be called once after users' fillin all the required info viliadly, so you know when to make the "Add Card" button to ready for user input.
```
Swift
extension ViewController: IOTCardInfoViewDelegate {
	func onDidCompleteValidately() {
		// User did complete card info view Validately, we should enable the button
		button.setTitle("Add Card", for: .normal)
		button.isUserInteractionEnabled = true
	}
}
```
```
Objc .h
@interface ViewController : UIViewController <IOTCardInfoViewDelegate>

Objc .m
- (void)onDidCompleteValidately {
	// User did complete card info view Validately, we should enable the button
	[self.button setTitle: @"Add Card" forState: UIControlStateNormal];
	[self.button setUserInteractionEnabled: true];
}
```
Please don't forget to add "IOTCardInfoViewDelegate" in the previous step.
<br />      

#### 2.4.3, Send the Request
After user filling the card info and tap on the "Add User" sending the request by:
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
As you noted, we added the delegate again and set it to self in the above code. This time, the delegate will help you to receive the server response.

#### 2.4.4, NetworkService Response Delegate:
```
Swift
extension ViewController: IOTNetworkServiceDelegate {
	func onDidAddCard(desensitizedCardInfo: IOTDesensitizedCardInfo, redirectUrl: String) {
		/* .addCard action's network response if successd.
		There is a error checklist in the github guide to help you fix the error
		*/
		print("successd", desensitizedCardInfo.info)
	}

	func onDidPurchase(purchaseReceipt: IOTPurchaseReceipt, redirectUrl: String) {
		// This is for Simple Purchase event, it has nothing to do with "purchase with token" in the next step. You can lease this blank for addCard Event.
		print("successd", purchaseReceipt.info)
	}
}
```
```
Objc .h
@interface ViewController : UIViewController <IOTCardInfoViewDelegate, IOTNetworkServiceDelegate>

Objc .m
- (void)onDidAddCardWithDesensitizedCardInfo:(IOTDesensitizedCardInfo * _Nonnull) desensitizedCardInfo 
				 redirectUrl:(NSString * _Nonnull)redirectUrl {
	// This is for AddCard event. You can lease this blank for simplePurchase Event.
}

- (void)onDidPurchaseWithPurchaseReceipt:(IOTPurchaseReceipt * _Nonnull) purchaseReceipt 
 			     redirectUrl:(NSString * _Nonnull)redirectUrl {
	// This is for Simple Purchase event, it has nothing to do with "purchase with token" in the next step. You can lease this blank for addCard Event.
	NSLog(@"successed %@", purchaseReceipt.info);
}
}
```

You should record some of those info to associate user account/device to your Merchant Server. The futrue purchase should use "purchase with token" from now on, except your user want to add or pay with a new card.

Please check the AddUserSwiftExample or AddUserObjcExample in the examples folder for finished code.




### 2.5 "Simple Purchase" Option/Event 

#### 2.5.1, Setup Card Info View:
Declare the view before viewDidLoad. This is not mandatory for display the view, but you will need this view's point to send request in the next step.
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
cardInfoView = IOTCardInfoViewSingleLine(action: .simplePurchase, style: .roundRect)
cardInfoView.Delegate = self
view.addSubview(cardInfoView)
```
```
Objc: (in .m)
self.cardInfoView = [[IOTCardInfoViewTripleLineNCardView alloc] initWithAction: IOTNetworkRequestActionSimplePurchase style: IOTCardInfoViewStyleRoundRect];
self.cardInfoView.delegate = self;
[self.view addSubview: self.cardInfoView];
```
This will start the interface for user to fillin the card info.
<br />    

#### 2.5.2, Card Info View Delegate:
The card Info View delegate (IOTCardInfoViewDelegate) has one func in protocl:  
func onDidCompleteValidately() { }
This func will be called once after users' fillin all the required info viliadly, so you know when to make the "Add Card" button to ready for user input.
```
Swift
extension ViewController: IOTCardInfoViewDelegate {
	func onDidCompleteValidately() {
		// User did complete card info view Validately, we should enable the button
		button.setTitle("Purchase", for: .normal)
		button.isUserInteractionEnabled = true
	}
}
```
```
Objc .h
@interface ViewController : UIViewController <IOTCardInfoViewDelegate>

Objc .m
- (void)onDidCompleteValidately {
	// User did complete card info view Validately, we should enable the button
	[self.button setTitle: @"Purchase" forState: UIControlStateNormal];
	[self.button setUserInteractionEnabled: true];
}
```
Please don't forget to add "IOTCardInfoViewDelegate" in the previous step.
<br />      

#### 2.5.3, Send the Request
After user filling the card info and tap on the "Add User" sending the request by:
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
As you noted, we added the delegate again and set it to self in the above code. This time, the delegate will help you to receive the server response.

#### 2.5.4, NetworkService Response Delegate:
```
Swift
extension ViewController: IOTNetworkServiceDelegate {
	func onDidAddCard(desensitizedCardInfo: IOTDesensitizedCardInfo, redirectUrl: String) {
		// This is for AddCard event. You can lease this blank for simplePurchase Event.
	}

	func onDidPurchase(purchaseReceipt: IOTPurchaseReceipt, redirectUrl: String) {
		/* .oneTimePurchase action's network response if successd.
		There is a error checklist in the github guide to help you fix the error
		*/
		print("successd", purchaseReceipt.info)
	}
}
```
```
Objc .h
@interface ViewController : UIViewController <IOTCardInfoViewDelegate, IOTNetworkServiceDelegate>

Objc .m
- (void)onDidAddCardWithDesensitizedCardInfo:(IOTDesensitizedCardInfo * _Nonnull) desensitizedCardInfo 
 				 redirectUrl:(NSString * _Nonnull)redirectUrl {
	// This is for AddCard event. You can lease this blank for simplePurchase Event.
}

- (void)onDidPurchaseWithPurchaseReceipt:(IOTPurchaseReceipt * _Nonnull) purchaseReceipt 
 			     redirectUrl:(NSString * _Nonnull)redirectUrl {
	/* .oneTimePurchase action's network response if successd.
	There is a error checklist in the github guide to help you fix the error
	*/
	NSLog(@"successed %@", purchaseReceipt.info);
}
```

Please check the SimplePurchaseSwiftExample or SimplePurchaseObjcExample in the examples folder for finished code.



<br />      
## 3 Data reference:
#action: 
```
enum IOTNetworkRequestAction {
	case addCard           // add card, you will receive desensitizated card info after the network request.
	case simplePurchase    // one time payment, without saving user's payment method
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



## 4 temporty secureID
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
		
