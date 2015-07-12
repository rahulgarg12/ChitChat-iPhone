//
//  SecondViewController.m
//  myProj
//
//  Created by Rahul Garg on 03/07/14.
//  Copyright (c) 2014 Rahul. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
UIImage* image;
int mediaCount;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _textView.delegate = (id) self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)fileBtn:(id)sender {
}

- (IBAction)imageBtn:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

#pragma mark - ImageView delegate methods implementation

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (160*mediaCount), 150, 150)];
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    [imageView setImage:image];
    
    [_textView addSubview:imageView];
    mediaCount = mediaCount + 1;
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark - UITextField Delegate method implementation

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textView resignFirstResponder];
    return YES;
}

#pragma mark - private methods implementation

-(void)loadImageFromPath:(NSURL *) imageURL {
    NSString *resourcePath = [[NSString alloc] init];
    resourcePath = [imageURL absoluteString];
    
    image = [UIImage imageWithContentsOfFile:resourcePath];
}


-(void)storeImageToPath {
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [filePaths objectAtIndex:0];
    NSString* writeImagePath = [documentsDirectory stringByAppendingPathComponent:@"ChitChat.png" ];
    NSData* data = UIImagePNGRepresentation(image);
    [data writeToFile:writeImagePath atomically:YES];
}

@end
