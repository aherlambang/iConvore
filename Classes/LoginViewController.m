//
//  LoginViewController.m
//  Convore
//
//  Created by Aditya Herlambang on 2/14/11.
//  Copyright 2011 University of Arizona. All rights reserved.
//

#import "LoginViewController.h"


@implementation LoginViewController
@synthesize username;
@synthesize password;
@synthesize login;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[username setDelegate:self];
	[password setDelegate:self];
    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (IBAction) loginClick: (id) sender
{
	NSURL *url = [NSURL URLWithString:@"https://convore.com/api/account/verify.json"];  
	
	NSError *myError = nil;  
	
	// create a plaintext string in the format username:password  
	NSMutableString *loginString = (NSMutableString*)[@"" stringByAppendingFormat:@"%@:%@", username, password]; 
	NSLog(@"%@", username.text);
	NSLog(@"%@", password.text);
	
	// employ the Base64 encoding above to encode the authentication tokens  
	NSString *encodedLoginData = [Base64 encode:[loginString dataUsingEncoding:NSUTF8StringEncoding]];  
	
	// create the contents of the header   
	NSString *authHeader = [@"Basic " stringByAppendingFormat:@"%@", encodedLoginData];  
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: url  
														   cachePolicy: NSURLRequestReloadIgnoringCacheData    
													   timeoutInterval: 3];     
	
	// add the header to the request.  Here's the $$$!!!  
	[request addValue:authHeader forHTTPHeaderField:@"Authorization"];  
	
	// perform the reqeust  
	NSURLResponse *response;  
	
	NSData *data = [NSURLConnection    
					sendSynchronousRequest: request    
					returningResponse: &response    
					error: &myError];    
	//*error = myError;  
	
	// POW, here's the content of the webserver's response.  
	NSString *result = [NSString stringWithCString:[data bytes] length:[data length]]; 
	NSLog(@"%@", result);
}

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

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	[textField resignFirstResponder];
	
	return YES;
	
}


@end
