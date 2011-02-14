//
//  LoginViewController.h
//  Convore
//
//  Created by Aditya Herlambang on 2/14/11.
//  Copyright 2011 University of Arizona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Base64.h"


@interface LoginViewController : UIViewController <UITextFieldDelegate>{
	UITextField * username;
	UITextField * password;
	UIButton * login;
	
}

@property (nonatomic, retain) IBOutlet UITextField * username;
@property (nonatomic, retain) IBOutlet UITextField * password;
@property (nonatomic, retain) IBOutlet UIButton * login;

- (IBAction) loginClick: (id) sender;

@end
