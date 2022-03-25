class Solution:
#     Runtime: 60 ms, faster than 49.03% of Python3 online submissions for Two City Scheduling.
# Memory Usage: 13.8 MB, less than 98.73% of Python3 online submissions for Two City Scheduling
    def twoCitySchedCost(self, costs: List[List[int]]) -> int:
        costIfAllFlyToA = 0 
        for costsToAllCities in costs:
            costIfAllFlyToA += costsToAllCities[0]

        costIfChangeToB = []
        map = {}
        for index, costsToCities in enumerate(costs):
            costIfChangeCity = costIfAllFlyToA - costsToCities[0] + costsToCities[1]
            costIfChangeToB.append( costIfChangeCity )
            map[costIfChangeCity] = index

        costIfChangeToB.sort()
        minCost = 0
        indexOfMins = []
        for i in range(0, int(len(costs)/2)) :
            indexOfMins.append( map[costIfChangeToB[i]] )
        
        for index in indexOfMins:
            costIfAllFlyToA = costIfAllFlyToA - costs[index][0] + costs[index][1] 
        return costIfAllFlyToA