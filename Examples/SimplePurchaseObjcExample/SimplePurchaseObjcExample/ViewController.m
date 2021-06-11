
//
//  ViewController.m
//  SimplePurchaseObjcExample
//
//  Created by macbook on 2021-04-25.
//


#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	/*
	For a more detailed guide,
	please visit: https://github.com/IOTPaySDK/IOTPay-iOS
	*/

	/* Setup IOT card info view, you can choose from any layouts below:
	IOTCardInfoViewSingleLineNCardIcon
	IOTCardInfoViewTripleLineNCardView
	IOTCardInfoViewTripleLine
	We will use IOTCardInfoViewSingleLineNCardIcon in this example
	action: (enum) either .addCard or .oneTimePurchase
	style: (enum) Choose any style fit your app.
	For auto - Nightmode detection, please use .autoNightmode
	*/
	self.cardInfoView = [[IOTCardInfoViewTripleLineNCardView alloc]
		initWithAction: IOTNetworkRequestActionOneTimePurchase style: IOTCardInfoViewStyleAutoDarkModeSupport];
	self.cardInfoView.center = CGPointMake(self.view.frame.size.width * 0.5,
																				 self.cardInfoView.frame.size.height * 0.5 + 50.0);
	/* set delegate
	this is the IOTCardInfoViewDelegate,
	which will let you know when user the input correctly
	*/
	self.cardInfoView.delegate = self;
	[self.view addSubview: self.cardInfoView];


	/* make a button for submit network request once user finished input,
	starts as interation Enabled state
	*/
	CGRect buttonRect = CGRectMake(self.view.frame.size.width * 0.5 - 150.0,
																	self.cardInfoView.frame.size.height + 50.0 + 50.0, 300.0, 50.0);
	self.button = [[UIButton alloc] initWithFrame: buttonRect];
	[self.button setTitleColor: UIColor.systemBlueColor forState: UIControlStateNormal];
	[self.button setTitle: @"Please enter card info" forState: UIControlStateNormal];
	[self.button setUserInteractionEnabled: false];
	[self.button addTarget:self action:@selector(onButton) forControlEvents:UIControlEventTouchDown];
	[self.view addSubview: self.button];


}

-(void)onButton {
	IOTNetworkService *shard = IOTNetworkService.shared;
	shard.delegate = self;
	[shard sendRequestWithSecureId: @"Your SecureId" cardInfoView:self.cardInfoView];
	[self.button setTitle: @"Please enter card info" forState: UIControlStateNormal];
	[self.button setUserInteractionEnabled: true];
}


- (void)onDidCompleteValidate {
	// User did complete card info view Validate, we should enable the button
	[self.button setTitle: @"Purchase" forState: UIControlStateNormal];
	[self.button setUserInteractionEnabled: true];
}

- (void)onDidAddCardWithDesensitizedCardInfo:(IOTDesensitizedCardInfo * _Nonnull)
												desensitizedCardInfo redirectUrl:(NSString * _Nonnull)redirectUrl {
	/* .addCard action's network response if successd.
	There is a error checklist in the github guide to help you fix the error
	*/
	NSLog(@"successed %@", desensitizedCardInfo.info);
}

- (void)onDidPurchaseWithPurchaseReceipt:(IOTPurchaseReceipt * _Nonnull)purchaseReceipt
												redirectUrl:(NSString * _Nonnull)redirectUrl {
	/* .oneTimePurchase action's network response if successd.
	There is a error checklist in the github guide to help you fix the error
	*/
	NSLog(@"successed %@", purchaseReceipt.info);
}



@end


