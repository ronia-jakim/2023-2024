max = [
    [3, 1, 6, 1, 2, 2, 2, 3],
    [2, 1, 1, 4, 2, 3, 4, 1, 2],
    [4, 4, 1, 2, 3, 4, 2],
    [1, 4, 6, 3, 2, 3, 1]
    ]


my_points =[
    [3, 1, 6, 1, 2, 2, 2, 3],
    [2, 0, 1, 4, 0, 3, 4, 1, 0],
    [4, 0, 1, 2, 3, 4, 2],
    [0, 4, 6, 3, 0, 0, 0]
    ]

sum_max = []
MAX = 0

for lst in max:
    sum_max.append(sum(lst))
MAX = sum(sum_max)

sum_my = []
MY = 0

for lst in my_points:
    sum_my.append(sum(lst))
MY = sum(sum_my)

print(" Dostałam " + str(MY) + "/" + str(MAX) + " = " + str(MY/MAX) + "%")
print("========================")

i = 0
for lst in max:
    print(" Lista " + str((i + 1)) + " :: " + str(sum_my[i]) + "/" + str(sum_max[i]) + " = " + str(sum_my[i]/sum_max[i]))
    i += 1
