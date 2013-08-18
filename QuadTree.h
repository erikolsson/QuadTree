//
//  QuadTree.h
//  QuadTreeExample
//
//  Created by Erik Olsson on 8/18/13.
//

#import <Foundation/Foundation.h>
#import "DataPoint.h"

@interface QuadTree : NSObject

@property(nonatomic, assign) CGRect region;
-(BOOL)insert:(DataPoint*)point;
-(NSArray*)pointsInRect:(CGRect)rect;

@end
