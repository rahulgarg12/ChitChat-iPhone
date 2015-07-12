//
//  SecondViewController.h
//  myProj
//
//  Created by Rahul Garg on 03/07/14.
//  Copyright (c) 2014 Rahul. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SecondViewController : UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

- (IBAction)imageBtn:(id)sender;
- (IBAction)fileBtn:(id)sender;

@property (retain, nonatomic) IBOutlet UITextView *textView;

-(void)loadImageFromPath:(NSURL *) imageURL;
-(void)storeImageToPath;

@end
