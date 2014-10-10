//
//  TableCellTableViewCell.m
//  myProj
//
//  Created by Rahul Garg on 07/07/14.
//  Copyright (c) 2014 Rahul. All rights reserved.
//

#import "TableCellTableViewCell.h"

@implementation TableCellTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
