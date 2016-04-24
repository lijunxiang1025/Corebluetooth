//
//  Constant.h
//  BlueToothProduct
//
//  Created by Tom on 14-8-15.
//  Copyright (c) 2014年 com.ppkj. All rights reserved.
//
#define KRequestTimeout		25.0

#define showRequest YES
#define kAlertTitle @"温馨提示"
#define kNetworkNoData	@"暂时没有您想要的数据"
#define kNOmessageData	@"暂时没有您的消息"
#define kNetworkError	@"网络故障，请检查网络连接"
#define kServerError	@"服务器暂时无法连接，请稍后再试"
#define reqTimeOutError	@"服务请求超时，请重试"
#define errorShowAlert YES



#define kQQAppID         @"222222"


#define AuthKey         @"blueSystem"

//@"http://10.0.1.52:8080/blueSystem/api/user/uploadHead.do"
//http://10.0.1.28:85/

//http://10.0.1.51:8080/
//http://114.215.127.70:8080/
//10.0.1.42/blueSystem/
#define  BlAPIDomain    @"http://114.215.127.70:9091/blueSystem/api"
#define  BlLogin        @"/user/login.do"
#define  BlUpLoadHead   @"/user/uploadHead.do"

//#define  BlFSDX         @"/user/setPassWord.do"

#define  BlRegister     @"/user/setPassWord.do"

#define  BlotherLoginUrl @"/user/login2.do" 
#define  Blupdate       @"/user/updateInfo.do"
#define  BlGeRen        @"/user/searchUserInfo.do"
#define  BlZhaoHui      @"/user/findPWD.do"
#define  BlAboutUs      @"/article/aboutUS.do"
#define  BlUpVersion    @"/version/updateversion.do"


#define  Blhistory      @"/history/saveHistory.do"


///查询历史数据
#define  Blhistorychaxun @"/history/searchHistory.do"
//#define  BlPostHead     @"http://10.0.1.51:8080/blueSystem/upload.jsp"

#define IOS7   [[UIDevice currentDevice]systemVersion].floatValue>=7.0




#define disConnectAlertMsg @"确定断开蓝牙！"
#define connectAlertMsg @"蓝牙正在连接"
#define isConnectBluetooth @"是否重连蓝牙"
#define  VIEWWIDTH  self.view.frame.size.width
#define  VIEWHEIGHT self.view.frame.size.height


/***************************************** 蓝牙系统字典 存值
 blueConnect 系统蓝牙是否连接
 phoneCall 电话来的时候
 fangdiu 防丢器
 QTYDMS  奇特物品的运动模式数据
 YDMS 奇特物品的运动模式
 
 QTWPGoal 设定运动目标
 
 
 
 
 
 //闹钟设置的时候
 ClockZD 震动
 ClockLS 铃声
 ClockSG 闪光
 notClock 闹钟时间
 NZKG   闹钟开关
 
 
 
 *******************************************************/


