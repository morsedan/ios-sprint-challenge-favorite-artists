//
//  ArtistDetailViewController.h
//  DMOArtistsWeek14SprintChallenge
//
//  Created by morse on 1/24/20.
//  Copyright © 2020 morse. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DMOArtistController;
@class DMOArtist;

@interface DMOArtistDetailViewController : UIViewController <UISearchBarDelegate>

@property DMOArtistController *artistController;
@property DMOArtist *artist;

@end
