//
//  TableCell.h
//  myProj
//
//  Created by Rahul Garg on 07/07/14.
//  Copyright (c) 2014 Rahul. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TableCellDelegate <NSObject>
@optional
- (void)deleteButtonTappedOnCell:(id)sender;
@end

@interface TableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (nonatomic, strong) id <TableCellDelegate> delegate;

@end
