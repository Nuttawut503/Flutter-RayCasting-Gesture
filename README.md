# 2D_RayCasting

A simple Flutter app. (But I think it's not even close to)

## What did I do?

- Ray casting is an algorithm to check whether a given point in the plane lies inside, outside, or on the boundary of a polygon.
- I used this algorithm with a simple 2D building map which has atleast one room in the map.
- If I let you touches somewhere in the map, then my app will use the position where you tapped to calculate whether the position is inside a room or it is outside a room. If you touch inside a room, my app will let you know the name of the room.
- To use this algorithm, it requires you to store positions of every rooms that are in the map by ractangular coordinates (I mean something like XY graph), for example, if a room is like a triangle, that means you need to provide 3 position of the room such as (X1, Y1), (X2, Y2), and (X3, Y3). (This depends on the number of the corner)
