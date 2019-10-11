#!/usr/bin/env python
# coding: utf-8

# In[1]:


from cassandra.cluster import Cluster
from cassandra import ConsistencyLevel
from cassandra.query import SimpleStatement

cluster = Cluster()
connection = cluster.connect('image2code')

batch = """
BEGIN BATCH

INSERT INTO image2code.user_details (email, password, register_on, country, city, role)
	VALUES ('august@gmail.com',
			textAsBlob('7172ce2430493d6e61ee2b944054324ae3b459605649bc2707fb5be373144e0bacbc0d0e01ef186410d8bb5282de99876f5470385618a08b415751736b01367bc6c0b6182107b26ec8301eb96c625f87a3f8ced26a7c4642deea4027fb25041c'),
			toTimeStamp(toDate(now())),
			'Ukraine',
			'Kyiv',
			{
				profession : 'Developer',
				company : 'Student',
				why_use_service: 'hello WORLD!'
			}
	);
INSERT INTO image2code.user_pages (email, image_name, image_path, image_size, confirmed_page, pages)
	VALUES ('august@gmail.com',
			'image112344.jpg',
			'.../home/andrii/image2code/all_images/',
			(640, 480),
			TRUE,
			[{generation_time : toTimeStamp(now()), tags : {'hello'}, html_code : 'start start start <H1>hello!!!</H1></left></HTML> end'},
			 {generation_time : toTimeStamp(now()), tags : {'hello'}, html_code : 'start <HTML><center><H1>hello</H1></center></HTML> end'}
			]
	);
UPDATE image2code.user_pages SET pages = pages + [{generation_time : toTimeStamp(now()), tags : {'history', 'tanks'}, html_code : 'start start start <World War!> end  end'}] 
WHERE email = 'august@gmail.com' AND image_name = 'image112344.jpg' AND confirmed_page = FALSE;

APPLY BATCH;
"""
connection.execute(batch)

