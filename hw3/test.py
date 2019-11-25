
import math
l= [(3,6),(4,6),(2,5),(3,5),(4,5),(5,5),(1,4),(2,4),(5,4),(6,4),(1,3),(2,3)
,(5,3),(6,3),(1,2),(2,2),(4,2),(3,1),(4,1),(5,1)]


# c1 = (5,4)
# c2 =(3,6)


c1 = (4.75,2.38)
c2 =(2.5,4.2)

def distance ((x1,y1),(x2,y2)):

	x = math.pow((x1-x2),2)
	y = math.pow((y1-y2),2)
	t = x+y
	d = math.sqrt(t)

	return d

list1 = []
list2 = []
for l1 in l:
	index = l.index(l1) + 1
	d1 = round(distance (c1,l1),2)
	d2 = round(distance(c2,l1),2)
	list1.append((d1))
	list2.append((d2))

print ('the c1 of list is:', list1)
print('\n')
print ('the c2 of list is:', list2)


print ('\n')
print ('\n')

c11 = []
c22 = []

count = 0;
while count< len(list1):
	val1 = list1[count]
	val2 = list2[count]

	if val1<val2:
		c11.append((val1,count+1))
	else:
		c22.append((val2,count+1))

	count = count + 1 	

print(c11)
print('\n')
print(c22)

# elem1 = [1,2,3,4,5,7,8,11,12,15]
# elem2 = [6,9,19,13,14,16,17,18,19,20]

x1 = 0
x2 = 0
y1 = 0
y2 = 0 


for elements in c11:
	# print(l[elements-1][1])
	x1 = x1 + l[elements[1]-1][0]
	y1 = y1 + l[elements[1]-1][1]

xmean = x1/float(len(c11))
ymean = y1/float(len(c11))

print('\n')
print('xmean is :', xmean)
print('ymean is :', ymean)

