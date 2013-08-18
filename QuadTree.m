//
//  QuadTree.m
//  QuadTreeExample
//
//  Created by Erik Olsson on 8/18/13.
//

#import "QuadTree.h"

#define MAX_POINTS_PER_NODE 4

@interface QuadTree ()
@property(nonatomic, strong) QuadTree *northWest;
@property(nonatomic, strong) QuadTree *northEast;
@property(nonatomic, strong) QuadTree *southWest;
@property(nonatomic, strong) QuadTree *southEast;
@property(nonatomic, strong) NSMutableArray *points;
@end

@implementation QuadTree

-(id)init {
  self = [super init];
  if(self)
    self.points = [[NSMutableArray alloc] initWithCapacity:MAX_POINTS_PER_NODE];

  return self;
}

-(void)subdivide {
  self.northWest = [[QuadTree alloc] init];
  self.northEast = [[QuadTree alloc] init];
  self.southWest = [[QuadTree alloc] init];
  self.southEast = [[QuadTree alloc] init];

  float width = _region.size.width * 0.5f;
  float x = _region.origin.x;
  float y = _region.origin.y;

  self.northWest.region = CGRectMake(x, y, width, width);
  self.northEast.region = CGRectMake(x + width, y, width, width);
  self.southWest.region = CGRectMake(x, y + width, width, width);
  self.southEast.region = CGRectMake(x + width, y + width, width, width);
}

-(BOOL)insert:(DataPoint *)dp {
  if(!CGRectContainsPoint(_region, dp.point))
    return false;

  if(_points.count < MAX_POINTS_PER_NODE) {
    [_points addObject:dp];
    return true;
  }

  if(_northEast == nil)
    [self subdivide];

  if([_northEast insert:dp]) return true;
  if([_northWest insert:dp]) return true;
  if([_southEast insert:dp]) return true;
  if([_southWest insert:dp]) return true;

  return false;
}

-(NSArray*)pointsInRect:(CGRect)rect {
  if(!CGRectIntersectsRect(rect, _region))
    return nil;

  NSMutableArray *array = [NSMutableArray array];
  for (DataPoint *dp in _points) {
    if(CGRectContainsPoint(rect, dp.point))
      [array addObject:dp];
  }

  if(_northEast == nil)
    return array;

  [array addObjectsFromArray:[_northEast pointsInRect:rect]];
  [array addObjectsFromArray:[_northWest pointsInRect:rect]];
  [array addObjectsFromArray:[_southEast pointsInRect:rect]];
  [array addObjectsFromArray:[_southWest pointsInRect:rect]];

  return array;
}

@end
