//
//  SDWebImageDataSource.m
//  Sample
//
//  Created by Kirby Turner on 3/18/10.
//  Copyright 2010 White Peak Software Inc. All rights reserved.
//

#import "SDWebImageDataSource.h"
#import "KTPhotoView+SDWebImage.h"
#import "KTThumbView+SDWebImage.h"

#define FULL_SIZE_INDEX 0
#define THUMBNAIL_INDEX 1

@implementation SDWebImageDataSource

- (void)dealloc {
    [images_ release], images_ = nil;
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        // Create a 2-dimensional array. First element of
        // the sub-array is the full size image URL and
        // the second element is the thumbnail URL.
        
        images_ = [[NSMutableArray alloc] init];
        // Do any additional setup after loading the view, typically from a nib.
        
        NSArray *arr = [MARESTfulRequest getJSONArrayByPath:@"/image/photo/url" JSONKey:@"vPhotoalbum" Parameter:nil];
        for(int i=0;i<arr.count;i++){
            NSDictionary *vPhotoalbum = [arr   objectAtIndex:i];
            NSString *fullSizeImagePath = [vPhotoalbum   objectForKey:@"fullSizeImagePath"];
            NSString *thumbnailPath = [vPhotoalbum   objectForKey:@"thumbnailPath"];
            [images_ addObject:[NSArray arrayWithObjects:fullSizeImagePath,thumbnailPath, nil]];
        }
        
    }
    return self;
}


#pragma mark -
#pragma mark KTPhotoBrowserDataSource

- (NSInteger)numberOfPhotos {
    NSInteger count = [images_ count];
    return count;
}

- (void)imageAtIndex:(NSInteger)index photoView:(KTPhotoView *)photoView {
    
    NSArray *imageUrls = [images_ objectAtIndex:index];
    NSString *url = [imageUrls objectAtIndex:FULL_SIZE_INDEX];
    [photoView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"photoDefault.png"]];
}

- (void)thumbImageAtIndex:(NSInteger)index thumbView:(KTThumbView *)thumbView {
    
    NSArray *imageUrls = [images_ objectAtIndex:index];
    NSString *url = [imageUrls objectAtIndex:THUMBNAIL_INDEX];
    [thumbView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"photoDefault.png"]];
}


@end
