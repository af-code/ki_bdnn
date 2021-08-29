# 1 Hidden-Layer with 4 Neurons

x = [
[5.0, 3.5, 1.3, 0.3], 
[4.5, 2.3, 1.3, 0.3], 
[4.4, 3.2, 1.3, 0.2], 
[5.0, 3.5, 1.6, 0.6], 
[5.1, 3.8, 1.9, 0.4], 
[4.8, 3.0, 1.4, 0.3], 
[5.1, 3.8, 1.6, 0.2], 
[4.6, 3.2, 1.4, 0.2], 
[5.3, 3.7, 1.5, 0.2], 
[5.0, 3.3, 1.4, 0.2], 
[5.5, 2.6, 4.4, 1.2], 
[6.1, 3.0, 4.6, 1.4], 
[5.8, 2.6, 4.0, 1.2], 
[5.0, 2.3, 3.3, 1.0], 
[5.6, 2.7, 4.2, 1.3], 
[5.7, 3.0, 4.2, 1.2], 
[5.7, 2.9, 4.2, 1.3], 
[6.2, 2.9, 4.3, 1.3], 
[5.1, 2.5, 3.0, 1.1], 
[5.7, 2.8, 4.1, 1.3]]

y = [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1]

w_1 = [[-0.508771929824561, -1, 1, 1], [-1, -1, -1, -1], [-1, -1, -1, -1], [-1, -1, -1, -1]]
w_2 = [1, -1, -1, -1]

l_1 = -1
l_2 = 1

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

print(y)
print(outputs)