//
//  Tool_CalendarEvent.m
//  yeko
//
//  Created by admin on 2021/5/10.
//

#import "Tool_CalendarEvent.h"

@implementation Tool_CalendarEvent

//单例初始化，减少性能消耗
+ (instancetype)shareCalendarEventTool{
    
    static Tool_CalendarEvent *_calendarEventTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _calendarEventTool=[[Tool_CalendarEvent alloc]init];
    });
    
    return _calendarEventTool;
    
}

//查询指定时间段的事件
-(NSArray *)fetchEventsWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate{
    
    Tool_CalendarEvent *eventStore = [Tool_CalendarEvent shareCalendarEventTool];
    
    NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:startDate
                                                            endDate:endDate
                                                          calendars:nil];
    
    NSArray *events = [eventStore eventsMatchingPredicate:predicate];
    
    NSInteger i = 1;
    for (EKEvent *event in events) {
        NSLog(@"第 %ld 个提醒 %@",(long)i,event);
        i++;
    }
    return events;
    
}

//添加事件
-(void)addEventWithTitle:(NSString *)title notes:(NSString *)notes startDate:(NSDate *)startDate endDate:(NSDate *)endDate{
    
    Tool_CalendarEvent *eventStore = [Tool_CalendarEvent shareCalendarEventTool];
    
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]){
        
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error){
                    //错误细心
                    // display error message here
                }else if (!granted){
                    //被用户拒绝，不允许访问日历
                    // display access denied error message here
                }else{
                    //创建事件
                    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
                    event.title = title;
                    event.notes = notes;
                    event.calendar = eventStore.defaultCalendarForNewEvents;
//                    NSDate *date = [NSDate date];
                    //开始时间(必须传)
//                    event.startDate = [date dateByAddingTimeInterval:60 * 2];
                    event.startDate = startDate;
                    //结束时间(必须传)
//                    event.endDate   = [date dateByAddingTimeInterval:60 * 5 * 24];
                    event.endDate = endDate;
                    //添加提醒
                    //第一次提醒  (几分钟后)
                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -10.0f]];
                    
                    NSError *err;
                    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
                    
                    if (err) {
                        NSLog(@"保存失败");
                    }else{
                        NSLog(@"保存成功");
                    }
                    
                }
            });
        }];
    }
}

//删除事件
-(BOOL)deleteEvent:(EKEvent *)event{
    
    Tool_CalendarEvent *eventStore = [Tool_CalendarEvent shareCalendarEventTool];
    
    NSError *err = nil;
    BOOL isSuccess = [eventStore removeEvent:event span:EKSpanThisEvent commit:YES error:&err];
    
    if (isSuccess) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
    }
    
    return isSuccess;
}

@end
