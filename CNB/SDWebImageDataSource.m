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
@synthesize image=_image;


- (id)init {
    self = [super init];
    if (self) {
        // Create a 2-dimensional array. First element of
        // the sub-array is the full size image URL and
        // the second element is the thumbnail URL.        
    }
    return self;
}

#pragma mark -
#pragma mark KTPhotoBrowserDataSource

- (NSInteger)numberOfPhotos {
    NSInteger count = [_image count];
    return count;
}

- (void)imageAtIndex:(NSInteger)index photoView:(KTPhotoView *)photoView {
    
    NSArray *imageUrls = [_image objectAtIndex:index];
    NSString *url = [imageUrls objectAtIndex:FULL_SIZE_INDEX];
    [photoView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"photoDefault.png"]];
}

- (void)thumbImageAtIndex:(NSInteger)index thumbView:(KTThumbView *)thumbView {
    
    NSArray *imageUrls = [_image objectAtIndex:index];
    NSString *url = [imageUrls objectAtIndex:THUMBNAIL_INDEX];
    [thumbView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"photoDefault.png"]];
}

- (UIImage *)imageAtIndex:(NSInteger)index
{
    NSArray *imageUrls = [_image objectAtIndex:index];
    NSString *url = [imageUrls objectAtIndex:FULL_SIZE_INDEX];
    NSData* data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
    return [[UIImage alloc] initWithData:data];
}
- (NSString *)ImageURLAtIndex:(NSInteger)index
{
    NSArray *imageUrls = [_image objectAtIndex:index];
    NSString *url = [imageUrls objectAtIndex:FULL_SIZE_INDEX];
    return url;
}
@end
