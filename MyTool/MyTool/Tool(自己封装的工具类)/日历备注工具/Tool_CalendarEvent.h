//
//  Tool_CalendarEvent.h
//  yeko
//
//  Created by admin on 2021/5/10.
//

#import <EventKit/EventKit.h>



@interface Tool_CalendarEvent : EKEventStore


//单例初始化，减少性能消耗
+ (instancetype)shareCalendarEventTool;

//查询指定时间段的事件
-(NSArray *)fetchEventsWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

//添加事件
-(void)addEventWithTitle:(NSString *)title notes:(NSString *)notes startDate:(NSDate *)startDate endDate:(NSDate *)endDate;

//删除事件
-(BOOL)deleteEvent:(EKEvent *)event;




@end


