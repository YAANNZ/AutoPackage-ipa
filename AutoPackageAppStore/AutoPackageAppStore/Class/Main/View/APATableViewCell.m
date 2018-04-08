//
//  APATableViewCell.m
//  AutoPackageAppStore
//
//  Created by ZHUYN on 2018/4/3.
//  Copyright © 2018年 zynabc. All rights reserved.
//

#import "APATableViewCell.h"

@interface APATableViewCell ()

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *versionLabel;
@property (nonatomic, weak) UILabel *createLabel;
@property (nonatomic, weak) UIButton *updateButton;

@end

@implementation APATableViewCell

+ (APATableViewCell *)tableViewCell:(UITableView *)tableView
{
    static NSString *cellID = @"APACellID";
    APATableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[APATableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setSubviews];
    }
    return self;
}

- (void)setSubviews
{
    UIImageView *iconImageView = [[UIImageView alloc] init];
    self.iconImageView = iconImageView;
    iconImageView.layer.cornerRadius = 5;
    iconImageView.clipsToBounds = YES;
    [self.contentView addSubview:iconImageView];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    self.nameLabel = nameLabel;
    nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:nameLabel];
    
    UILabel *versionLabel = [[UILabel alloc] init];
    self.versionLabel = versionLabel;
    versionLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:versionLabel];
    
    UILabel *createLabel = [[UILabel alloc] init];
    self.createLabel = createLabel;
    createLabel.textColor = [UIColor lightGrayColor];
    createLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:createLabel];
    
    UIButton *updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.updateButton = updateButton;
    updateButton.layer.cornerRadius = 3;
    [updateButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [updateButton setBackgroundColor:[UIColor lightGrayColor]];
    [updateButton setTitle:@"暂无更新" forState:UIControlStateNormal];
    [updateButton addTarget:self action:@selector(updateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:updateButton];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.width.height.equalTo(@40);
        make.centerY.equalTo(@0);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(5);
        make.top.equalTo(@5);
    }];
    
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(5);
        make.bottom.equalTo(@-5);
    }];
    
    [self.updateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.top.equalTo(@5);
        make.width.equalTo(@80);
        make.height.equalTo(@20);
    }];
     
    [self.createLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-10);
        make.bottom.equalTo(@-5);
        make.width.equalTo(@80);
        make.height.equalTo(@20);
    }];
}

- (void)setAppInfo:(APAAppInfo *)appInfo
{
    _appInfo = appInfo;
    
    if (appInfo.isOld)
    {
        [self.updateButton setTitle:@"更新" forState:UIControlStateNormal];
        [self.updateButton setBackgroundColor:[UIColor redColor]];
    }
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:appInfo.icon_url] placeholderImage:[UIImage imageNamed:@"icon"]];
    
    self.nameLabel.text = appInfo.name;
    
    self.versionLabel.text = [NSString stringWithFormat:@"v%@-%@", appInfo.master_release.versionStr, appInfo.master_release.buildStr];
    
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:[appInfo.master_release.created_at integerValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    self.createLabel.text = [dateFormatter stringFromDate:createDate];
}

- (void)updateButtonClicked:(UIButton *)updatebButton
{
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-services://?action=download-manifest&url=https://download.fir.im/apps/:id/install?download_token=xxxxxx"]];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
