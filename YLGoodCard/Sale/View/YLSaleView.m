//
//  YLSaleView.m
//  YLGoodCard
//
//  Created by lm on 2018/11/2.
//  Copyright © 2018 Chenzhiming. All rights reserved.
//

#import "YLSaleView.h"
#import "YLSaleButton.h"

@interface YLSaleView ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *numberL;
<<<<<<< HEAD
@property (nonatomic, strong) UITextField *telephoneT;
=======
//@property (nonatomic, strong) UIButton *addressBtn;
@property (nonatomic, strong) UITextField *telephone;
//@property (nonatomic, strong) UIButton *saleBtn;
//@property (nonatomic, strong) UIButton *consultBtn; // 咨询
//@property (nonatomic, strong) UIButton *appraiseBtn;// 估价
>>>>>>> parent of 1116516... a
@property (nonatomic, strong) UILabel *label1; // 位车主提交卖车申请
//@property (nonatomic, strong) UILabel *label2; // 请选择城市及检测中心

@end

@implementation YLSaleView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupOriginal];
    }
    return self;
}

- (void)setupOriginal {
    
    UIImageView *icon = [[UIImageView alloc] init];
//    icon.backgroundColor = YLRandomColor;
    icon.image = [UIImage imageNamed:@"汽车"];
    [self addSubview:icon];
    self.icon = icon;
    
    UILabel *numberL = [[UILabel alloc] init];
    numberL.textColor = YLColor(44.f, 172.f, 63.f);
    numberL.text = @"123456";
    numberL.textAlignment = NSTextAlignmentCenter;
    numberL.font = [UIFont systemFontOfSize:30];
//    numberL.backgroundColor = YLRandomColor;
    [self addSubview:numberL];
    self.numberL = numberL;
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"位车主提交了卖车申请";
    label1.textColor = YLColor(110.f, 110.f, 110.f);
//    label1.backgroundColor = YLRandomColor;
    [self addSubview:label1];
    self.label1 = label1;
    
//    UILabel *label2 = [[UILabel alloc] init];
//    label2.text = @"请选择城市及检测中心";
//    label2.textColor = YLColor(110.f, 110.f, 110.f);
////    label2.backgroundColor = YLRandomColor;
//    [self addSubview:label2];
//    self.label2 = label2;
    
//    UIButton *addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [addressBtn setTitle:@"阳江市马曹路888号" forState:UIControlStateNormal];
//    addressBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
//    [addressBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
////    addressBtn.backgroundColor = YLRandomColor;
//    [self addSubview:addressBtn];
//    self.addressBtn = addressBtn;
    
    self.saleBtn = [YLSaleButton buttonWithType:UIButtonTypeCustom];
    [self.saleBtn setTitle:@"预约卖车" forState:UIControlStateNormal];
<<<<<<< HEAD
    self.saleBtn.type = YLConditionTypeBlue;
    self.saleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.saleBtn.tag = 301;
=======
    [self.saleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
>>>>>>> parent of 1116516... a
    [self.saleBtn addTarget:self action:@selector(sale:) forControlEvents:UIControlEventTouchUpInside];
    [self.saleBtn setBackgroundColor:YLColor(44.f, 172.f, 63.f)];
    [self addSubview:self.saleBtn];
    
    self.consultBtn = [YLSaleButton buttonWithType:UIButtonTypeCustom];
    [self.consultBtn setTitle:@"免费咨询" forState:UIControlStateNormal];
<<<<<<< HEAD
    self.consultBtn.type = YLConditionTypeWhite;
    self.consultBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.consultBtn.tag = 302;
=======
    [self.consultBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
>>>>>>> parent of 1116516... a
    [self.consultBtn addTarget:self action:@selector(consult:) forControlEvents:UIControlEventTouchUpInside];
    [self.consultBtn setBackgroundColor:YLColor(238.f, 238.f, 238.f)];
    [self addSubview:self.consultBtn];
    
    self.appraiseBtn = [YLSaleButton buttonWithType:UIButtonTypeCustom];
    [self.appraiseBtn setTitle:@"爱车估价" forState:UIControlStateNormal];
<<<<<<< HEAD
    self.appraiseBtn.type = YLConditionTypeWhite;
    self.appraiseBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.appraiseBtn.tag = 303;
=======
    [self.appraiseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
>>>>>>> parent of 1116516... a
    [self.appraiseBtn addTarget:self action:@selector(appraise:) forControlEvents:UIControlEventTouchUpInside];
    [self.appraiseBtn setBackgroundColor:YLColor(238.f, 238.f, 238.f)];
    [self addSubview:self.appraiseBtn];
    
    UITextField *telephone = [[UITextField alloc] init];
    telephone.placeholder = @"请输入手机号";
    telephone.backgroundColor = YLColor(238.f, 238.f, 238.f);
    [self addSubview:telephone];
    self.telephoneT = telephone;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    float margin = 15;
    float margin1 = 10;
    float iconW = self.frame.size.width;
    float iconH = 130;
    self.icon.frame = CGRectMake(0, 64, iconW, iconH);
    
    float numberX = margin;
    float numberY = CGRectGetMaxY(self.icon.frame) + margin;
    float numberW = 116;
    float numberH = 36;
    self.numberL.frame = CGRectMake(numberX, numberY, numberW, numberH);
    
    float label1X = CGRectGetMaxX(self.numberL.frame) + margin1;
    float label1Y = numberY;
    float label1W = 200;
    float label1H = numberH;
    self.label1.frame = CGRectMake(label1X, label1Y, label1W, label1H);
    
//    float label2X = margin;
//    float label2Y = CGRectGetMaxY(self.numberL.frame) + margin1;
//    float label2W = label1W;
//    float label2H = label1H;
//    self.label2.frame = CGRectMake(label2X, label2Y, label2W, label2H);
    
//    float addressBtnX = margin;
//    float addressBtnY = CGRectGetMaxY(self.label2.frame);
//    float addressBtnW = label2W;
//    float addressBtnH = label2H;
//    self.addressBtn.frame = CGRectMake(addressBtnX, addressBtnY, addressBtnW, addressBtnH);
    
    float telephoneX = numberX;
    float telephoneY = CGRectGetMaxY(self.numberL.frame) + margin1;
    float telephoneW = iconW - 2 * margin;
    float telephoneH = 40;
    self.telephoneT.frame = CGRectMake(telephoneX, telephoneY, telephoneW, telephoneH);
    
    float salaBtnX = margin;
    float salaBtnY = CGRectGetMaxY(self.telephoneT.frame) + margin1;
    float salaBtnW = iconW - 2 * margin;
    float salaBtnH = 40;
    self.saleBtn.frame = CGRectMake(salaBtnX, salaBtnY, salaBtnW, salaBtnH);
    
    float consultBtnX = margin;
    float consultBtnY = CGRectGetMaxY(self.saleBtn.frame) + margin1;
    float consultBtnW = (iconW - 2 * margin - margin1) / 2;
    float consultBtnH = salaBtnH;
    self.consultBtn.frame = CGRectMake(consultBtnX, consultBtnY, consultBtnW, consultBtnH);
    
    float appraiseBtnX = CGRectGetMaxX(self.consultBtn.frame) + margin1;
    float appraiseBtnY = consultBtnY;
    float appraiseBtnW = consultBtnW;
    float appraiseBtnH = consultBtnH;
    self.appraiseBtn.frame = CGRectMake(appraiseBtnX, appraiseBtnY, appraiseBtnW, appraiseBtnH);
    
}

<<<<<<< HEAD
// 估价
- (void)appraise:(UIButton *)sender {
    
    NSLog(@"点击了估价按钮");
    [self.telephoneT resignFirstResponder];
    if (self.appraiseBtn.delegate && [self.appraiseBtn.delegate respondsToSelector:@selector(pushController:)]) {
=======
- (void)setModel:(YLSaleViewModel *)model {
    
    _model = model;
}

- (void)appraise:(YLSaleButton *)sender {
    
    NSLog(@"点击了爱车估价:%@", sender.titleLabel.text);
    if (self.appraiseBtn.delegate && [self.appraiseBtn.delegate respondsToSelector:@selector(pushController)]) {
>>>>>>> parent of 1116516... a
        [self.appraiseBtn.delegate pushController:sender];
    }
    if (self.appraiseBlock) {
        self.appraiseBlock(self.telephoneT.text);
    }
}
<<<<<<< HEAD
// 咨询
- (void)consult:(UIButton *)sender {
    
    NSLog(@"点击了咨询按钮");
    [self.telephoneT resignFirstResponder];
    if (self.consultBtn.delegate && [self.consultBtn.delegate respondsToSelector:@selector(pushController:)]) {
        [self.consultBtn.delegate pushController:sender];
    }
}
// 预约卖车
- (void)sale:(UIButton *)sender {
    
    NSLog(@"点击了预约卖车按钮");
    [self.telephoneT resignFirstResponder];
    if (self.saleBtn.delegate && [self.saleBtn.delegate respondsToSelector:@selector(pushController:)]) {
=======

- (void)consult:(YLSaleButton *)sender {
    
    NSLog(@"点击了免费咨询:%@", sender.titleLabel.text);
    if (self.consultBtn.delegate && [self.consultBtn.delegate respondsToSelector:@selector(pushController)]) {
        [self.consultBtn.delegate pushController:sender];
    }
}

- (void)sale:(YLSaleButton *)sender {
    
    NSLog(@"点击了预约卖车:%@", sender.titleLabel.text);
    if (self.saleBtn.delegate && [self.saleBtn.delegate respondsToSelector:@selector(pushController)]) {
>>>>>>> parent of 1116516... a
        [self.saleBtn.delegate pushController:sender];
    }
    if (self.saleTelBlock) {
        self.saleTelBlock(self.telephoneT.text);
    }
}

<<<<<<< HEAD
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.telephoneT resignFirstResponder];
}

- (void)setTelephone:(NSString *)telephone {
    _telephone = telephone;
    self.telephoneT.text = telephone;
}

=======
>>>>>>> parent of 1116516... a
@end
