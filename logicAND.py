w_1 = [[0, -0.999], [-0.999, -0.999], [-0.999, -0.999], [-0.999, -0.999]]
w_2 = [-1, -1, -1, -1]

l_1 = -0.999
l_2 = -1

x = [[0, 1]]

first_layer = []

for data in x:
    temp_list = []
    for i in w_1:
        temp = 0.0
        for j in range(len(i)):
            temp += data[j] * i[j]
        if temp < l_1:
            temp_list.append(0)
        else:
            temp_list.append(1)
    first_layer.append(temp_list)

outputs = []

for data in first_layer:
    temp = 0.0
    for i in range(len(data)):
        temp += data[i] * w_2[i]
    if temp < l_2:
        outputs.append(0)
    else:
        outputs.append(1)
print(outputs)
