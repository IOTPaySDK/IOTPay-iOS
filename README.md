# IOTPay-iOS
###### IOTPay Framework for iOS


IOTPay-iOS is a smiple to use yet powerful Framework helps you with the online payment for iOS apps.



## Step 1: Install IOTPay-iOS form pod.

For Pod reference and how-to, please follow this link:
https://guides.cocoapods.org/using/the-podfile.html




## Step 2: Declare the view before viewDidLoad:
```
var cardInfoView: IOTCardInfoViewSingleLine!
```

Add following code in ViewController after viewDidLoad

```
cardInfoView = IOTCardInfoViewSingleLine(action: .addUser, style: .roundRect)
view.addSubview(cardInfoView)
```
This will start the interface for user to fillin the card info.




## Step 3: Once it's done, sending the request by
```
IOTNetworkManager.shared.sendRequest(secureId: "your secureId", cardInfoPrivder: cardInfoView)
```
That's all we need for basic setup to add a card!
(You will need to set up a button for sendRequest after user filling the info)
For sample example, please check sampleExample. (NOT YET)





## Data reference:
action: 
.addUser to add new user.
.oneTimePayment for oneTimePament

style:
.roundRect
.darkInfo
.lightInfo

cardInfoPrivder:
Should file in the name/pointer of the view that user filling in the info.

secureId:
This was generated by IOTPay server, you need to register IOTPay acct first, then following the steps to host a merchandise server.
For more detials about secureId and merchandise server, please visit:
https://develop.iotpay.ca


