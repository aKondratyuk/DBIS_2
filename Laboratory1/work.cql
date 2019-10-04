//WORKING WITH user_details
//INSERTS
INSERT INTO image2code.user_details (email, password, register_on, country, city, role)
	VALUES ('plug2up@gmail.com',
			textAsBlob('7172ce2430493d6e61ee2b944054324ae3b459605649bc2707fb5be373144e0bacbc0d0e01ef186410d8bb5282de99876f5470385618a08b415751736b01367bc6c0b6182107b26ec8301eb96c625f87a3f8ced26a7c4642deea4027fb25041c'),
			toTimeStamp(toDate(now())),
			'Ukraine',
			'Kyiv',
			{
				profession : 'Developer',
				company : 'Student',
				why_use_service: 'hello, I use your service to create something beatiful'
			}
	);
INSERT INTO image2code.user_details (email, password, register_on, country, city, role)
	VALUES ('nestle@gmail.com',
			textAsBlob('aec924de439d596353a93546edd793d8803b322750717ec5d9509ed2abe0eadc5b6d5a2f70489fcf651d120341c28ca060ba8c73c87ab20b8b330205c5d93e994f2fcca52a3a03c1e70be25c6cfcab0ca8af1df83db29157be0c9ea98a53334c'),
			toTimeStamp(toDate(now())),
			'Germany',
			'Berlin',
			{
				profession : 'Designer',
				company : 'Large Company',
				why_use_service: 'AWESOME'
			}
	);
INSERT INTO image2code.user_details (email, password, register_on, country, city, role)
	VALUES ('avengers@earth.net',
			textAsBlob('6e0f6693aa39f9abd2ebc41190179e39ed39a1979c6a1c14271dbadadd9df33294aaf2401faa14a6c3358ab0e3ff68bd706bc86da97a1b27384d76e00ccfbe8341353e662243def422b82386bac5bca4b9979296a4f7f8208af2d5dc8637b41a'),
			toTimeStamp(toDate(now())),
			'New York',
			'USA',
			{
				profession : 'Developer',
				company : 'Startup',
				why_use_service: 'I use your startup to improve my own startup!'
			}
	);
SELECT * FROM image2code.user_details;
//UPDATES
UPDATE image2code.user_details SET country = 'LaLalend' WHERE email = 'plug2up@gmail.com';
SELECT * FROM image2code.user_details;
UPDATE image2code.user_details SET city = 'American Dream' WHERE email = 'avengers@earth.net';
SELECT * FROM image2code.user_details;
//UPDTAE UDT
UPDATE image2code.user_details SET role = {profession : 'Designer', company : 'Student', why_use_service : 'I dont know'} WHERE email = 'plug2up@gmail.com';
SELECT * FROM image2code.user_details;
//DELETES
DELETE country FROM image2code.user_details WHERE email = 'plug2up@gmail.com';
DELETE FROM image2code.user_details WHERE email = 'nestle@gmail.com';
DELETE role FROM image2code.user_details WHERE email = 'avengers@earth.net';
SELECT * FROM image2code.user_details;

//WORKING WITH user_pages
//INSERTS
INSERT INTO image2code.user_pages (email, image_name, image_path, image_size, confirmed_page, pages)
	VALUES ('plug2up@gmail.com',
			'image41254.jpg',
			'.../home/andrii/image2code/all_images/',
			(640, 480),
			TRUE,
			[{generation_time : toTimeStamp(now()), tags : {'hello', 'world'}, html_code : 'start <HTML><center><H1>Hello World!</H1></center></HTML> end'}]
	);
INSERT INTO image2code.user_pages (email, image_name, image_path, image_size, confirmed_page, pages)
	VALUES ('nestle@gmail.com',
			'image41307.jpg',
			'.../home/andrii/image2code/all_images/',
			(640, 480),
			FALSE,
			[{generation_time : toTimeStamp(now()), tags : {'hello', 'hi world'}, html_code : 'start <HTML><center><H1>Hello World! end'},
			 {generation_time : toTimeStamp(now()), tags : {'history', 'tanks'}, html_code : 'start <World War! end'}
			]
	);
INSERT INTO image2code.user_pages (email, image_name, image_path, image_size, confirmed_page, pages)
	VALUES ('avengers@earth.net',
			'image41309.jpg',
			'.../home/andrii/image2code/all_images/',
			(640, 480),
			TRUE,
			[{generation_time : toTimeStamp(now()), tags : {'hello'}, html_code : 'start start start <H1>hello!!!</H1></left></HTML> end'},
			 {generation_time : toTimeStamp(now()), tags : {'hello'}, html_code : 'start <HTML><center><H1>hello</H1></center></HTML> end'}
			]
	);
INSERT INTO image2code.user_pages (email, image_name, image_path, image_size, confirmed_page, pages)
	VALUES ('plug2up@gmail.com',
			'image41312.jpg',
			'.../home/andrii/image2code/all_images/',
			(640, 480),
			TRUE,
			[{generation_time : toTimeStamp(now()), tags : {'hello', 'world'}, html_code : 'start <HTML><center><H1>Hello World!</H1></center></HTML> end'}]
	);
SELECT JSON * FROM image2code.user_pages;
//UPDATES
//UPDATE UDT
UPDATE image2code.user_pages SET pages = pages + [{generation_time : toTimeStamp(now()), tags : {'history', 'tanks'}, html_code : 'start start start <World War!> end  end'}] 
WHERE email = 'nestle@gmail.com' AND image_name = 'image41307.jpg' AND confirmed_page = FALSE;
SELECT JSON * FROM image2code.user_pages WHERE email = 'nestle@gmail.com';
//UPDATE STATIC COLUMN
UPDATE image2code.user_pages SET image_path = '.../home/andrii/image2code/pictures/' WHERE email = 'plug2up@gmail.com';
SELECT JSON * FROM image2code.user_pages WHERE email = 'plug2up@gmail.com';
UPDATE image2code.user_pages SET image_size = (512, 512) WHERE email = 'avengers@earth.net' AND image_name = 'image41309.jpg' AND confirmed_page = TRUE;
SELECT JSON * FROM image2code.user_pages WHERE email = 'avengers@earth.net';
//DELETES
DELETE image_path FROM image2code.user_pages WHERE email = 'plug2up@gmail.com';
DELETE FROM image2code.user_pages WHERE email = 'nestle@gmail.com';
DELETE pages FROM image2code.user_pages WHERE email = 'avengers@earth.net' AND image_name = 'image41309.jpg';
SELECT * FROM image2code.user_pages;

//WORKING WITH QUANTITY TABLES
UPDATE image2code.num_of_uploaded_images_by_user SET images_counter = images_counter + 2 WHERE email = 'plug2up@gmail.com';
UPDATE image2code.num_of_uploaded_images_by_user SET total_pages_counter = total_pages_counter + 2 WHERE email = 'plug2up@gmail.com';
UPDATE image2code.num_of_generated_pages SET pages_counter = pages_counter + 2 WHERE email = 'nestle@gmail.com' AND image_name = 'image41307.jpg';
UPDATE image2code.num_of_generated_pages SET pages_counter = pages_counter + 1 WHERE email = 'plug2up@gmail.com' AND image_name = 'image41254.jpg';
UPDATE image2code.num_of_generated_pages SET pages_counter = pages_counter + 1 WHERE email = 'plug2up@gmail.com' AND image_name = 'image41312.jpg';
//FOUR QUERIES
// 1. FIND ALL GENERATED PAGES BY USER
SELECT * FROM image2code.user_pages WHERE email = 'plug2up@gmail.com';
// 2. FIND ALL CONFRIRMED PAGES BY USER
SELECT * FROM image2code.user_pages WHERE email = 'plug2up@gmail.com' AND confirmed_page = TRUE;
// 3. QUANTITY OF UPLOADED IMAGES BY USER AND TOTAL COUNT OF GENERATED PAGES
SELECT * FROM image2code.num_of_uploaded_images_by_user WHERE email = 'plug2up@gmail.com';
// 4. NUMBER OF GENERATED PAGES BY USER TO SPECIFIED IMAGE
SELECT * FROM image2code.num_of_generated_pages WHERE email = 'plug2up@gmail.com' AND image_name = 'image41254.jpg';