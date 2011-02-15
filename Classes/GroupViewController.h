//
//  GroupViewController.h
//  Convore
//
//  Created by Aditya Herlambang on 2/14/11.
//  Copyright 2011 University of Arizona. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "Base64.h"
#include "LoginViewController.h"

@interface GroupViewController : UITableViewController {
	LoginViewController * login;
	NSArray * results;
}

@property (nonatomic, retain) LoginViewController * login;
@property (nonatomic, retain) NSArray * results;

@end
