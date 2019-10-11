#!/usr/bin/env python
# coding: utf-8

# In[18]:


from cassandra.cluster import Cluster
from cassandra import ConsistencyLevel
from cassandra.query import SimpleStatement

cluster = Cluster()
connection = cluster.connect('image2code')

path = '/home/andrii/.devcenter/DevCenter/CQLScripts/'
CQLscripts = ['create.cql', 'work.cql', 'drop.cql']

for script in CQLscripts:
    with open(path+script, mode='r') as f:
        txt = f.read()
        statements = txt.split(';')
        for statement in statements:
            statement = statement.strip()
            if statement != '':
                print(statement)
                if script == 'drop.cql':
                    query = SimpleStatement(statement, consistency_level = ConsistencyLevel.QUORUM)
                elif script == 'create.cql':
                    query = SimpleStatement(statement, consistency_level = ConsistencyLevel.QUORUM)
                else:
                    query = SimpleStatement(statement, consistency_level = ConsistencyLevel.ONE)


# In[ ]:




