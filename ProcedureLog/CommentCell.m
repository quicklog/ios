//
//  CommentCell.m
//  ProcedureLog
//
//  Created by Kieran Gutteridge on 26/01/2013.
//  Copyright (c) 2013 Intohand Ltd. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    self.commentText.text = @"";
    self.commentText.textColor = [UIColor blackColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(self.commentText.text.length == 0){
        self.commentText.textColor = [UIColor lightGrayColor];
        self.commentText.text = @"Comment";
        [self.commentText resignFirstResponder];
    }
}

@end
