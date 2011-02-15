//
//  MainView.m
//  Convore
//
//  Created by Aditya Herlambang on 2/14/11.
//  Copyright 2011 University of Arizona. All rights reserved.
//

#import "MainView.h"


@implementation MainView

- (void)setup {
    needsLoginInfo = YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [self setup];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (needsLoginInfo) {
        LoginViewController* lvc = [[LoginViewController alloc] init];
        lvc.delegate = self;
        [self presentModalViewController:lvc animated:NO];
        [lvc release];
    }
}

- (void) viewController:(LoginViewController *)viewCon loginWithUsername:(NSString*)username andPassword:(NSString*)password
{
    [self dismissModalViewControllerAnimated:YES];
    NSLog(@"%@ %@", username, password);
    //Store the info here somehow so that it can be viewed anywhere
    NSUserDefaults* userSettings = [NSUserDefaults standardUserDefaults];
    [userSettings setObject:username forKey:@"username"];
    [userSettings setObject:password forKey:@"password"];
    needsLoginInfo = NO;
}


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
