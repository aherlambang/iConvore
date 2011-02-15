//
//  LoginViewController.m
//  Convore
//
//  Created by Aditya Herlambang on 2/14/11.
//  Copyright 2011 University of Arizona. All rights reserved.
//

#import "LoginViewController.h"


@implementation LoginViewController
@synthesize _username;
@synthesize _password;
@synthesize login;
@synthesize delegate;

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
	[_username setDelegate:self];
	[_password setDelegate:self];
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
	NSMutableString *loginString = (NSMutableString*)[@"" stringByAppendingFormat:@"%@:%@", _username.text, _password.text]; 
	
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
	if ([result isEqualToString:@"{\"error\": \"User matching query does not exist.\"}"]){
		NSLog(@"Combination of username and password can't be found");
	}else {
		[self.delegate viewController:self loginWithUsername:_username.text andPassword:_password.text];
	
		results = [[result JSONValue] retain];
		
		//for (NSString * element in results)
	}

	
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
	[_username release];
	[_password release];
	[results release];
    [super dealloc];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	[textField resignFirstResponder];
	
	return YES;
	
}


@end
