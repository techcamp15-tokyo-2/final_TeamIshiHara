//
//  BasicRequest.h
//  Tubuyagi
//
//  Created by 宮原聡 on 2013/09/09.
//  Copyright (c) 2013年 Team IshiHara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BasicRequest : NSObject

NSString *randStringWithLength(int length);
void addUser(void);
void addPost(NSString *content, void (^success)(NSArray *results));
void *getJSONRecents(int cursor, int num, void (^success)(NSArray *result));
void *getJSONTops(int cursor, int num, void (^success)(NSArray *result));
void *getJSONWara(void (^success)(NSArray *result));
void addWara(long long post_id);

//自分の投稿をお気に入りに追加＆つぶやきを共有
void addWaraToMyTubuyaki(NSString *content);
//自分のお気に入りに追加
bool addWaraToOthersTubuyaki(long long post_id, NSString *content,NSDate *date);
@end
