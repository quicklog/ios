//
//  RatingCell.h
//  ProcedureLog
//
//  Created by Kieran Gutteridge on 26/01/2013.
//  Copyright (c) 2013 Intohand Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RSTapRateView.h"

@interface RatingCell : UITableViewCell

@property (strong, nonatomic) IBOutlet RSTapRateView *starRatingView;

@end
