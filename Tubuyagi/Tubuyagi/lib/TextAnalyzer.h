//
//  TextAnalyzer.h
//  Tubuyagi
//
//  Created by 宮原聡 on 2013/09/06.
//  Copyright (c) 2013年 Genki Ishibashi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface TextAnalyzer : NSObject
NSString* generateSentence(void);
void learnFromText(NSString* morphTargetText);
void deleteAllData(FMDatabase *db);
@end