ilosc_list = 7
MAX = ilosc_list * 20

my_points = [17, 15, 16, 13, 0, 12, 11]
MY = sum(my_points)

print(" Dostałam " + str(MY) + "/" + str(MAX) + " = " + str(MY/MAX) + "%")
print("========================")

i = 0
for lst in my_points:
    print(" Lista " + str((i + 1)) + " :: " + str(my_points[i]) + "/20=" + str(my_points[i]/20))
    i += 1
