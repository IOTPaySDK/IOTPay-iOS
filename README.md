# IOTPay-iOS
###### IOTPay Framework for iOS
<br />    


IOTPay-iOS is a smiple to use yet powerful Framework helps you with the online payment for iOS apps.

![alt text](https://github.com/IOTPaySDK/IOTPay-iOS/blob/main/simpleGIF.gif "Logo Title Text 1") ![alt text](https://github.com/IOTPaySDK/IOTPay-iOS/blob/main/TripleGif.gif "Logo Title Text 1")

<br />      

## 1.1: Install SDK
First you will need the cocoaPod, a standard Xcode library & framework depandency managment software.
For Pod reference and how-to, please follow this link:
https://guides.cocoapods.org/using/the-podfile.html

Once you have cocoaPod, use command line to enter
```
pod init
```
This line will add a pod file in the xcode project folder.
Open the pod file by any text editor, enter the following line between 
```
target 'MyApp' do
    pod 'IOTPayiOS', '~> 4.0'
end
```
And finaly, close the text editor, enter the following command in CMD
```
pod install
```





<br />      

## 2 Integrade "Add Card" Event

#2.1 Import framework
```
Swift
import IOTPayiOS
```
Objc (in .h)
```
#import <IOTPayiOS/IOTPayiOS-Swift.h>
```

#2.2 Setup View
Declare the view before viewDidLoad. This is not mandatory for display the view, but you will need it for the send request event in step 3.
```
Swift
var cardInfoView: IOTCardInfoViewSingleLine!
```
Objc: in .h (Between @interface & @end)
```
@property (nonatomic, retain) IOTCardInfoViewTripleLineNCardView *cardInfoView;
```

Add following code in ViewController after viewDidLoad
```
Swift:
cardInfoView = IOTCardInfoViewSingleLine(action: .addUser, style: .roundRect)
view.addSubview(cardInfoView)
```
This will start the interface for user to fillin the card info.



<br />      

## Step 3: Send the Request
After user filling the card info, sending the request by:
```
IOTNetworkManager.shared.sendRequest(secureId: "your secureId", cardInfoPrivder: cardInfoView)
```
That's all we need for basic setup to add a card!
(You will need to set up a button for sendRequest after user filling the info)
For sample example, please check sampleExample. 
- SimpleDemo 

For more usage, such as delegate to let you know user filling the vliad info and complete, or more style/layout settings, please check the other examples:
- TripleLineDemo (NOT yet)
- DelegateDemo (NOT yet)
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
		
