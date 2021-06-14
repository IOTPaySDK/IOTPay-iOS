//
//  ViewController.h
//  AddCardObjcExample
//
//  Created by macbook on 2021-04-25.
//

#import <UIKit/UIKit.h>
#import <IOTPayiOS/IOTPayiOS-Swift.h>

@interface ViewController : UIViewController <IOTCardInfoViewDelegate, IOTNetworkAddCardDelegate>

@property (nonatomic, retain) IOTCardInfoViewTripleLineOnCardView *cardInfoView;
@property (nonatomic, retain) UIButton *button;

@end

