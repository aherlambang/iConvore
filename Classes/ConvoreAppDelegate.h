//
//  ConvoreAppDelegate.h
//  Convore
//
//  Created by Aditya Herlambang on 2/14/11.
//  Copyright 2011 University of Arizona. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainView.h"

@interface ConvoreAppDelegate : NSObject <UIApplicationDelegate> {
	MainView * main;
	UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MainView * main;


@end

