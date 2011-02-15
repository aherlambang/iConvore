//
//  LoginViewController.h
//  Convore
//
//  Created by Aditya Herlambang on 2/14/11.
//  Copyright 2011 University of Arizona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Base64.h"

@class LoginViewController;

@protocol LoginViewControllerDelegate

- (void) viewController:(LoginViewController*)viewCon loginWithUsername:(NSString*)username andPassword:(NSString*)password;

@end


@interface LoginViewController : UIViewController <UITextFieldDelegate>{
	UITextField * _username;
	UITextField * _password;
	UIButton * login;
	NSArray * results;
	id <LoginViewControllerDelegate> delegate;
}

@property (nonatomic, retain) IBOutlet UITextField * _username;
@property (nonatomic, retain) IBOutlet UITextField * _password;
@property (nonatomic, retain) IBOutlet UIButton * login;
@property (nonatomic, retain) NSArray * results;

- (IBAction) loginClick: (id) sender;

@property (nonatomic, assign) id <LoginViewControllerDelegate> delegate;

@end
