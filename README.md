QuadTree
========

QuadTree implementation in Objective-C.

### Example usage
```objectivec
  // Init the tree
  QuadTree *quadTree = [[QuadTree alloc] init];
  quadTree.region = CGRectMake(-180, -180, 360, 360);
  
  // Add some random points on a world map
  for (int i = 0; i < 1000000; i++) {
  	DataPoint *dp = [[DataPoint alloc] init];
	  dp.point = CGPointMake(drand48() * 180.0f - 90.0f, drand48() * 360.0f - 180.0f);
	  [quadTree insert:dp];
  }
  
  // Query the tree for all points within rect
  CGRect rect = CGRectMake(40.74, -73.99, 1, 10);
  NSArray *points = [_quadTree pointsInRect:range];
```

