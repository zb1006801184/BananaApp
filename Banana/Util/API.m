//
//  API.m
//  Banana
//
//  Created by 朱标 on 2018/11/19.
//

#import "API.h"

@implementation API

@end
NSString *const API_NAME = @"https://apptest.xiangjiaoqianbao.cn/";
//登录
NSString *const MEMBER_LOGIN = @"member/login";
//注册
NSString *const MEMBER_REGISTER = @"member/register";
//发送验证码
NSString *const SYS_SENDNOTE = @"sys/sendNote";
//获取用户信息
NSString *const MEMBER_SELECTINFORMATION = @"member/selectInformation";
//登出
NSString *const MEMBER_LOGOUT = @"member/logout";
//忘记密码
NSString *const MEMEBER_CHANGEPWD = @"member/forgetPwd";
////修改密码
//NSString *const MEMEBER_CHANGEPWD = @"member/changePwd";
















//广告页
NSString *const MEMEBER_startShow = @"indexShow/startShow";
//首页数据源
NSString *const MEMEBER_HOMEDATA = @"indexShow/indexShow";
//产品数据源
NSString *const MEMEBER_products = @"product/products";
