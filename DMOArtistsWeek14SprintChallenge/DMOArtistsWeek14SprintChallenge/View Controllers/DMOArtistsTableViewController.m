//
//  ArtistsTableViewController.m
//  DMOArtistsWeek14SprintChallenge
//
//  Created by morse on 1/24/20.
//  Copyright © 2020 morse. All rights reserved.
//

#import "DMOArtistsTableViewController.h"
#import "DMOArtistController.h"
#import "DMOArtist.h"
#import "DMOArtistDetailViewController.h"

@interface DMOArtistsTableViewController ()

@end

@implementation DMOArtistsTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _controller = [[DMOArtistController alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.controller loadFromPersistentStore];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    NSLog(@"viewWillAppear");
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.controller.savedArtists.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArtistCell" forIndexPath:indexPath];
    
    DMOArtist *artist = self.controller.savedArtists[indexPath.row];
    NSString *dateString = [self yearString:artist];
    
    cell.textLabel.text = artist.name;
    cell.detailTextLabel.text = dateString;
    
    return cell;
}

- (NSString *)yearString:(DMOArtist *)artist {
    if (artist.year != 0) {
        return [NSString stringWithFormat:@"%i", artist.year];
    } else {
        return @"Not available";
    }
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        DMOArtist *artist = self.controller.savedArtists[indexPath.row];
        [self.controller removeArtist:artist];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        [tableView reloadData];
    }
}

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


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    DMOArtistDetailViewController *detailVC = segue.destinationViewController;
    detailVC.artistController = self.controller;
    
    if ([segue.identifier isEqualToString:@"ShowArtistDetailSegue"]) {
        DMOArtist *artist = self.controller.savedArtists[indexPath.row];
        detailVC.artist = artist;
    }
}


@end
