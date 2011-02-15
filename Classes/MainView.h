//
//  MainView.h
//  Convore
//
//  Created by Aditya Herlambang on 2/14/11.
//  Copyright 2011 University of Arizona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface MainView : UITabBarController <LoginViewControllerDelegate>{
	BOOL needsLoginInfo;
	
}

@end
