//
//  GroupViewController.m
//  Convore
//
//  Created by Aditya Herlambang on 2/14/11.
//  Copyright 2011 University of Arizona. All rights reserved.
//

#import "GroupViewController.h"


@implementation GroupViewController
@synthesize login;
@synthesize results;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
	self.navigationItem.title = @"Groups";
	
	NSURL *url = [NSURL URLWithString:@"https://convore.com/api/groups.json"];  
	
	NSError *myError = nil;  
	
	// create a plaintext string in the format username:password
	login = [[LoginViewController alloc] init];
	
	NSMutableString *loginString = (NSMutableString*)[@"" stringByAppendingFormat:@"%@:%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"username"], [[NSUserDefaults standardUserDefaults] objectForKey:@"password"]]; 
	
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
	NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	//NSString *result = [NSString stringWithCString:[data bytes] length:[data length]]; 
	results = [[[result JSONValue] retain] objectForKey:@"groups"];
	/*
	for (NSDictionary *element in results) {
		// 3. the value of the "user" key is itself another object/dictionary
		// with various key-value pairs
		NSDictionary *user = [element objectForKey:@"user"];
		NSString *title = [user objectForKey:@"name"];
		NSLog(@"%@", title);
	}

	*/
	[self.tableView reloadData];
	//NSLog(@"%d", [results count]);
	    [super viewDidLoad];

	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [results count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	NSMutableDictionary *cellValue = [results objectAtIndex:indexPath.row];
	
	
	NSString *picURL = [[cellValue objectForKey:@"creator"] objectForKey:@"url"];
	if ((picURL != (NSString *) [NSNull null]) && (picURL.length !=0)) {
		NSData *imgData = [[[NSData dataWithContentsOfURL:
							 [NSURL URLWithString:
							  [[cellValue objectForKey:@"creator"] objectForKey:@"url"]]] autorelease] retain];
		cell.image = [[UIImage alloc] initWithData:imgData];
		
	} else {
		cell.image = nil;
	}
	
	
	//NSLog(@"Name is : %@", [cellValue objectForKey:@"name"]);
	cell.textLabel.text = [cellValue objectForKey:@"name"];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
	
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
	[login release];
    [super dealloc];
}


@end

