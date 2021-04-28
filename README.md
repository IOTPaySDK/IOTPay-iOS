# IOTPay-iOS
#### IOTPay - Online Credit Card Payment Framework for iOS/Android/php
<br />    


## 1. Features:
#### *-Highly customizable*
#### *-Secure*
#### *-Easy to set up*<br />   


Quick Start:<br />   
```
For Swift:
cardInfoView = IOTCardInfoViewSingleLine(action: .addCard, style: .roundRect)  
IOTNetworkService.shared.sendRequest(secureId: "Your secureId", cardInfoView: cardInfoView)
```
```
For Objc: 
IOTCardInfoViewSingleLine *cardInfoView = [[IOTCardInfoViewTripleLineNCardView alloc] initWithAction: IOTNetworkRequestActionOneTimePurchase 
											       style:  IOTCardInfoViewStyleRoundRect];	
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
The easiest way to install the framework and keep it upon date is using cocoaPod. CocoaPod is one of the most commonly used Xcode library & framework dependency management software. For Pod reference and how-to install pod, please follow this link:https://guides.cocoapods.org/using/the-podfile.html
<br />  
Once you have cocoaPod installed, open the Terminal (Mac command line/CLI) and set the directory to your project, one level above the MyProject.xcodeproj file.
```
cd ~/Path/to/Folder/MyProject
```
A easier way to do so is type cd, space, and drag the project folder to the Terminal, then input enter.<br />  Once it set to the project directory, enter the follow line to initiate the pod:
```
pod init
```
The pod init command will make a Podfile in your project folder. This text file is the manager of the framework and library for you app. Now let's try to editing it by tap on Podfile or type "open Podfile' in Terminal.<br />  Open the pod file by any text editor, then enter the following lines
```
target 'MyApp' do    
	pod 'IOTPayiOS', '~> 4.0'
end
```
The first and last line is probably there already, so you will just need to fill in the middle line.<br />  
And finally, save and close the text editor, then enter the following command in Terminal.
```
pod install
```
The cocoaPod will start installing.
<br />  <br />      


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
<br /> 
IOTPay provide two options for the payment, "Recuring Purchase" and "Simple Purchase". Please choose the one based on your needs.<br /> 

#### 2.3.1 Option A: "Simple Purchase"

Simple Purchase will ask the user to fill in card info and do a ONE time payment, the card info shouldn't be stored. In the future, users will have to fill in the card info field again to do another purchase.

This framework should be used/re-init for each simple purchase event.

#### 2.3.2 Sample Purchase Flow

![alt text](https://github.com/IOTPaySDK/IOTPay-iOS/blob/main/ReadmeImages/APIV3MobileAppSDK2.png "Logo Title Text 3")

<br />  

#### 2.3.3 Simple Purchase Parameters Table:
*This table only shows the data/response between Merchant App/Server and IOT AppSDK/Server. Since either IOT to IOT or Merchant to Merchant is relevant to the topic.*

```
2. Simple Purchase Request:
Merchant Server -> IOT Pay Server
Parameters
name	  	required	type		sample				description
mchId			y	String(30)	10000701			assigned by IOTPay
mchOrderNo		y	String(30)	1234567890abc			assigned by merchant
amount			y	Int		1500				in cents
currency		y	String(3)	CAD				for now only CAD supported
loginName		y	String(12)	jack123				merchant's login name
subject			n	String(64)		
body			n	String(250)		
notifyUrl		y	String(200)					get notify when success
returnUrl		y	String(200)					redirect to this url after payment
sign			y	String(32)	C380BEC2BFD727A4B6845133519F3AD6 Sign algorithm



3. Secure Id Response:
IOT Pay Server -> Merchant Server
Response
name		required	type		sample				description
retCode			y	String		SUCCESS or FAIL	
retMsg			y	String		
retData.redirectUrl	y	String						if retCode=SUCCESS, merchant redirect to this url
retData.secureId	y	String						For SDK integration only



5. Secure ID 
Merchant App -> IOTPay SDK
name		required	type		sample				description
secureId		y	String						For SDK integration

7. Simple Purchase Notification
IOT Pay Server -> Merchant Server
NotifyUrl message(post request in json format)
name		required	type		sample				description
payOrderId		y	String		SUCCESS or FAIL	
mchId			y	String		
mchOrderNo		y	String		
originalOrderId		y	String						original pay order id if payType=refund
amount			y	Int		100				in cents
currency		y	String		CAD	
payType			y	String		pay or refund	
refundable		y	Int		100				in cents
status			y	Int		2				2 or 3 means success
invoiceNum		y	String		SUCCESS or FAIL	
paySuccTime		y	String		2021-04-07 19:44:51	
cardNum			y	String		432567******2266	
cardType		y	String		V or	
expiryDate		y	String		SUCCESS or FAIL	
authNum			y	String		
transNum		y	String		
sign			y	String(32)	C380BEC2BFD727A4B6845133519F3AD6 Sign algorithm



8. Simple Purchase Resonese: 
IOTPay SDK -> Merchant App
name		required	type		sample				description
amount	 			Int   						Int in cent
authNum 			String
cardNum 			String		424242XXXXXX4242		desensitizated 
cardType 			String 		V				V=Visa, M=Master, D=Interact
currency 			String 		CAD
expiryDate 			String 		1122
invoiceNum 			String 		832828793487
mchId 				String		10000576
mchOrderNo 			String	 	1618569175
originalOrderId			String  
payOrderId 			String 		CS20210416103255832828793487
paySuccTime			String		2021-04-16 03:33:16
payType		 		String		pay
redirectUrl			String		
refundable			Int   						Int in cent
status	 			Int   		2
transNum 			String   	000108583539
```



<br />  
#### 2.4.1 Option B: "Recurving Purchase"
<br />  
This option is ideal for users to store the card info. All the purchases after that will not need the user to fill in the card info again.Upon user fillin the card info for the first time, the merchant should generate a unique "cardId" and send this to the server. This "cardId" will be the reference for this user's future purchase. 

There are two steps in Recurving Purchase: "Add Card" & "Purchase with token":Please note that only "Add Card" involves Merchant App -> IOT App SDK -> IOT Server flow.After the Add card Event, the App will only need to send a request to your own mechant server, which will interact with IOTPay server and get response/receipt back to the App. This framework(SDK) should not be used again, unless the user wants to add another card, or do a one time purchase with another card. 
<br /> 

#### 2.4.2 Recurving Purchase Flow
![alt text](https://github.com/IOTPaySDK/IOTPay-iOS/blob/main/ReadmeImages/APIV3MobileAppSDK0.png "Logo Title Text 3")
![alt text](https://github.com/IOTPaySDK/IOTPay-iOS/blob/main/ReadmeImages/APIV3MobileAppSDK1.png "Logo Title Text 3")


#### 2.4.3 Recurving Purchase: Add Card Parameters Table:
*This table only shows the data/response between Merchant App/Server and IOT AppSDK/Server. Since either IOT to IOT or Merchant to Merchant is relevant to the topic.*

```
2. Add Card Request:
Merchant Server -> IOT Pay Server
Endpoint: https://api.iotpaycloud.com/v3/cc_addcard
Reqeust method: POST
Content-Type: application/json;charset=UTF-8
Parameters
name			required	type		sample					description
mchId			y		String(30)	10000701				assigned by IOTPay
cardId			y		String(30)	604567999				assigned by merchant,must be unique
loginName		y		String(12)	jack123					merchant's login name
returnUrl		y		String(200)						redirect to this url after payment
sign			y		String(32)	C380BEC2BFD727A4B6845133519F3AD6	Sign algorithm
each cardId can bind only one credit card, if one user need to bind more cards, use different cardId


3. Secure Id Response:
IOT Pay Server -> Merchant Server
Response
name			required	type		sample					description
retCode			y		String		SUCCESS or FAIL	
retMsg			y		String		
retData.redirectUrl	y		String							if retCode=SUCCESS, merchant redirect to this url
retData.secureId	y		String							used for sdk integration

ReturnUrl parameters
name			required	type		sample					description
retCode			y		String		SUCCESS or FAIL
retMsg			n		String		


5. Secure Id:
Merchant App -> IOTPay SDK
name			required	type		sample				description
secureId		y		String						For SDK integration


8. Add Card Response:
IOT Pay Server -> IOTPay SDK
name			required	type		sample				description
cardId					String                                          Has to be a unique id in Merchant Server
cardNum 				String
cvv					String
expiryDate				String
holder					String
redirectUrl				String
```

#### 2.4.4 Recurving Purchase: Purchase with Token Parameters Table:
*This table only shows the data/response between Merchant App/Server and IOT AppSDK/Server. Since either IOT to IOT or Merchant to Merchant is relevant to the topic.*

```
2 Purchase with Token Request
Merchant Server -> IOT Pay Server
Endpoint: https://api.iotpaycloud.com/v3/cc_purchasewithtoken
Reqeust method: POST
Content-Type: application/json;charset=UTF-8
Parameters
name			required	type		sample					description
mchId			y		String(30)	10000701				assigned by IOTPay
mchOrderNo		y		String(30)	1234567890abc				assigned by merchant
cardId			y		String(30)	604567999				assigned by merchant
amount			y		Int		1500					in cents
currency		y		String(3)	CAD					for now only CAD supported
loginName		y		String(12)	jack123	m				erchant's login name
subject			n		String(64)		
body			n		String(250)		
sign			y		String(32)	C380BEC2BFD727A4B6845133519F3AD6	Sign algorithm


3 Purchase with Token Response
IOT Pay Server -> Merchant Server
Response
name			required	type		sample					description
retCode			y		String		SUCCESS or FAIL	
retMsg			y		String		
retData			y		JSON							if retCode=SUCCESS, order detailed info returned

```

<br /> 

To start the next step, you will need:
- IOTPayiOS Framework Installed  (Refer to the first part in this guide)
- A Merchant account from IOTPay (Register @ https://iotpay.ca/1666-2/)


Optional:<br /> 

- Merchant Server (refer to https://develop.iotpay.ca)	
<br /> 

For production, Merchant/client should build their own "Merchant Server", 
which will generate the "secureId". For the testing phase, there is a shortcut to generate Testing secureId without Merchant server. 
Please check 5.1 Temporary solution to get secureId at the end of this guide.    
<br />  


<br />  
### 2.4 "Add Card" + "Purchase Token" Option:
#### 2.4.1 Setup Card Info View:
Declare the view before viewDidLoad. 
This is not mandatory for displaying the view, but you will need this view's point to send a request in the next step.
```
Swift:
var cardInfoView: IOTCardInfoViewSingleLine!
```
```
Objc: 
(in .h, Between @interface & @end) 
@property (nonatomic, retain) IOTCardInfoViewTripleLineNCardView *cardInfoView;
```
Add following code in ViewController after viewDidLoad
```
Swift:
cardInfoView = IOTCardInfoViewSingleLine(action: .addCard, style: .roundRect)
cardInfoView.Delegate = selfview.addSubview(cardInfoView)
```
```
Objc: (in .m)
self.cardInfoView = [[IOTCardInfoViewTripleLineNCardView alloc] initWithAction: IOTNetworkRequestActionOneTimePurchase 
									 style: IOTCardInfoViewStyleRoundRect];
self.cardInfoView.delegate = self;[self.view addSubview: self.cardInfoView];
```
This will start the interface for the user to fill in the card info.<br />    

#### 2.4.2 Card Info View Delegate:

The card Info View delegate (IOTCardInfoViewDelegate) has one func in protocol:  onDidCompleteValidately()


This func will be called once after users' fill in all the required info viliadly, so you know when to make the "Add Card" button ready for user input.
```
Swift:
extension ViewController: IOTCardInfoViewDelegate {	
	func onDidCompleteValidately() {		
		// User did complete card info view Validately, we should enable the button		
		button.setTitle("Add Card", for: .normal)		
		button.isUserInteractionEnabled = true	
	}
}
```
```
Objc: .h
@interface ViewController : UIViewController <IOTCardInfoViewDelegate>

.m
- (void)onDidCompleteValidately {	
	// User did complete card info view Validately, we should enable the button	
	[self.button setTitle: @"Add Card" forState: UIControlStateNormal];	
	[self.button setUserInteractionEnabled: true];
}
```
Please don't forget to add "IOTCardInfoViewDelegate" in the previous step.<br />  

#### 2.4.3 Send the Request
After user filling the card info and tap on the "Add User" sending the request by:
```
Swift:
let shard = IOTNetworkManager.shared
shard.delegate = self
shard.sendRequest(secureId: "your secureId", cardInfoPrivder: cardInfoView)
```
```
Objc:
IOTNetworkService *shard = IOTNetworkService.shared;
shard.delegate = self;
[shard sendRequestWithSecureId: @"Your secureId" cardInfoView:self.cardInfoView];
```
As you noted, we added the delegate again and set it to self in the above code. This time, the delegate will help you to receive the server response.

#### 2.4.4 NetworkService Response Delegate:
```
Swift:
extension ViewController: IOTNetworkServiceDelegate {	
func onDidAddCard(desensitizedCardInfo: IOTDesensitizedCardInfo, redirectUrl: String) {		
	/* 
	.addCard action's network response if successed.		
	There is a error checklist in the github guide to help you fix the error		
	*/
	print("successed", desensitizedCardInfo.info)	
}
	
func onDidPurchase(purchaseReceipt: IOTPurchaseReceipt, redirectUrl: String) {	
	/* 
	This is for Simple Purchase event, it has nothing to do with "purchase with token" in the next step. 
	You can lease this blank for addCard Event.	
	*/

	print("successed", purchaseReceipt.info)	
	}
}
```
```
Objc: .h
@interface ViewController : UIViewController <IOTCardInfoViewDelegate, IOTNetworkServiceDelegate>

.m
- (void)onDidAddCardWithDesensitizedCardInfo:(IOTDesensitizedCardInfo * _Nonnull) desensitizedCardInfo 				 
				 redirectUrl:(NSString * _Nonnull)redirectUrl {	
				 // This is for the addCard event. You can lease this blank for simplePurchase Event.
}

- (void)onDidPurchaseWithPurchaseReceipt:(IOTPurchaseReceipt * _Nonnull) purchaseReceipt
  			     redirectUrl:(NSString * _Nonnull)redirectUrl {	
	NSLog(@"successed %@", purchaseReceipt.info);
}
```
You should record some of that info to associate the user account/device to your Merchant Server. The future purchase should use "purchase with token" from now on, except your user wants to add or pay with a new card.
Please check the AddUserSwiftExample or AddUserObjcExample in the examples folder for finished code.



### 2.5 "Simple Purchase" Option:

#### 2.5.1 Setup Card Info View:
Declare the view before viewDidLoad. This is not mandatory for displaying the view, but you will need this view's point to send a request in the next step.
```
Swift:
var cardInfoView: IOTCardInfoViewSingleLine!
```
```
Objc: 
(in .h, Between @interface & @end)
@property (nonatomic, retain) IOTCardInfoViewTripleLineNCardView *cardInfoView;
```

Add following code in ViewController after viewDidLoad
```
Swift:
cardInfoView = IOTCardInfoViewSingleLine(action: .simplePurchase, style: .roundRect)
cardInfoView.Delegate = selfview.addSubview(cardInfoView)
```
```
Objc: (in .m)
self.cardInfoView = [[IOTCardInfoViewTripleLineNCardView alloc] initWithAction: IOTNetworkRequestActionSimplePurchase 
									 style: IOTCardInfoViewStyleRoundRect];
self.cardInfoView.delegate = self;[self.view addSubview: self.cardInfoView];
```
This will start the interface for the user to fill in the card info.<br />   

#### 2.5.2 Card Info View Delegate:
The card Info View delegate (IOTCardInfoViewDelegate) has one func in protocol:  func onDidCompleteValidately() { }
This func will be called once after users' fill in all the required info viliadly, so you know when to make the "Add Card" button ready for user input.
```
Swift:
extension ViewController: IOTCardInfoViewDelegate {	
	func onDidCompleteValidately() {		
		// User did complete card info view Validately, we should enable the button		
		button.setTitle("Purchase", for: .normal)		
		button.isUserInteractionEnabled = true	
	}
}
```
```
Objc: .h
@interface ViewController : UIViewController <IOTCardInfoViewDelegate>

.m
- (void)onDidCompleteValidately {	
	// User did complete card info view Validately, we should enable the button	
	[self.button setTitle: @"Purchase" forState: UIControlStateNormal];	
	[self.button setUserInteractionEnabled: true];
}
```
Please don't forget to add "IOTCardInfoViewDelegate" in the previous step.<br />   

#### 2.5.3 Send the Request
After user filling the card info and tap on the "Add User" sending the request by:
```
Swift:
let shard = IOTNetworkManager.shared
shard.delegate = self
shard.sendRequest(secureId: "your secureId", cardInfoPrivder: cardInfoView)
```
```
Objc:
IOTNetworkService *shard = IOTNetworkService.shared;
shard.delegate = self;
[shard sendRequestWithSecureId: @"Your secureId" cardInfoView:self.cardInfoView];
```
As you noted, we added the delegate again and set it to self in the above code. This time, the delegate will help you to receive the server response.

#### 2.5.4 NetworkService Response Delegate:
```
Swift:
extension ViewController: IOTNetworkServiceDelegate {	
	func onDidAddCard(desensitizedCardInfo: IOTDesensitizedCardInfo, redirectUrl: String) {		
		// This is for the AddCard event. You can lease this blank for simplePurchase Event.	
	}
	
	func onDidPurchase(purchaseReceipt: IOTPurchaseReceipt, redirectUrl: String) {		
		/* 
		.simplePurchase action's network response if succeeded.		
		There is a error checklist in the github guide to help you fix the error		
		*/		
		print("succeeded", purchaseReceipt.info)	
	}
}
```
```
Objc: in .h
@interface ViewController : UIViewController <IOTCardInfoViewDelegate, IOTNetworkServiceDelegate>

in .m
- (void)onDidAddCardWithDesensitizedCardInfo:(IOTDesensitizedCardInfo * _Nonnull) desensitizedCardInfo  
				 redirectUrl:(NSString * _Nonnull)redirectUrl {	
	// This is for the AddCard event. You can lease this blank for simplePurchase Event.
}

- (void)onDidPurchaseWithPurchaseReceipt:(IOTPurchaseReceipt * _Nonnull) purchaseReceipt  			     
			     redirectUrl:(NSString * _Nonnull)redirectUrl {	
	/* 
	.simplePurchase action's network response if succeeded. 
	There is a error checklist in the github guide to help you fix the error
	*/
	NSLog(@"successed %@", purchaseReceipt.info);
}
```
Please check the SimplePurchaseSwiftExample or SimplePurchaseObjcExample in the examples folder for finished code.


<br />      
## 3 Data Reference:
#action: 
```
enum IOTNetworkRequestAction {	
	case addCard           // add card, you will receive desensitization card info after the network request.	
	case simplePurchase    // one time payment, without saving user's payment method
}
```

#style: 
```
enum IOTCardInfoViewStyle {	
	case roundRect	
	case infoLight	
	case infoDark   
	case autoDetectDarkMode
}
```

#cardInfoPrivder: 
```
IOTCardInfoView
```
Should fill in the name/pointer of the view that the user is filling in the info, this is required for sending the request.



## 4 Temporary secureID
#secureId:
<br />   

You will need a secureId for "sendRequest".
For production, clients/Merchant should build their own "Merchant Server", which will generate the "secureId". For testing, you can use the following temporary solution to get secureId:    

### - Step 1: Get Merchant Id

Register an IOTPay account to get the "Merchant Id", "Merchant Key" and "loginName"  

### - Step 2: Get Temporary secureId

For "one time purchase", please visit:   https://develop.iotpay.ca/new/v3dev/purchase.html   

For "add card", please visit   https://develop.iotpay.ca/new/v3dev/addcard.html    

Fill in the account info requested on the page, then press "Submit" button. Check the URL in the browser, it will looks like following: 

https://ccdev.iotpaycloud.com/cc/addcard?key=cf383bf97a7288f4a4f6a2741ec56df51a1cacb48a90b77f6b9198d928fc84f2   

Copy the string after "addcard?key=", and use it as the temporary secureId. This secureId will be valid for an hour.
(cf383bf97a7288f4a4f6a2741ec56df51a1cacb48a90b77f6b9198d928fc84f2 is the secureId in the above case.)
