//
//  PerfTestNeatByTableView.m
//  ALView
//
//  Created by 陈小雅 on 2017/2/14.
//  Copyright © 2017年 jdochen. All rights reserved.
//

#import "PerfTestNeatByTableView.h"
#import "UserInfoModel.h"
#import "NearByALEngineCell.h"
#import "NearByUIViewCell.h"

@interface PerfTestNeatByTableView() <UITableViewDelegate, UITableViewDataSource>

{
    UITableView * _tableView;
    NSMutableArray * _tableDataSource;
    NSInteger _currentIndex;
}

@end

@implementation PerfTestNeatByTableView

- (instancetype) initWithFrame:(CGRect) frame
{
    if ( self = [super initWithFrame:frame] ) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.opaque = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView setBackgroundColor:[UIColor clearColor]];
        [self addSubview: _tableView];
        [self initData];
    }
    return self;
}

- (void) initData
{
    NSArray * data = [NSArray arrayWithObjects:
  @{@"nick":@"Sunshine  Girl",@"description":@"0.14km 1小时",@"age":@(20),@"charmLevelTag":@"LV4",@"interest":@"去过昆明、广州、东莞、深圳；喜欢乒乓球、篮球、薯条",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"└半边心┐🐶",@"description":@"0.17km 15分钟",@"age":@(21),@"professionTag":@"学生",@"charmLevelTag":@"LV6",@"interest":@"喜欢吃甜、吃辣、特步、以纯、安踏、美特斯邦威、开心消消乐",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"你家小煞笔",@"description":@"2.06km 1小时前",@"age":@(2),@"charmLevelTag":@"LV1",@"richStateText":@"=￣ω￣ =      …",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"◕ิิ.◕ 傷 情 ζั͡ޓއއ",@"description":@"0.17km 42分钟",@"age":@(26),@"professionTag":@"IT",@"charmLevelTag":@"LV6",@"richStateText":@"‘",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"▓゛莪沒變、只是學會ㄋゝ",@"description":@"0.17km 2小时",@"age":@(24),@"professionTag":@"商业",@"charmLevelTag":@"LV6",@"richStateText":@"℡♥若在、何必给一个承诺、你就是我永远的依托↘",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"└半边心┐🐶",@"description":@"0.17km 37分钟",@"age":@(21),@"professionTag":@"学生",@"charmLevelTag":@"LV6",@"interest":@"喜欢吃甜、吃辣、特步、以纯、安踏、美特斯邦威、开心消消乐",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"◕ิิ.◕ 傷 情 ζั͡ޓއއ",@"description":@"0.17km 1小时",@"age":@(26),@"professionTag":@"IT",@"charmLevelTag":@"LV6",@"richStateText":@"‘",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"ruby小盆友",@"description":@"2.88km 44分钟前",@"age":@(18),@"charmLevelTag":@"LV1",@"richStateText":@"感谢陪伴",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"▓゛莪沒變、只是學會ㄋゝ",@"description":@"0.17km 2小时",@"age":@(24),@"professionTag":@"商业",@"charmLevelTag":@"LV6",@"richStateText":@"℡♥若在、何必给一个承诺、你就是我永远的依托↘",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"雪孩子",@"description":@"0.17km 19分钟",@"age":@(19),@"professionTag":@"教育",@"charmLevelTag":@"LV5",@"richStateText":@"不找了找不到了",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"└半边心┐🐶",@"description":@"0.17km 37分钟",@"age":@(21),@"professionTag":@"学生",@"charmLevelTag":@"LV6",@"interest":@"喜欢吃甜、吃辣、特步、以纯、安踏、美特斯邦威、开心消消乐",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"◕ิิ.◕ 傷 情 ζั͡ޓއއ",@"description":@"0.17km 1小时",@"age":@(26),@"professionTag":@"IT",@"charmLevelTag":@"LV6",@"richStateText":@"‘",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"ruby小盆友",@"description":@"2.88km 44分钟前",@"age":@(18),@"charmLevelTag":@"LV1",@"richStateText":@"感谢陪伴",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"▓゛莪沒變、只是學會ㄋゝ",@"description":@"0.17km 2小时",@"age":@(24),@"professionTag":@"商业",@"charmLevelTag":@"LV6",@"richStateText":@"℡♥若在、何必给一个承诺、你就是我永远的依托↘",@"sex":@(1),@"isVip":@(1)},
  @{@"nick":@"雪孩子",@"description":@"0.17km 19分钟",@"age":@(19),@"professionTag":@"教育",@"charmLevelTag":@"LV5",@"richStateText":@"不找了找不到了",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"快乐丑女孩！",@"description":@"0.17km 1小时",@"age":@(20),@"charmLevelTag":@"LV5",@"richStateText":@"努力+勤奋=幸福^O^",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"一笑而过",@"description":@"0.17km 7小时",@"age":@(18),@"charmLevelTag":@"LV5",@"richStateText":@"管你风雨，我有自己。",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"冷漠",@"description":@"0.17km 7小时",@"age":@(18),@"professionTag":@"学生",@"charmLevelTag":@"LV5",@"interest":@"喜欢欢乐斗地主、QQ飞车、榴莲",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"美人琪",@"description":@"8.09km 35分钟前",@"age":@(20),@"charmLevelTag":@"LV4",@"richStateText":@"#实力唱将##我要上推荐#",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"烈火焚心",@"description":@"0.17km 1小时",@"age":@(18),@"professionTag":@"学生",@"charmLevelTag":@"LV4",@"richStateText":@"记得要开心呦！",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"ヾ(@^▽^@)ノ",@"description":@"0.17km 1小时",@"age":@(32),@"charmLevelTag":@"LV4",@"richStateText":@"珍惜每一天。。。。。。。。。",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"诠世鎅供认莪想妳ジ♥",@"description":@"0.17km 3小时",@"age":@(22),@"professionTag":@"制造",@"charmLevelTag":@"LV4",@"richStateText":@"开了个小萌店 有时间进来逛逛吧",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"迷茫",@"description":@"0.17km 6小时",@"age":@(21),@"charmLevelTag":@"LV5",@"richStateText":@"简简单单每一天，",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"红玫瑰",@"description":@"0.74km 6小时",@"age":@(26),@"charmLevelTag":@"LV5",@"interest":@"喜欢天天酷跑、张学友、G.E.M.邓紫棋、周华健",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"Ling",@"description":@"1.11km 6小时",@"age":@(19),@"professionTag":@"制造",@"charmLevelTag":@"LV4",@"richStateText":@"上传了新的照片",@"sex":@(1),@"isVip":@(1)},
  @{@"nick":@"“拥抱Sun的Dena”",@"description":@"1.15km 2小时",@"age":@(19),@"charmLevelTag":@"LV7",@"richStateText":@"！",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"🍡Hello  stranger 👏",@"description":@"1.17km 5小时",@"age":@(19),@"charmLevelTag":@"LV6",@"richStateText":@"总有一天你会遇到一个恰如其分的人 ☀",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"-愿得一人心”",@"description":@"1.53km 1小时",@"age":@(22),@"charmLevelTag":@"LV3",@"richStateText":@"加入了厘米秀、恋爱吧部落",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"LRX",@"description":@"1.58km 33分钟",@"age":@(23),@"charmLevelTag":@"LV6",@"richStateText":@"安分守已！低调做人！！！",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"♥简单点@",@"description":@"1.64km 6小时",@"age":@(22),@"charmLevelTag":@"LV6",@"richStateText":@"最近比较忙.没能给你们回赞/请谅解😊",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"✨",@"description":@"1.78km 11分钟",@"age":@(18),@"charmLevelTag":@"LV5",@"richStateText":@"我没有想像中坚强 却找不到懦弱休息的地方?",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"泪痕",@"description":@"2.05km 2小时",@"age":@(22),@"professionTag":@"商业",@"charmLevelTag":@"LV5",@"richStateText":@"若是美好，叫做精彩，若是糟糕，叫做经历。不闲聊，有10赞回复！",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"孤独患者的世人",@"description":@"2.21km 5小时",@"age":@(18),@"professionTag":@"商业",@"charmLevelTag":@"LV6",@"richStateText":@"         时光取名叫无心i",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"蝶舞若翩",@"description":@"12.22km 刚刚",@"age":@(27),@"charmLevelTag":@"LV1",@"richStateText":@"每一个在你的生命里出现的人，都有原因。喜欢你的人给了你温暖和勇气。你喜欢的人让你学会了爱和自持。...",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"A$$$银行贷款 15815590815",@"description":@"2.21km 6小时",@"age":@(19),@"professionTag":@"金融",@"charmLevelTag":@"LV5",@"richStateText":@"越努力，越幸运",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"*      别回头",@"description":@"2.23km 8分钟",@"age":@(21),@"charmLevelTag":@"LV6",@"richStateText":@"每一段青春，到最后都会苍老，但我希望记忆里的你，一直都好。",@"commonLabel":@"湛江老乡",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"路丽",@"description":@"2.24km 1小时",@"age":@(20),@"charmLevelTag":@"LV6",@"richStateText":@"永远保持热情",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"someone",@"description":@"2.32km 2小时",@"age":@(27),@"charmLevelTag":@"LV5",@"interest":@"喜欢吃辣、吃肉、睡觉；去过深圳、西安、桂林、成都",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"爱笑帅艳",@"description":@"2.33km 1分钟",@"age":@(19),@"charmLevelTag":@"LV6",@"richStateText":@"十连点赞必回",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"姐的范┎你模范不来",@"description":@"2.40km 4小时",@"age":@(22),@"charmLevelTag":@"LV6",@"richStateText":@"可以愁，但绝不能低头。可以哭，但绝不能认输。",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"莉莉",@"description":@"2.97km 18分钟",@"age":@(21),@"professionTag":@"IT",@"charmLevelTag":@"LV4",@"richStateText":@"甜言蜜语只是一时。默默守护才是永久。",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"Alina蜜",@"description":@"3.21km 9分钟",@"age":@(26),@"charmLevelTag":@"LV6",@"interest":@"去过澳门、广州、大理、丽江、北京；喜欢街舞、睡觉",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"Erica❤️伊伊",@"description":@"12.24km 11分钟前",@"age":@(24),@"charmLevelTag":@"LV1",@"richStateText":@"祝各位没有情人的情人节快乐喔…挺住，这一天很快就过去了，哈哈!!!",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"米拉多",@"description":@"3.23km 2小时",@"age":@(31),@"charmLevelTag":@"LV4",@"richStateText":@"",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"枚魅🍓",@"description":@"3.42km 6小时",@"age":@(23),@"professionTag":@"商业",@"charmLevelTag":@"LV4",@"interest":@"去过墨脱、洛阳、丽江、拉萨、昆明；喜欢滑雪、搏击",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"媞誰ゐ伱侕厮守メ",@"description":@"3.65km 16分钟",@"age":@(19),@"charmLevelTag":@"LV3",@"richStateText":@"",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"眼一笑，却悲伤",@"description":@"4.89km 16分钟",@"age":@(19),@"charmLevelTag":@"LV5",@"interest":@"喜欢辣条、烧烤、薯条、火锅、吃辣、睡觉、羽毛球",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"莉莉",@"description":@"2.97km 18分钟",@"age":@(21),@"professionTag":@"IT",@"charmLevelTag":@"LV4",@"richStateText":@"甜言蜜语只是一时。默默守护才是永久。",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"Alina蜜",@"description":@"3.21km 9分钟",@"age":@(26),@"charmLevelTag":@"LV6",@"interest":@"喜欢街舞、睡觉；去过澳门、广州、大理、丽江、北京",@"sex":@(1),@"isVip":@(1)},
  @{@"nick":@"Erica❤️伊伊",@"description":@"12.24km 11分钟前",@"age":@(24),@"charmLevelTag":@"LV1",@"richStateText":@"祝各位没有情人的情人节快乐喔…挺住，这一天很快就过去了，哈哈!!!",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"米拉多",@"description":@"3.23km 2小时",@"age":@(31),@"charmLevelTag":@"LV4",@"richStateText":@"",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"枚魅🍓",@"description":@"3.42km 6小时",@"age":@(23),@"professionTag":@"商业",@"charmLevelTag":@"LV4",@"interest":@"喜欢滑雪、搏击；去过墨脱、洛阳、丽江、拉萨、昆明",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"媞誰ゐ伱侕厮守メ",@"description":@"3.65km 16分钟",@"age":@(19),@"charmLevelTag":@"LV3",@"richStateText":@"",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"眼一笑，却悲伤",@"description":@"4.89km 16分钟",@"age":@(19),@"charmLevelTag":@"LV5",@"interest":@"喜欢辣条、烧烤、薯条、火锅、吃辣、睡觉、羽毛球",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"另一个自已",@"description":@"1.94km 2小时",@"age":@(23),@"charmLevelTag":@"LV6",@"richStateText":@"这个世界上我只相信两个人，一个是我，另一个不是你。相互点赞，谢谢！",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"仅此而已",@"description":@"2.30km 4小时",@"age":@(20),@"professionTag":@"商业",@"charmLevelTag":@"LV4",@"richStateText":@"加入了厘米秀部落",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"黔城 意群门",@"description":@"2.34km 3小时",@"age":@(22),@"professionTag":@"商业",@"charmLevelTag":@"LV4",@"richStateText":@"没有天长地久 只有深情久伴",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"👙 Rude girl",@"description":@"2.41km 1小时",@"age":@(21),@"charmLevelTag":@"LV5",@"richStateText":@"向钱看向厚看",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"←═╬∞不完美的女孩",@"description":@"2.56km 3小时",@"age":@(18),@"professionTag":@"学生",@"charmLevelTag":@"LV6",@"richStateText":@"一个拥抱胜过所有言语",@"sex":@(1),@"isVip":@(1)},
  @{@"nick":@"晴🎀晴💖悦Ｒ",@"description":@"2.58km 6分钟",@"age":@(19),@"professionTag":@"艺术",@"charmLevelTag":@"LV3",@"richStateText":@"需要浇水的花，等GG来浇水…",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"晴晴💖",@"description":@"2.58km 8分钟",@"age":@(18),@"professionTag":@"艺术",@"charmLevelTag":@"LV3",@"richStateText":@"MM在这里等你，过来耍…",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"🍯賣蜂蜜的女孩🐝",@"description":@"3.01km 56分钟",@"age":@(25),@"professionTag":@"学生",@"charmLevelTag":@"LV5",@"interest":@"去过澳门、香港；喜欢王力宏、李治廷、天天爱消除、天天飞车、天天酷跑",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"运、",@"description":@"3.13km 4小时",@"age":@(18),@"professionTag":@"学生",@"charmLevelTag":@"LV6",@"richStateText":@"互赞互赞互赞！",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"玲玲",@"description":@"3.17km 18分钟",@"age":@(23),@"professionTag":@"IT",@"charmLevelTag":@"LV4",@"richStateText":@"甜言蜜语只是一时。默默守护才是永久。",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"默默",@"description":@"3.17km 19分钟",@"age":@(26),@"professionTag":@"商业",@"charmLevelTag":@"LV4",@"richStateText":@"往往没得回头的事才记得深刻，没有后悔药，让你抓狂让你崩溃就是忘不了。",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"*     璇宝児",@"description":@"3.81km 15分钟",@"age":@(20),@"charmLevelTag":@"LV7",@"richStateText":@"脾气古怪。",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"开心宝贝",@"description":@"3.90km 7小时",@"age":@(25),@"professionTag":@"行政",@"charmLevelTag":@"LV5",@"richStateText":@"一个人的心情，只有自己懂得",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"心已死|泪已干。",@"description":@"3.97km 1小时",@"age":@(23),@"charmLevelTag":@"LV5",@"richStateText":@"加入了女神汇、自拍部落",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"€淡忘那忧伤~",@"description":@"4.02km 25分钟",@"age":@(29),@"charmLevelTag":@"LV3",@"richStateText":@"让音乐的节奏跟着我们走",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"随心",@"description":@"4.37km 6小时",@"age":@(33),@"charmLevelTag":@"LV5",@"richStateText":@"生活，就是生下来活下去。",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"小可",@"description":@"4.68km 2小时",@"age":@(19),@"professionTag":@"艺术",@"charmLevelTag":@"LV5",@"richStateText":@"我爱你",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"喧哗i",@"description":@"4.89km 7小时",@"age":@(18),@"charmLevelTag":@"LV6",@"richStateText":@"上传了新的照片",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"🕊",@"description":@"5.02km 5小时",@"age":@(23),@"charmLevelTag":@"LV5",@"interest":@"去过深圳、郑州、北京、三亚、泰国；喜欢潜水、钓鱼",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"╃刪蒢记憶",@"description":@"5.32km 3小时",@"age":@(21),@"charmLevelTag":@"LV5",@"interest":@"喜欢泡芙、豆腐脑、吃肉、通灵之六世古宅、道士出山2伏魔军团、煎饼侠；去过深圳",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"*  feeling *  %",@"description":@"5.43km 7小时",@"age":@(21),@"professionTag":@"艺术",@"charmLevelTag":@"LV4",@"richStateText":@"旁观者清  当局者迷",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"随心",@"description":@"4.37km 6小时",@"age":@(33),@"charmLevelTag":@"LV5",@"richStateText":@"生活，就是生下来活下去。",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"小可",@"description":@"4.68km 2小时",@"age":@(19),@"professionTag":@"艺术",@"charmLevelTag":@"LV5",@"richStateText":@"我爱你",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"喧哗i",@"description":@"4.89km 7小时",@"age":@(18),@"charmLevelTag":@"LV6",@"richStateText":@"上传了新的照片",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"🕊",@"description":@"5.02km 5小时",@"age":@(23),@"charmLevelTag":@"LV5",@"interest":@"喜欢潜水、钓鱼；去过深圳、郑州、北京、三亚、泰国",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"╃刪蒢记憶",@"description":@"5.32km 3小时",@"age":@(21),@"charmLevelTag":@"LV5",@"interest":@"去过深圳；喜欢泡芙、豆腐脑、吃肉、通灵之六世古宅、道士出山2伏魔军团、煎饼侠",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"*  feeling *  %",@"description":@"5.43km 7小时",@"age":@(21),@"professionTag":@"艺术",@"charmLevelTag":@"LV4",@"richStateText":@"旁观者清  当局者迷",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"沁园春雪",@"description":@"1.78km 8小时",@"age":@(21),@"charmLevelTag":@"LV5",@"richStateText":@"。。。",@"commonLabel":@"湛江老乡",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"单纯de邂逅",@"description":@"1.84km 1小时",@"age":@(27),@"charmLevelTag":@"LV5",@"interest":@"喜欢张杰、TFBOYS、林俊杰、海鲜、吃素、吃辣、吃酸",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"m_﹏鐧箪",@"description":@"1.85km 24分钟",@"age":@(22),@"professionTag":@"学生",@"charmLevelTag":@"LV4",@"interest":@"去过广州、黄山、丽江、厦门、深圳；喜欢海鲜、马卡龙",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"🍉",@"description":@"1.90km 4小时",@"age":@(18),@"charmLevelTag":@"LV4",@"interest":@"喜欢澳门风云3、九层妖塔、澳门风云2；去过北京、成都、广州、桂林",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"多像陌生人。",@"description":@"2.61km 40分钟",@"age":@(20),@"charmLevelTag":@"LV5",@"interest":@"喜欢火锅、麻辣烫、吃酸、吃辣、羽毛球、既然青春留不住；去过广州",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"点个赞吧    ok",@"description":@"3.04km 8小时",@"age":@(18),@"charmLevelTag":@"LV6",@"richStateText":@"点个赞，也送个礼物。谢谢！👀",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"夜精灵",@"description":@"3.10km 8小时",@"age":@(28),@"charmLevelTag":@"LV5",@"richStateText":@"加入了NOW视频直播、NOW直播部落",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"暖暖",@"description":@"3.20km 7小时",@"age":@(24),@"professionTag":@"商业",@"charmLevelTag":@"LV5",@"interest":@"去过泰国、西安、深圳、丽江、大理；喜欢钓鱼、睡觉",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"紫罗兰",@"description":@"3.31km 4小时",@"age":@(28),@"charmLevelTag":@"LV5",@"richStateText":@"好朋友是金，永远灿烂，好朋友是路，越走越宽，好朋友是你，温馨甜蜜，天天快乐。",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"♬冰心♬",@"description":@"3.34km 3小时",@"age":@(27),@"charmLevelTag":@"LV5",@"richStateText":@"回到原位，做最好的自己！！！ 💪 💪",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"陈大傻  ❁",@"description":@"3.39km 9小时",@"age":@(22),@"charmLevelTag":@"LV5",@"interest":@"喜欢魔戒再现、指环王3：王者无敌、指环王1：护戒使者、指环王2：双塔奇兵；去过三亚、香港、九寨沟",@"sex":@(1),@"isVip":@(1)},
  @{@"nick":@"★最初☆",@"description":@"3.46km 15小时",@"age":@(20),@"charmLevelTag":@"LV6",@"richStateText":@"时光境迁，有些人，有些事，早已物是人非",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"愿时光温柔以待",@"description":@"3.51km 2小时",@"age":@(26),@"professionTag":@"艺术",@"charmLevelTag":@"LV4",@"richStateText":@"许我一个杀阡陌如何，因为他宁负天下人不负我",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"Waxxxnizrc",@"description":@"3.63km 5小时",@"age":@(18),@"professionTag":@"文化",@"charmLevelTag":@"LV5",@"interest":@"去过北京、澳门、香港、南京、深圳；喜欢韩红、姚贝娜",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"千雪",@"description":@"3.67km 4小时",@"age":@(24),@"charmLevelTag":@"LV5",@"interest":@"喜欢那英",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"区欠--阝日",@"description":@"3.85km 4小时",@"age":@(22),@"professionTag":@"商业",@"charmLevelTag":@"LV5",@"richStateText":@"我相信 总会有不期而遇的温暖 和生生不息的希望 在不经意间出现在我的生命里",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"剪",@"description":@"4.34km 59分钟",@"age":@(18),@"charmLevelTag":@"LV5",@"richStateText":@"",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"白洋座",@"description":@"4.59km 41分钟",@"age":@(27),@"charmLevelTag":@"LV4",@"richStateText":@"这天气冷的，整个人跟开了震动模式是的。",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"@😑",@"description":@"4.67km 38分钟",@"age":@(21),@"professionTag":@"商业",@"charmLevelTag":@"LV5",@"richStateText":@"一生钟爱的人，可以当药💊",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"Waxxxnizrc",@"description":@"3.63km 5小时",@"age":@(18),@"professionTag":@"文化",@"charmLevelTag":@"LV5",@"interest":@"喜欢韩红、姚贝娜；去过北京、澳门、香港、南京、深圳",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"千雪",@"description":@"3.67km 4小时",@"age":@(24),@"charmLevelTag":@"LV5",@"interest":@"喜欢那英",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"区欠--阝日",@"description":@"3.85km 4小时",@"age":@(22),@"professionTag":@"商业",@"charmLevelTag":@"LV5",@"richStateText":@"我相信 总会有不期而遇的温暖 和生生不息的希望 在不经意间出现在我的生命里",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"剪",@"description":@"4.34km 59分钟",@"age":@(18),@"charmLevelTag":@"LV5",@"richStateText":@"",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"白洋座",@"description":@"4.59km 41分钟",@"age":@(27),@"charmLevelTag":@"LV4",@"richStateText":@"这天气冷的，整个人跟开了震动模式是的。",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"@😑",@"description":@"4.67km 38分钟",@"age":@(21),@"professionTag":@"商业",@"charmLevelTag":@"LV5",@"richStateText":@"一生钟爱的人，可以当药💊",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"时光与爱永不老去",@"description":@"3.46km 7小时",@"age":@(20),@"charmLevelTag":@"LV4",@"richStateText":@"满满的正能量！",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"打完老板赶紧跑",@"description":@"3.64km 4小时",@"age":@(21),@"charmLevelTag":@"LV5",@"richStateText":@"不虧待每一份熱情，也不討好任何的冷漠",@"commonLabel":@"湛江老乡",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"小人物大脾气",@"description":@"4.07km 4小时",@"age":@(22),@"charmLevelTag":@"LV6",@"interest":@"去过成都、温州、长沙、重庆、深圳；喜欢辣条、火锅",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"H",@"description":@"4.64km 4小时",@"age":@(19),@"charmLevelTag":@"LV7",@"richStateText":@"上传了新的照片",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"Angle爱吃肉⊙",@"description":@"4.74km 7小时",@"age":@(19),@"charmLevelTag":@"LV4",@"richStateText":@"十连互赞 每天必回😏\"Remember my good, or remember me.\"",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"吉^o^吉",@"description":@"5.05km 6小时",@"age":@(28),@"charmLevelTag":@"LV6",@"interest":@"喜欢沙拉、韩国烤肉；去过西安、深圳、上海、南京、广州",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"伴我久久🎀",@"description":@"5.12km 5小时",@"age":@(22),@"professionTag":@"艺术",@"charmLevelTag":@"LV4",@"richStateText":@"  不闲聊，小孩绕道。",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"转身依旧是你",@"description":@"5.97km 6小时",@"age":@(23),@"professionTag":@"商业",@"charmLevelTag":@"LV5",@"interest":@"喜欢咖喱、泰国菜、沙拉；去过桂林、上海、丽江、泰国",@"commonLabel":@"湛江老乡",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"MS 吴",@"description":@"6.21km 2小时",@"age":@(25),@"charmLevelTag":@"LV3",@"interest":@"去过澳门、成都、大理、东莞、广州；喜欢卡丁车、搏击",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"游走→_→时光",@"description":@"6.25km 7小时",@"age":@(26),@"charmLevelTag":@"LV5",@"richStateText":@"求赞！⬜",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"゜Rhythm",@"description":@"6.30km 4小时",@"age":@(21),@"charmLevelTag":@"LV6",@"richStateText":@"   ",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"互不 ☞打扰❀",@"description":@"6.51km 3小时",@"age":@(18),@"charmLevelTag":@"LV4",@"interest":@"喜欢陈奕迅、G.E.M.邓紫棋、王力宏、我的青春期、既然青春留不住、爸爸的假期、钟馗伏魔：雪妖魔灵",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"︶ㄣ无情",@"description":@"6.60km 4小时",@"age":@(25),@"charmLevelTag":@"LV5",@"interest":@"喜欢火锅、红酒、烧烤、薯条、牛排、骑行、健身",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"ᙏ̤̫妮妮",@"description":@"6.61km 4小时",@"age":@(27),@"charmLevelTag":@"LV4",@"richStateText":@"谢谢给我送🌹的你，感动中，么么哒😚",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"红玫瑰",@"description":@"6.69km 2小时",@"age":@(26),@"charmLevelTag":@"LV4",@"richStateText":@"一天就這樣過了",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"℡Ｌ M T諪",@"description":@"6.71km 43分钟",@"age":@(28),@"charmLevelTag":@"LV6",@"richStateText":@"心得不到归宿！到哪都是孤独。",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"🌺",@"description":@"6.74km 5小时",@"age":@(19),@"charmLevelTag":@"LV6",@"richStateText":@"花花说话🌺🌺",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"Ξ敛起ヾ笑意Ξ",@"description":@"6.78km 7小时",@"age":@(27),@"charmLevelTag":@"LV4",@"richStateText":@"你若安好，那还得了…",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"x&…",@"description":@"6.95km 6小时",@"age":@(27),@"charmLevelTag":@"LV4",@"richStateText":@"再坚持几天放假了，好开心",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@".",@"description":@"7.39km 55分钟",@"age":@(19),@"charmLevelTag":@"LV6",@"richStateText":@"",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"红玫瑰",@"description":@"6.69km 2小时",@"age":@(26),@"charmLevelTag":@"LV4",@"richStateText":@"一天就這樣過了",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"℡Ｌ M T諪",@"description":@"6.71km 43分钟",@"age":@(28),@"charmLevelTag":@"LV6",@"richStateText":@"心得不到归宿！到哪都是孤独。",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"🌺",@"description":@"6.74km 5小时",@"age":@(19),@"charmLevelTag":@"LV6",@"richStateText":@"花花说话🌺🌺",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"Ξ敛起ヾ笑意Ξ",@"description":@"6.78km 7小时",@"age":@(27),@"charmLevelTag":@"LV4",@"richStateText":@"你若安好，那还得了…",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"x&…",@"description":@"6.95km 6小时",@"age":@(27),@"charmLevelTag":@"LV4",@"richStateText":@"再坚持几天放假了，好开心",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@".",@"description":@"7.39km 55分钟",@"age":@(19),@"charmLevelTag":@"LV6",@"richStateText":@"",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"ご餹餹蔀絡咯/╱°",@"description":@"4.05km 7小时",@"age":@(20),@"charmLevelTag":@"LV5",@"richStateText":@"互赞咯。",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"西柚",@"description":@"4.11km 4小时",@"age":@(21),@"professionTag":@"学生",@"charmLevelTag":@"LV6",@"richStateText":@"心里有你的人，总会主动找你，心里没你的人，总会自动忽略你。",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"后知、后觉",@"description":@"4.41km 17分钟",@"age":@(21),@"charmLevelTag":@"LV5",@"richStateText":@"忘记过去，从新开始",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"浪℡",@"description":@"4.49km 4小时",@"age":@(18),@"charmLevelTag":@"LV6",@"richStateText":@"               互赞十个把",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"做個沒心沒肺菂尐女亽",@"description":@"4.63km 6小时",@"age":@(20),@"charmLevelTag":@"LV6",@"richStateText":@"从前不回头，往后不将就。",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"「菇凉淡了人生又何妨」",@"description":@"4.76km 4小时",@"age":@(20),@"professionTag":@"商业",@"charmLevelTag":@"LV6",@"richStateText":@" 当我离开你以后才发现自己爱笑的眼睛已是冷泪盈眶",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"猫猫宁",@"description":@"4.83km 33分钟",@"age":@(23),@"charmLevelTag":@"LV4",@"richStateText":@"活着要开心",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"好好过",@"description":@"4.85km 3小时",@"age":@(19),@"charmLevelTag":@"LV5",@"interest":@"喜欢骑行、游泳、篮球、羽毛球、户外、西游记之大圣归来、小王子",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"♚ 笑柄",@"description":@"4.86km 1小时",@"age":@(19),@"charmLevelTag":@"LV5",@"interest":@"去过深圳、成都；喜欢匆匆那年、左耳、奔跑吧！兄弟、栀子花开",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"゜梦醒不如初ゞ",@"description":@"4.96km 3小时",@"age":@(20),@"charmLevelTag":@"LV4",@"richStateText":@"所谓服软，只不过是变相的宠爱。",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"沐戀",@"description":@"5.00km 2小时",@"age":@(18),@"professionTag":@"商业",@"charmLevelTag":@"LV6",@"richStateText":@"互赞。。。。。",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"小果儿い",@"description":@"5.01km 3小时",@"age":@(19),@"professionTag":@"IT",@"charmLevelTag":@"LV6",@"richStateText":@"Just a very simple, very small dream.",@"sex":@(1),@"isVip":@(1)},
  @{@"nick":@"烟雨霓裳",@"description":@"5.05km 1小时",@"age":@(21),@"professionTag":@"学生",@"charmLevelTag":@"LV4",@"richStateText":@"有会画画的吗",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"有点儿意思  。",@"description":@"5.14km 3小时",@"age":@(21),@"charmLevelTag":@"LV5",@"interest":@"喜欢九层妖塔、从天儿降、鬼吹灯之寻龙诀、盗墓笔记、捉妖记、QQ炫舞",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"呆到深处自然萌",@"description":@"5.17km 1小时",@"age":@(26),@"professionTag":@"IT",@"charmLevelTag":@"LV6",@"interest":@"喜欢陈奕迅、李健；去过台湾、成都、北京、南京、武汉",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"他不爱你，你就走啊。",@"description":@"5.17km 6小时",@"age":@(21),@"charmLevelTag":@"LV4",@"richStateText":@"互赞  10连赞可好？",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"又过了一天",@"description":@"5.23km 1小时",@"age":@(23),@"charmLevelTag":@"LV5",@"richStateText":@"互赞",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"〆手插口袋つ谁都不爱",@"description":@"5.25km 7小时",@"age":@(28),@"charmLevelTag":@"LV4",@"interest":@"喜欢吃辣、睡觉、户外、战狼；去过东莞、杭州、深圳",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"你若安好，便是晴天！",@"description":@"5.36km 39分钟",@"age":@(22),@"professionTag":@"IT",@"charmLevelTag":@"LV5",@"richStateText":@"海雅缤纷城四楼健身卡转让，2017年十一月底到期，三千六开的卡现在两千七转有意者欢迎咨询",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"琬安ヽ",@"description":@"5.41km 3小时",@"age":@(21),@"charmLevelTag":@"LV3",@"richStateText":@" 所有的相遇都是久别重逢。",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"陈任香",@"description":@"5.44km 3小时",@"age":@(21),@"charmLevelTag":@"LV5",@"richStateText":@"我愿你是个谎！从未出现我身旁！笑是神的伪装！笑是强忍的伤！Bay",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"妩媚",@"description":@"5.46km 2小时",@"age":@(24),@"charmLevelTag":@"LV6",@"interest":@"喜欢韩国烤肉、沙拉、红酒、海鲜、榴莲",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"Οo 卜珂ㄚi世ㄚoひ",@"description":@"5.59km 2小时",@"age":@(19),@"charmLevelTag":@"LV5",@"richStateText":@"",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"姒湜洏悱",@"description":@"5.85km 6分钟",@"age":@(26),@"professionTag":@"商业",@"charmLevelTag":@"LV3",@"interest":@"去过拉萨、杭州、香港；喜欢Belle、Puma、李荣浩、张学友",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"重新开始",@"description":@"6.02km 6小时",@"age":@(20),@"charmLevelTag":@"LV4",@"richStateText":@"",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"小♥瑜♥儿",@"description":@"6.08km 6小时",@"age":@(20),@"charmLevelTag":@"LV6",@"richStateText":@"赞赞赞赞赞",@"commonLabel":@"湛江老乡",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"左耳钉的璀璨折射出寂寞i",@"description":@"6.17km 7小时",@"age":@(19),@"charmLevelTag":@"LV5",@"richStateText":@"        随欲而安的缈茫，虚空的一如既往。。",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"加我微信554144850",@"description":@"6.28km 1小时",@"age":@(31),@"professionTag":@"商业",@"charmLevelTag":@"LV5",@"richStateText":@"央视风云主持阳光：推荐卡祖玛咖想健康从每天两粒玛咖开始",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"情暖一生",@"description":@"6.43km 2小时",@"age":@(27),@"charmLevelTag":@"LV4",@"richStateText":@"",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"舞者之魂",@"description":@"6.51km 28分钟",@"age":@(26),@"charmLevelTag":@"LV5",@"richStateText":@"如果上天可以让她的生命重来一次那么伤害她的人绝对没有好下场",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"不②心不②情",@"description":@"6.52km 19分钟",@"age":@(28),@"charmLevelTag":@"LV4",@"richStateText":@"幸福就是一家人快快乐乐，简简单单…^_^",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"没",@"description":@"6.76km 3小时",@"age":@(29),@"charmLevelTag":@"LV4",@"richStateText":@"加入了赵丽颖、小米部落",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"提拉米苏、",@"description":@"6.93km 5小时",@"age":@(21),@"charmLevelTag":@"LV6",@"richStateText":@"往前走，每一步都会很精彩~",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"Me  J😘",@"description":@"7.18km 2小时",@"age":@(24),@"charmLevelTag":@"LV6",@"interest":@"喜欢王力宏、张学友、左耳、榴莲、沙拉、咖喱；去过深圳",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"情到深处怎能不孤独",@"description":@"7.62km 3小时",@"age":@(21),@"professionTag":@"制造",@"charmLevelTag":@"LV6",@"richStateText":@"心塞 【真心离伤心最近！】",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"罗丑丑💋",@"description":@"7.76km 4小时",@"age":@(22),@"charmLevelTag":@"LV6",@"richStateText":@"照片照片照样骗！照片和本人差别很大！照片都是P出来的，有心脏病的人请勿观看🙅🙅",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"说好的幸福呢",@"description":@"7.86km 7小时",@"age":@(29),@"professionTag":@"商业",@"charmLevelTag":@"LV5",@"richStateText":@"珍惜现在拥有的一切！",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"Me  J😘",@"description":@"7.18km 2小时",@"age":@(24),@"charmLevelTag":@"LV6",@"interest":@"去过深圳；喜欢王力宏、张学友、左耳、榴莲、沙拉、咖喱",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"情到深处怎能不孤独",@"description":@"7.62km 3小时",@"age":@(21),@"professionTag":@"制造",@"charmLevelTag":@"LV6",@"richStateText":@"心塞 【真心离伤心最近！】",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"罗丑丑💋",@"description":@"7.76km 4小时",@"age":@(22),@"charmLevelTag":@"LV6",@"richStateText":@"照片照片照样骗！照片和本人差别很大！照片都是P出来的，有心脏病的人请勿观看🙅🙅",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"小幸运",@"description":@"8.30km 1小时",@"age":@(28),@"charmLevelTag":@"LV6",@"richStateText":@"",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"微笑",@"description":@"3.46km 15小时",@"age":@(24),@"charmLevelTag":@"LV5",@"interest":@"喜欢海鲜、吃甜、吃肉、火锅；去过广州、深圳、汕尾",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"。",@"description":@"3.47km 1小时",@"age":@(19),@"charmLevelTag":@"LV4",@"richStateText":@"岁月静好",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"久伴我i",@"description":@"3.50km 28分钟",@"age":@(18),@"charmLevelTag":@"LV5",@"interest":@"喜欢我的少女时代、薛之谦",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"久居深心i",@"description":@"3.61km 1小时",@"age":@(18),@"charmLevelTag":@"LV4",@"richStateText":@"  你退半步的动作认真的吗。  ",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"小老婆婆。",@"description":@"3.67km 7小时",@"age":@(23),@"charmLevelTag":@"LV5",@"richStateText":@"这种人好恶心、、、",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"走在大马路上的古董",@"description":@"3.71km 2小时",@"age":@(25),@"charmLevelTag":@"LV4",@"interest":@"喜欢九层妖塔、从天儿降；去过上海、深圳、北京、杭州、丽水",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"、  0",@"description":@"4.06km 1小时",@"age":@(20),@"charmLevelTag":@"LV6",@"richStateText":@"加入了张艺兴、恋爱吧部落",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"宝贝活出自己世界",@"description":@"4.12km 3小时",@"age":@(31),@"professionTag":@"商业",@"charmLevelTag":@"LV6",@"richStateText":@"梦死随生，远去东来。回首再回首",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"安好，旧时光里的女子",@"description":@"4.27km 3小时",@"age":@(24),@"professionTag":@"商业",@"charmLevelTag":@"LV5",@"interest":@"喜欢幻影车神：魔盗激情、功夫小蝇、匆匆那年、左耳、吃甜、吃酸、健身",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"Melody💋",@"description":@"4.41km 5小时",@"age":@(26),@"professionTag":@"商业",@"charmLevelTag":@"LV3",@"richStateText":@"你好你好",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"呱呱",@"description":@"4.42km 9小时",@"age":@(28),@"professionTag":@"商业",@"charmLevelTag":@"LV5",@"interest":@"去过东莞、广州、深圳；喜欢欢乐麻将、天天爱消除、欢乐斗牛、欢乐斗地主",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"宿海°",@"description":@"4.46km 6小时",@"age":@(25),@"charmLevelTag":@"LV5",@"interest":@"喜欢吃酸、吃甜、麻辣烫；去过成都、大理、丽江、深圳",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"入戏太深。i",@"description":@"4.52km 3小时",@"age":@(21),@"charmLevelTag":@"LV4",@"richStateText":@"脱发，秃头，油发，白发，少发的头皮屑，头皮痒的情况，都可以找我",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"小仙女",@"description":@"4.55km 1小时",@"age":@(18),@"charmLevelTag":@"LV6",@"richStateText":@"你做得对的时候没人会记得，你做错的时候连呼吸都是错的",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"-肥猫",@"description":@"4.75km 9小时",@"age":@(19),@"professionTag":@"学生",@"charmLevelTag":@"LV5",@"interest":@"喜欢ZARA、安踏、MUJI、M.A.C、H&M、我的少女时代、超能陆战队",@"sex":@(1),@"isVip":@(1)},
  @{@"nick":@"Tender",@"description":@"4.84km 3小时",@"age":@(23),@"professionTag":@"行政",@"charmLevelTag":@"LV7",@"interest":@"去过香港、台湾、厦门、九寨沟、三亚；喜欢欢乐斗地主、节奏大师",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"分岔路口ジ",@"description":@"4.89km 55分钟",@"age":@(18),@"charmLevelTag":@"LV6",@"interest":@"去过深圳、东莞、广州；喜欢天天酷跑、欢乐斗地主、节奏大师、澳门风云3",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"丑八怪。",@"description":@"5.02km 2小时",@"age":@(18),@"charmLevelTag":@"LV5",@"richStateText":@"   点赞哟。",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"晓峰残月",@"description":@"5.87km 15小时",@"age":@(21),@"professionTag":@"制造",@"charmLevelTag":@"LV4",@"richStateText":@"求十连赞，苛💜悦 刊💜箜💛间么么哒💜",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"小仙女",@"description":@"4.55km 1小时",@"age":@(18),@"charmLevelTag":@"LV6",@"richStateText":@"你做得对的时候没人会记得，你做错的时候连呼吸都是错的",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"-肥猫",@"description":@"4.75km 9小时",@"age":@(19),@"professionTag":@"学生",@"charmLevelTag":@"LV5",@"interest":@"喜欢ZARA、安踏、MUJI、M.A.C、H&M、我的少女时代、超能陆战队",@"sex":@(1),@"isVip":@(1)},
  @{@"nick":@"Tender",@"description":@"4.84km 3小时",@"age":@(23),@"professionTag":@"行政",@"charmLevelTag":@"LV7",@"interest":@"喜欢欢乐斗地主、节奏大师；去过香港、台湾、厦门、九寨沟、三亚",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"分岔路口ジ",@"description":@"4.89km 55分钟",@"age":@(18),@"charmLevelTag":@"LV6",@"interest":@"去过深圳、东莞、广州；喜欢天天酷跑、欢乐斗地主、节奏大师、澳门风云3",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"丑八怪。",@"description":@"5.02km 2小时",@"age":@(18),@"charmLevelTag":@"LV5",@"richStateText":@"   点赞哟。",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"晓峰残月",@"description":@"5.87km 15小时",@"age":@(21),@"professionTag":@"制造",@"charmLevelTag":@"LV4",@"richStateText":@"求十连赞，苛💜悦 刊💜箜💛间么么哒💜",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"怎样。",@"description":@"6.03km 1小时",@"age":@(19),@"charmLevelTag":@"LV6",@"richStateText":@"     假如不能公开忌妒，选择大方接受。",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"^ω^",@"description":@"7.29km 3小时",@"age":@(24),@"charmLevelTag":@"LV4",@"richStateText":@"",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"你是不是傻！",@"description":@"7.32km 4小时",@"age":@(18),@"professionTag":@"商业",@"charmLevelTag":@"LV5",@"richStateText":@"陌生人你好",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"紫",@"description":@"7.49km 3小时",@"age":@(23),@"charmLevelTag":@"LV5",@"richStateText":@"",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"南 橘",@"description":@"7.49km 6小时",@"age":@(19),@"professionTag":@"商业",@"charmLevelTag":@"LV5",@"richStateText":@"      从此深情都喂风🚶",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"℡ 不美不萌又怎样、",@"description":@"7.53km 3小时",@"age":@(26),@"charmLevelTag":@"LV5",@"interest":@"喜欢提拉米苏、榴莲、吃辣、烧烤、安踏、怦然星动、左耳",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"執子之手¥打死喂狗",@"description":@"7.56km 2小时",@"age":@(20),@"professionTag":@"艺术",@"charmLevelTag":@"LV5",@"richStateText":@"咱们来互赞吧，你赞我几个我回几个⏰",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"愿得一人xin）",@"description":@"7.61km 33分钟",@"age":@(21),@"charmLevelTag":@"LV5",@"richStateText":@"爱太难 我太笨 总是学不会",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"她很漂亮",@"description":@"7.82km 32分钟",@"age":@(19),@"charmLevelTag":@"LV5",@"richStateText":@"👍👍👍👍👍👍👍",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"﹏ 笑辣辣",@"description":@"7.95km 5小时",@"age":@(18),@"professionTag":@"学生",@"charmLevelTag":@"LV6",@"richStateText":@"☞跟我走  丢三丢四也不丢你。",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"☞世界宠儿☜",@"description":@"8.00km 7小时",@"age":@(18),@"professionTag":@"商业",@"charmLevelTag":@"LV3",@"richStateText":@"无语 ，，，，，，，",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"念旧。",@"description":@"8.10km 6分钟",@"age":@(20),@"charmLevelTag":@"LV5",@"richStateText":@"互赞，十赞十回。",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"安静的/xin浪漫",@"description":@"8.10km 3小时",@"age":@(24),@"professionTag":@"金融",@"charmLevelTag":@"LV3",@"richStateText":@"心态很重要！",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"ABm.娇妞",@"description":@"8.15km 4小时",@"age":@(21),@"charmLevelTag":@"LV5",@"richStateText":@"上传了新的照片",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"╰戀上倪鍀☆唇╯",@"description":@"8.30km 3小时",@"age":@(26),@"charmLevelTag":@"LV6",@"richStateText":@"互赞十赞十回♥拒私聊勿扰……每天赞已用完，如有漏赞，见谅！",@"commonLabel":@"湛江老乡",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"谎言。",@"description":@"8.31km 14分钟",@"age":@(22),@"professionTag":@"制造",@"charmLevelTag":@"LV5",@"interest":@"喜欢奔跑吧！兄弟、前任2:备胎反击战、老炮儿、万万没想到、新娘大作战、火锅、薯条",@"sex":@(1),@"isVip":@(1)},
  @{@"nick":@"蝶恋花",@"description":@"8.35km 1小时",@"age":@(24),@"charmLevelTag":@"LV5",@"richStateText":@"那些被允许任性的年代，叫做青春！",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"从你的世界路过@",@"description":@"8.38km 5小时",@"age":@(21),@"charmLevelTag":@"LV5",@"richStateText":@"无论红包多少，一块钱都是爱",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"晴空万里*",@"description":@"8.45km 4小时",@"age":@(24),@"charmLevelTag":@"LV4",@"richStateText":@"我本风雅，何惧旁人言我浮华！",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"伊&恋※雪",@"description":@"8.57km 39分钟",@"age":@(28),@"professionTag":@"制造",@"charmLevelTag":@"LV6",@"richStateText":@"爱我🌹🌹🌹所爱，，，，",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@".",@"description":@"8.76km 3小时",@"age":@(18),@"charmLevelTag":@"LV5",@"richStateText":@"我开心就好",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"前凸后翘臣妾做不到",@"description":@"8.88km 7小时",@"age":@(28),@"charmLevelTag":@"LV4",@"richStateText":@"加入了股市部落",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"傻妞",@"description":@"8.92km 2小时",@"age":@(25),@"charmLevelTag":@"LV5",@"richStateText":@"帅哥，美女，缵缵呗，送送花呗，😊",@"sex":@(1),@"isVip":@(0)},
  @{@"nick":@"Wrysmile",@"description":@"8.92km 5小时",@"age":@(22),@"charmLevelTag":@"LV5",@"richStateText":@"除了万分努力让自己光芒万丈，我们没有多余的选择。",@"sex":@(1),@"isVip":@(0)}, nil];
    
    NSInteger avatarLen = 25;
    NSUInteger sourceLen = [data count];
    _tableDataSource = [NSMutableArray new];
    int i = 0;
    for (; i < sourceLen; i++) {
        NSDictionary * item = [data objectAtIndex: i];
        UserInfoModel * model = [[UserInfoModel alloc] init];
        model.avatarUrl = [NSString stringWithFormat:@"%ld.jpeg", (long)(140+(i%avatarLen))];
        model.nick = [item objectForKey:@"nick"];
        model.distance = [item objectForKey:@"description"];
        model.sex = [[item objectForKey:@"sex"] intValue];
        model.age = [[item objectForKey:@"age"] intValue];
        model.charmLevelTag = [item objectForKey:@"charmLevelTag"];
        model.professionTag = [item objectForKey:@"professionTag"];
        model.interest = [item objectForKey:@"interest"];
        model.richStateText = [item objectForKey:@"richStateText"];
        model.commonLabel = [item objectForKey:@"commonLabel"];
        model.isVip = [[item objectForKey:@"isVip"] intValue];
        [_tableDataSource addObject:model];
    }
    [_tableView reloadData];
    _currentIndex = 9;
//    [self performSelector:@selector(autoRunTabelView) withObject:nil afterDelay:10.0];
}
- (void) autoRunTabelView
{
    if ( (_currentIndex += 10) >= [_tableDataSource count] ) {
        return;
    }
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    [self performSelector:@selector(autoRunTabelView) withObject:nil afterDelay:5.0];
}

#pragma mark  Delegate And DataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 86;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableDataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NearByALEngineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ALEngine"];
    if (cell == nil)
    {
        cell = [[NearByALEngineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ALEngine"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell setModel:[_tableDataSource objectAtIndex:indexPath.row]];
    return cell;
}

@end
