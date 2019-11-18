//
//  HeadView.h
//  LevelTableView
//
//  Created by 张奥 on 2019/11/18.
//  Copyright © 2019 张奥. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeadViewDelegate<NSObject>
-(void)selectTag:(NSInteger)tag;
@end

@interface HeadView : UITableViewHeaderFooterView
@property (nonatomic, weak) id<HeadViewDelegate>delegate;
@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, assign) NSInteger tag;
@end
