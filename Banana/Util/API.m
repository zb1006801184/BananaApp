//
//  API.m
//  Banana
//
//  Created by 朱标 on 2018/11/19.
//

#import "API.h"

@implementation API

@end
//bugly
NSString * const buglyappid = @"8a20aae718";

//百度云oss
NSString * const Bucket = @"loan-market-pics";
NSString * const endPoint = @"oss-cn-hangzhou.aliyuncs.com";
NSString * const imagesFace= @"images/face/";

//个推
NSString * const  kGtAppId = @"sPnERM9H7I9rsZJs4VvQD8";
NSString * const  kGtAppKey = @"GqkE9dihaX5ndWshF3fhw9";
NSString * const  kGtAppSecret = @"yOUgWv1xGr7gJHcwqTgQx1";

//友盟appkey
NSString * const  UmengAppkey = @"5bd94ebdb465f5a5d300004f";


//接口前面的域名
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
//意见反馈
NSString *const SYS_IDEA = @"sys/idea";
//更换绑定的手机号
NSString *const MEMBER_CHANGEBIND = @"member/changeBind";
//校验验证码的合理性
NSString *const SYS_VALIDATECHECKCODE = @"sys/validateCheckCode";
//修改用户信息
NSString *const MEMBER_CHANGEMSG = @"member/changeMsg";
//上传图片
NSString *const MEMBER_CHANGEHEADFILE =@"member/changeHeadFile";
//OSS 权限
NSString *const OSS_TOKEN = @"oss/getToken";
//详情
NSString *const PRODUCT_DETAIL= @"product/productDetail";












//广告页
NSString *const MEMEBER_startShow = @"indexShow/startShow";
//首页数据源
NSString *const MEMEBER_HOMEDATA = @"indexShow/indexShow";
//产品数据源
NSString *const MEMEBER_products = @"product/products";
