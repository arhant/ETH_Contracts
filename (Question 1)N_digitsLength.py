import sys
n = int(sys.argv[1])

def find_numbers(start_num, n, rule):
    if n == 1:
        return [[start_num]]
    result = []
    rule = rule % 3
    try:
        for next_num in rules[rule][start_num]:
            sub_results = find_numbers(next_num, n-1, rule+1)
            for sub_result in sub_results:
                result.append([start_num] + sub_result)
    except:
        pass
    
        
    return result


tall_l = { 0: [4,6] , 1:[6,8], 2:[7,9], 3:[4,8], 4:[0,3,9], 6:[0,1,7], 7:[2,6], 8:[1,3], 9:[2,4]}
small_l = {0: [7,8] , 1:[5], 2:[4,6], 3:[5], 4:[2,8], 5:[1,3,7,9], 6:[2,8], 7:[0,5], 8:[4,6], 9:[0,5]}
rules = [tall_l, small_l, small_l]

length = len(find_numbers(0, n, 0))
print("length of %s digit numbers is : %s" % (str(n), str(length)))