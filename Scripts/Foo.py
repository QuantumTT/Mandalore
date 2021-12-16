# Suppose this is foo.py.

mylistA = ['frog']
mylistB = ['bird', 'bee', 'bumblenipper']
tot_list = [mylistA, mylistB]

for list in tot_list:
    print(len(list))
    if len(list)>1:
        print(list[2])

