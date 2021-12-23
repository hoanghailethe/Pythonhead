class Solution:
    #not pass
    def findOrder(self, numCourses: int, prerequisites: List[List[int]]) -> List[int]:
        order_to_learn = []
        contradict_check = {}

        for course_order in prerequisites:
            first_course = course_order[1]
            sec_course = course_order[0]
            if first_course not in order_to_learn and sec_course not in order_to_learn:
                order_to_learn.append(first_course)
                order_to_learn.append(sec_course)

            elif first_course in order_to_learn and sec_course not in order_to_learn:
                order_to_learn.insert(order_to_learn.index(first_course)+1, sec_course)
            elif first_course not in order_to_learn and sec_course in order_to_learn:
                order_to_learn.insert(order_to_learn.index(sec_course), first_course )
            elif order_to_learn.index(first_course) > order_to_learn.index(sec_course): #both in but contradict
                if contradict_check.get(first_course) == sec_course:
                    return []
                else:
                    order_to_learn[order_to_learn.index(first_course)] , order_to_learn[order_to_learn.index(sec_course)] = order_to_learn[order_to_learn.index(sec_course)] , order_to_learn[order_to_learn.index(first_course)]
            contradict_check[sec_course] = first_course

        for n in range(numCourses):
            if n not in order_to_learn:
                order_to_learn.append(n)
        return order_to_learn