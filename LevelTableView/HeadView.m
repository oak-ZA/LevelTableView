//
//  HeadView.m
//  LevelTableView
//
//  Created by 张奥 on 2019/11/18.
//  Copyright © 2019 张奥. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.titleButton.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [self.titleButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.titleButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.titleButton];
    }
    return self;
}

-(void)layoutSubviews{
    self.titleButton.frame = self.bounds;
}
-(void)clickButton:(UIButton *)button{
    if (_delegate && [_delegate respondsToSelector:@selector(selectTag:)]) {
        [_delegate selectTag:self.tag];
    }
}
@end
