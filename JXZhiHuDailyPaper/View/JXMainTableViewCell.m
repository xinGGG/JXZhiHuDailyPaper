//
//  JXMainTableViewCell.m
//  JXZhiHuDailyPaper
//
//  Created by xing on 16/12/20.
//  Copyright © 2016年 ljx. All rights reserved.
//

#import "JXMainTableViewCell.h"
#import "JXStorieModel.h"

@interface JXMainTableViewCell()
@property (nonatomic,strong) UIImageView    *_imgV;
@property (nonatomic,strong) UILabel        *_titleLabel;
@end

@implementation JXMainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//setupCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
        [self layout];
        
    }
    return  self;
}

- (void)addView{
    self._imgV = [UIImageView newAutoLayoutView];
    [self.contentView addSubview:self._imgV];
    
    self._titleLabel = [UILabel newAutoLayoutView];
    self._titleLabel.font = CFONT;
    self._titleLabel.textColor = [UIColor blackColor];
    self._titleLabel.numberOfLines = 0;
    [self.contentView addSubview:self._titleLabel];
}


- (void)layout{
    [self._imgV autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.contentView withOffset:-15];
    [self._imgV autoSetDimension:ALDimensionWidth toSize:60];
    [self._imgV autoSetDimension:ALDimensionHeight toSize:60];
    [self._imgV autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contentView];
    
    [self._titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.contentView withOffset:15];
    [self._titleLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.contentView withOffset:15];
    [self._titleLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self._imgV withOffset:15];
    [self._titleLabel autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.contentView withOffset:-15];
}

-(void)setModel:(JXStorieModel *)model{
    _model = model;
    if(model.images.count>0){
        [self._imgV sd_setImageWithURL:[NSURL URLWithString:[model.images firstObject]] placeholderImage:nil];
    }
    self._titleLabel.text = model.title;
    
}

@end
