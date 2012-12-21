//
//  MAPhotoAlbumVC.m
//  CNB
//
//  Created by 馬文培 on 12-11-22.
//  Copyright (c) 2012年 馬文培. All rights reserved.
//

#import "MAPhotoAlbumVC.h"
#import "SDWebImageDataSource.h"

@implementation MAPhotoAlbumVC

@synthesize activityIndicator=_activityIndicatorView;
@synthesize imageArray=_imageArray;
@synthesize images=_images;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _imageArray = [[NSMutableArray alloc] init];
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityIndicator setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin];
    [activityIndicator setCenter:[[self view] center]];
    [activityIndicator startAnimating];
    [self setActivityIndicator:activityIndicator];
    
    [[self view] addSubview:[self activityIndicator]];
    
    // Label back button as "Back".
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"返回", @"Back button title") style:UIBarButtonItemStylePlain target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:backButton];
    
    [self fetchPhotos];
    [self setDataSource:[self photos]];
    self.title = @"相册";
    
    
}
- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (SDWebImageDataSource *)photos
{
    return _images;
}
- (void)fetchPhotos
{
    _images = [[SDWebImageDataSource alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
    [MAPhotoAlbum getPhotoAlbumWithBlock:^(NSArray *photoAlbumArray, NSError *error) {
        if (error) {
            [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK", nil), nil] show];
        } else {
            [_imageArray removeAllObjects];
            for(int i=0;i<photoAlbumArray.count;i++){
                MAPhotoAlbum *photoAlbum=[photoAlbumArray objectAtIndex:i];
                [_imageArray addObject:[NSArray arrayWithObjects:photoAlbum.fullSizeImagePath,photoAlbum.thumbnailPath, nil]];
            }
            _images.image=_imageArray;
            [[self activityIndicator] stopAnimating];
            [self reloadThumbs];
        }
        
    }];
}

@end
