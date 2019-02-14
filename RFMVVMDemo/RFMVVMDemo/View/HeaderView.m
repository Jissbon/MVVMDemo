

#import "HeaderView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@implementation HeaderView{
    UIImageView *topImage;
    NSMutableArray *dataArray;
    UIButton *button;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)headerViewWithData:(id)data{
    dataArray = data;
    
    CGFloat btnWidth  = SCREEN_WIDTH * 0.17;
    CGFloat btnHeight = SCREEN_WIDTH * 0.17;
    CGFloat margin=(SCREEN_WIDTH-5*btnWidth)/6;
    
    for (int i = 0; i <dataArray.count; i++) {
        
        int row = i % 5;
        int loc = i / 5;
        CGFloat appviewx=margin+(margin+btnWidth)*row;
        CGFloat appviewy=5 + (10+btnHeight)*loc;
        
        button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.frame = CGRectMake(appviewx, appviewy, btnWidth, btnHeight);
        button.highlighted = NO;
        button.tag = [dataArray[i][@"id"] integerValue];
        
        [button setImage:[UIImage imageNamed:dataArray[i][@"icon"]] forState:UIControlStateNormal];
        
        button.userInteractionEnabled = YES;
        [button addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:button];
    }

}

- (void)button:(UIButton *)btn{
    NSString *shopId = [NSString stringWithFormat:@"%ld",(long)btn.tag];
    if (self.block) {
        self.block(shopId);
    }
}


@end
