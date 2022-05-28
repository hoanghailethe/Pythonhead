class Solution:
#     Runtime: 67 ms, faster than 41.71% of Python3 online submissions for Distance Between Bus Stops.
# Memory Usage: 15 MB, less than 45.58% of Python3 online submissions for Distance Between Bus Stops
    def distanceBetweenBusStops(self, distance: List[int], start: int, destination: int) -> int:
        total = sum(distance)
        isInOrder = start <= destination

        smallestDis = 0

        for id, des in enumerate(distance):
            if isInOrder:
                # print(id)
                if start <= id < destination:
                    # print('# ' +str(id))
                    smallestDis += distance[id]
            else: 
                if destination <= id < start:
                    smallestDis += distance[id]
        smallestDis = min(smallestDis,total - smallestDis )
        return smallestDis