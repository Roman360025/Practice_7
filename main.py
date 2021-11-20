import tarantool
import pandas as pd

connection = tarantool.connect("localhost", 3301, user='admin', password='pass')

tester = connection.space('test1')


data = tester.select()


connection.call('box.space.test1:drop',())

data1 = pd.DataFrame(d[1] for d in data)

data1.groupby(['Day'])['Speed'].median()
data1.groupby(['Day'])['TickTime'].min()
data1.groupby(['Day'])['TickTime'].max()