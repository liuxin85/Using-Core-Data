//
//  VocabulariesViewController.m
//  Using Core Data
//
//  Created by liuxin on 14-7-2.
//  Copyright (c) 2014年 liu xin. All rights reserved.
//

#import "VocabulariesViewController.h"

@interface VocabulariesViewController ()

@end

@implementation VocabulariesViewController

- (void)fetchVocabularies
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Vocabulary"];
    NSString *cacheName = [@"Vocabulary" stringByAppendingString:@"Cache"];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc]
                                     initWithFetchRequest: fetchRequest
                                     managedObjectContext:self.managedObjectContext
                                     sectionNameKeyPath:nil
                                     cacheName:cacheName];
    NSError *error;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Fetch failed: %@", error);
    }
}

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context
{
    self = [super initWithStyle: UITableViewStylePlain];
    if (self) {
        self.managedObjectContext = context;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Vocabularies";
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self
                                  action:@selector(add)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    
    
    [self fetchVocabularies];
    // Preload with a "Spanish" Vocabulary if empty
    if (self.fetchedResultsController.fetchedObjects.count == 0) {
        NSEntityDescription *vocabularyEntityDescription =
        [NSEntityDescription entityForName:@"Vocabulary" inManagedObjectContext:self.managedObjectContext];
        
        Vocabulary *spanishVocabulary = (Vocabulary *)[[NSManagedObject alloc]
                                                       initWithEntity:vocabularyEntityDescription insertIntoManagedObjectContext:self.managedObjectContext];
        spanishVocabulary.name = @"Spannish";
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Error saving context: %@", error);
        }
        [self fetchVocabularies];
    }
}
- (void)add
{
    UIAlertView *inputAlert = [[UIAlertView alloc]initWithTitle:@"New Vocabulary"
                                                        message:@"Enter a name for the new vocabulary"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK", nil];
    inputAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [inputAlert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSEntityDescription *vocabularyEntityDescription =
        [NSEntityDescription entityForName:@"Vocabulary"
                    inManagedObjectContext:self.managedObjectContext];
        Vocabulary *newVocabulary = (Vocabulary *)[[NSManagedObject alloc]
                                                   initWithEntity:vocabularyEntityDescription insertIntoManagedObjectContext:self.managedObjectContext];
        newVocabulary.name = [alertView textFieldAtIndex:0].text;
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Error saving context: %@", error);
        }
        [self fetchVocabularies];
        [self.tableView reloadData];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return self.fetchedResultsController.fetchedObjects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *CellIdentifier = @"VocabularyCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle: UITableViewCellStyleValue1
                                     reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    Vocabulary *vocabulary = (Vocabulary *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = vocabulary.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"(%d)", vocabulary.words.count];
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
