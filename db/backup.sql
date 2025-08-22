PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(22) NOT NULL UNIQUE,
    email VARCHAR(44) UNIQUE,
    password_hash VARCHAR(600) NOT NULL  -- Increased for bcrypt hashes
);
INSERT INTO users VALUES(1,'test',NULL,'1');
INSERT INTO users VALUES(2,'testuser2',NULL,'scrypt:32768:8:1$ghhbDcTbw48pXPeC$d9ac851d665daf7e1fa9c569619564f3a5d7200595dc99479c928a0e95f60830da456efe296b1a450df5e582a6cb954119065effa6b168f307cd4101767fd3e2');
INSERT INTO users VALUES(3,'testuseremail','email@email.com','scrypt:32768:8:1$LbBuakKAHJiVr948$0864c1f5c5c0e7f3ee643f218833633a69db236f961ee6f9a268d641d4623841123f56986a80d3918e502358ffadc9e733411e781a5dbc5ea6b9b212467567a4');
INSERT INTO users VALUES(4,'nikki',NULL,'scrypt:32768:8:1$zhQJG9JEzkHX7Nm8$56f4db7c4b569794f62ae5af2f6ee436b54b645db58bf87ee32b6685e435ebd198949eb8c8e683483a7adedb8f2c25ac4e50dcebf43dbbdc72ea1e4f3fb3beff');
INSERT INTO users VALUES(5,'demouser',NULL,'scrypt:32768:8:1$RFk4pRKjO8fYQJef$03d20097c58704bff3d33b4e120367db586d6c34f9558a5d30cfc46ef41f599d9e42088877bd0e8c2189f912e9f8fe74e56825dd8e9e5c0ca91715ce801ad078');
INSERT INTO users VALUES(6,'testregister',NULL,'scrypt:32768:8:1$OcNeLeNlqIr2ut8P$08c3d8c10a091229a519995116d03071f1930da862dbfadf5e6675cf1ca7d564e3dc471fb1c44117113d966c826f3e8a3951daaa9f9f58fa246f44cac006b41b');
INSERT INTO users VALUES(7,'register2',NULL,'scrypt:32768:8:1$SvR1uLp982ebBm4Y$a5fbb56061391ea507dc4889d16f121a6cb8d41dcb2ed69e9090cf9071bd65fbf58f262a6eb30e776eb3b9f7328e675bdba513688a080cbb92b3508086c17b46');
INSERT INTO users VALUES(8,'register3',NULL,'scrypt:32768:8:1$ty6YI2b0jPRk8aWF$2ae04ea8adda2fca01c3f00d8cc6e17d4e637d56500beebcc3a42771b28197d440ffa1f514548d4330bff88eaeb1b0f8da60951e049a84313686bdcb8ae15cae');
INSERT INTO users VALUES(9,'Neil1',NULL,'scrypt:32768:8:1$a3IELWOIHWrW3zNu$c71c19831917d05bba3be0b4a86b8b781938b907dc55f957a4ff4be71f11f425dbb967d99158bbac9fea79f7ffcba01c7dcc4aedd370535fe54018363851df7a');
INSERT INTO users VALUES(10,'Neil',NULL,'scrypt:32768:8:1$NBjFlcYaZScjFsYF$51dd1ad0c4c1e43b717fd076364898ef600c227c3151791baad980b942d6e24bdb15601d505f7eeb14962333aa171692f39defa58b5e6fafcc4c85c45a4cbbe9');
INSERT INTO users VALUES(11,'NeilS',NULL,'scrypt:32768:8:1$GcEkfOPTDLLPVr5a$81190161b41de0b0cc535d488f5785da3b36415b6e5c4d437f0a17a30b2f620d0828cb0c4ad07379827da6d46b6e9145b3394e7a7e2add46afc1e3cc000260be');
CREATE TABLE vocabulary (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    word TEXT NOT NULL,
    definition TEXT,
    notes TEXT,
    example_sentence TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
INSERT INTO vocabulary VALUES(1,3,'apple','green or red fruit',NULL,NULL);
INSERT INTO vocabulary VALUES(2,3,'insinuate','to suggest something obliquely',NULL,NULL);
INSERT INTO vocabulary VALUES(3,3,'ORANGE','An orange coloured fruit',' ','in the godfather oranges are symbolic');
INSERT INTO vocabulary VALUES(4,3,'orange','orange colored fruit',NULL,NULL);
INSERT INTO vocabulary VALUES(5,3,'Yellow','bright color that looks yellow','sick','Yellow is a song by Coldplay');
INSERT INTO vocabulary VALUES(6,3,'Yellow','A song by coldplay','Good song','I listened to yellow yesterday');
INSERT INTO vocabulary VALUES(11,3,'football','game with a ball and kick with feet','','');
INSERT INTO vocabulary VALUES(12,3,'hello','a greeting when first meeting someone','easy word','Hello world');
INSERT INTO vocabulary VALUES(13,2,'House','living place','my first word','I live in a house.');
INSERT INTO vocabulary VALUES(14,3,'watch','What happens if the definition extends so far that it actually would take up two lines of space in the table on the index page? What do you think?','','Nice watch!');
INSERT INTO vocabulary VALUES(15,3,'When in Rome, do as the Romans do','follow the local culture','its an idiom','He said, when in Rome, do as the Romans do. What an idiot.');
INSERT INTO vocabulary VALUES(16,3,'insinuate','to suggest something without specifically saying it','','I insuated that shrimps are not a very suitable pet');
INSERT INTO vocabulary VALUES(17,3,'house','place to live','','I live in a house hooray');
INSERT INTO vocabulary VALUES(18,3,'cats','lots of furry animals','','I love cats');
INSERT INTO vocabulary VALUES(19,3,'dogs','lots of dogs','','');
INSERT INTO vocabulary VALUES(20,3,'canine','fancy word for dogs','not tooth','K9 was a dog in doctor who');
INSERT INTO vocabulary VALUES(21,3,'flabbergasted','to be extraordinarily astonished','','She was flabbergasted');
INSERT INTO vocabulary VALUES(24,3,'寄付','donating money','','');
INSERT INTO vocabulary VALUES(25,3,'barking','noise a dog makes','','I heard the dog barking');
INSERT INTO vocabulary VALUES(26,3,'lavatory','a room, building, or cubicle containing a toilet or toilets','','he locked himself in the downstairs lavatory');
INSERT INTO vocabulary VALUES(28,3,'hack','break into something or take a shortcut','','It was hacked');
INSERT INTO vocabulary VALUES(29,4,'shrimp','cute aquatic animal with a lot of legs','','');
INSERT INTO vocabulary VALUES(30,5,'mountain','tall geological feature - bigger than a hill','','Climbing mountains is a good hobby if you want to keep fit');
INSERT INTO vocabulary VALUES(31,5,'改善','betterment; improvement​','kaizen; business word for improvement','');
INSERT INTO vocabulary VALUES(32,10,'TrEe','A green tall plant good for the planet','','There are lots of trees near the river.');
INSERT INTO vocabulary VALUES(37,3,'慎重','careful; cautious; prudent; discreet; deliberate​','shincho','');
INSERT INTO vocabulary VALUES(39,3,'multiple','lots','','');
INSERT INTO vocabulary VALUES(40,3,'lots','multiple','','lots and lots and lots');
INSERT INTO vocabulary VALUES(41,3,'lots','multpipl','','');
INSERT INTO vocabulary VALUES(42,3,'many','lots','','');
INSERT INTO vocabulary VALUES(43,3,'yoghury','vreamy food','','');
INSERT INTO vocabulary VALUES(44,3,'god','beards and stuff','','');
INSERT INTO vocabulary VALUES(45,3,'alarm','bringbring','','');
INSERT INTO vocabulary VALUES(46,3,'boat','the boat','','the boat was passig by');
INSERT INTO vocabulary VALUES(47,3,'other boat','the other boat','','');
INSERT INTO vocabulary VALUES(48,3,'reverse','the other way','','');
INSERT INTO vocabulary VALUES(49,3,'darn','mistaake','','');
INSERT INTO vocabulary VALUES(50,3,'example','tings that show','','');
INSERT INTO vocabulary VALUES(51,3,'examples','many things that show','','');
INSERT INTO vocabulary VALUES(52,3,'familiar ','know well','','');
INSERT INTO vocabulary VALUES(53,3,'unfamiliar','dont know','','');
INSERT INTO vocabulary VALUES(54,3,'success','winning a million dollar feeling','','');
INSERT INTO vocabulary VALUES(55,3,'third','its a charm','','');
INSERT INTO vocabulary VALUES(56,3,'test','make sure something works','','');
INSERT INTO vocabulary VALUES(57,3,'one','the one','','');
INSERT INTO vocabulary VALUES(58,3,'two ','the second','','');
INSERT INTO vocabulary VALUES(59,3,'bomb','Isreal','','');
INSERT INTO vocabulary VALUES(60,3,'hello','yeah','','khkjhjk');
INSERT INTO vocabulary VALUES(61,3,'bass','heavy beats','','');
INSERT INTO vocabulary VALUES(62,3,'creek','water ery place','','');
INSERT INTO vocabulary VALUES(63,3,'shabby','not to hot','','');
INSERT INTO vocabulary VALUES(64,3,'trance','state of it','','');
INSERT INTO vocabulary VALUES(65,3,'yuck','sick','','');
INSERT INTO vocabulary VALUES(66,3,'red','blood','','');
INSERT INTO vocabulary VALUES(67,3,'plant pot','hold a plant','','https://youtu.be/oJbfMBROEO0?si=e5E_O7qbJekPrAuZ');
INSERT INTO vocabulary VALUES(68,3,'road','long flat thing','','');
INSERT INTO vocabulary VALUES(69,3,'soul','the inside','','');
INSERT INTO vocabulary VALUES(70,3,'tears','creying','','');
INSERT INTO vocabulary VALUES(71,3,'fate','the fates','','');
INSERT INTO vocabulary VALUES(72,3,'operations','these are the o\thingsw we do all the time','','');
INSERT INTO vocabulary VALUES(73,3,'videos','things to watch online','','');
INSERT INTO vocabulary VALUES(74,3,'lavatory','a room, building, or cubicle containing a toilet or toilets','','he locked himself in the downstairs lavatory');
INSERT INTO vocabulary VALUES(75,3,'均衡','equilibrium; balance​',' きんこう ','');
CREATE TABLE media (
    id SERIAL PRIMARY KEY,
    word_id INTEGER NOT NULL,
    article_excerpt TEXT,
    media_type VARCHAR(10) CHECK (media_type IN ('youtube', 'vimeo', 'article')),
    video_id TEXT,
    start_time INTEGER,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    FOREIGN KEY (word_id) REFERENCES vocabulary(id) ON DELETE CASCADE
);
INSERT INTO media VALUES(1,39,'https://www.youtube.com/watch?v=Z_0uBH2qunE&list=PLRW80bBvVD3UA2JWHg9l_1IQKIaoGp3bD&index=15','video','https://www.youtube.com/watch?v=Z_0uBH2qunE&list=PLRW80bBvVD3UA2JWHg9l_1IQKIaoGp3bD&index=15',NULL,NULL,NULL);
INSERT INTO media VALUES(2,42,'https://youtu.be/_KEQH99fMts?si=3UzedVO_hPBxzVzc','video','https://youtu.be/_KEQH99fMts?si=3UzedVO_hPBxzVzc',NULL,NULL,NULL);
INSERT INTO media VALUES(3,43,'https://youtu.be/_KEQH99fMts?si=3UzedVO_hPBxzVzc','video','https://youtu.be/_KEQH99fMts?si=3UzedVO_hPBxzVzc',NULL,NULL,NULL);
INSERT INTO media VALUES(4,44,'https://youtu.be/_KEQH99fMts?si=3UzedVO_hPBxzVzc','video','https://youtu.be/_KEQH99fMts?si=3UzedVO_hPBxzVzc',NULL,NULL,NULL);
INSERT INTO media VALUES(5,44,'https://youtu.be/_KEQH99fMts?si=3UzedVO_hPBxzVzc','video','https://youtu.be/_KEQH99fMts?si=3UzedVO_hPBxzVzc',NULL,NULL,NULL);
INSERT INTO media VALUES(6,45,'https://youtu.be/_KEQH99fMts?si=3UzedVO_hPBxzVzc','video','',NULL,NULL,NULL);
INSERT INTO media VALUES(7,45,'https://youtu.be/_KEQH99fMts?si=3UzedVO_hPBxzVzc','video','',NULL,NULL,NULL);
INSERT INTO media VALUES(8,46,'https://youtu.be/Z_0uBH2qunE?si=ET99hWgb2gtUo1UW','video',NULL,'youtube','czhCsHplCd8',274);
INSERT INTO media VALUES(9,47,NULL,'article','sheeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeen indeed we got on the other boat',NULL,NULL,NULL);
INSERT INTO media VALUES(10,47,'https://youtu.be/4JxBKrr1H4w?si=ZF58yG6erJ8xzolK','video',NULL,NULL,NULL,NULL);
INSERT INTO media VALUES(11,48,'https://youtu.be/Z_0uBH2qunE?si=ET99hWgb2gtUo1UW','video','',NULL,NULL,NULL);
INSERT INTO media VALUES(12,49,NULL,'article','',NULL,NULL,NULL);
INSERT INTO media VALUES(13,49,NULL,'article','',NULL,NULL,NULL);
INSERT INTO media VALUES(14,50,'The examples above are classes and objects in their simplest form, and are not really useful in real life applications.  To understand the meaning of classes we have to understand the built-in __init__() method.  All classes have a method called __init__(), which is always executed when the class is being initiated.  Use the __init__() method to assign values to object properties, or other operations that are necessary to do when the object is being created:','article','The examples above are classes and objects in their simplest form, and are not really useful in real life applications.  To understand the meaning of classes we have to understand the built-in __init__() method.  All classes have a method called __init__(), which is always executed when the class is being initiated.  Use the __init__() method to assign values to object properties, or other operations that are necessary to do when the object is being created:',NULL,NULL,NULL);
INSERT INTO media VALUES(15,50,'The examples above are classes and objects in their simplest form, and are not really useful in real life applications.  To understand the meaning of classes we have to understand the built-in __init__() method.  All classes have a method called __init__(), which is always executed when the class is being initiated.  Use the __init__() method to assign values to object properties, or other operations that are necessary to do when the object is being created:','article','The examples above are classes and objects in their simplest form, and are not really useful in real life applications.  To understand the meaning of classes we have to understand the built-in __init__() method.  All classes have a method called __init__(), which is always executed when the class is being initiated.  Use the __init__() method to assign values to object properties, or other operations that are necessary to do when the object is being created:',NULL,NULL,NULL);
INSERT INTO media VALUES(16,52,NULL,'article','caatttttttttttttttttttttttttttttttttts familar',NULL,NULL,NULL);
INSERT INTO media VALUES(17,52,'The examples above are classes and objects in their simplest form, and are not really useful in real life applications.  To understand the meaning of classes we have to understand the built-in __init__() method.  All classes have a method called __init__(), which is always executed when the class is being initiated.  Use the __init__() method to assign values to object properties, or other operations that are necessary to do when the object is being created:','article','The examples above are classes and objects in their simplest form, and are not really useful in real life applications.  To understand the meaning of classes we have to understand the built-in __init__() method.  All classes have a method called __init__(), which is always executed when the class is being initiated.  Use the __init__() method to assign values to object properties, or other operations that are necessary to do when the object is being created:',NULL,NULL,NULL);
INSERT INTO media VALUES(18,52,'https://youtu.be/9RMHHwJ9Eqk?si=JXJBLcmRyDkLvhu8&t=163','video',NULL,NULL,NULL,NULL);
INSERT INTO media VALUES(19,53,'https://youtu.be/4xUDx_NTIQ0?si=GyCSlqIDhsoSQlmz','video','',NULL,NULL,NULL);
INSERT INTO media VALUES(20,53,'https://youtu.be/j1wgaFJ0750?si=veIWwA7w3dsusZVE&t=117','video',NULL,NULL,NULL,NULL);
INSERT INTO media VALUES(21,54,NULL,'article','The examples above are classes and objects in their simplest form, and are not really useful in real life applications.  To understand the meaning of classes we have to understand the built-in __init__() method.  All classes have a method called __init__(), which is always executed when the class is being initiated.  Use the __init__() method to assign values to object properties, or other operations that are necessary to do when the object is being created:',NULL,NULL,NULL);
INSERT INTO media VALUES(22,54,'https://youtu.be/oJbfMBROEO0?si=e5E_O7qbJekPrAuZ','video',NULL,NULL,NULL,NULL);
INSERT INTO media VALUES(23,55,NULL,'article','【ワシントン=八十島綾平】米相互関税の負担軽減措置を巡り赤沢亮正経済財政・再生相は7日、米政府が相互関税の大統領令を修正し、日本を措置対象に加えることを約束したと明らかにした。米国が徴収しすぎた分の関税は7日に遡って還付する。米政府は修正と同じ時期に、自動車関税を下げるための大統領令も出すとの見通しを示した。',NULL,NULL,NULL);
INSERT INTO media VALUES(24,55,'https://youtu.be/oJbfMBROEO0?si=e5E_O7qbJekPrAuZ','video',NULL,NULL,NULL,NULL);
INSERT INTO media VALUES(25,55,'https://youtu.be/4xUDx_NTIQ0?si=GyCSlqIDhsoSQlmz','video',NULL,NULL,NULL,NULL);
INSERT INTO media VALUES(26,55,NULL,'article',' The examples above are classes and objects in their simplest form, and are not really useful in real life applications.  To understand the meaning of classes we have to understand the built-in __init__() method.  All classes have a method called __init__(), which is always executed when the class is being initiated.  Use the __init__() method to assign values to object properties, or other operations that are necessary to do when the object is being created:',NULL,NULL,NULL);
INSERT INTO media VALUES(27,56,NULL,'article',' The examples above are classes and objects in their simplest form, and are not really useful in real life applications.  To understand the meaning of classes we have to understand the built-in __init__() method.  All classes have a method called __init__(), which is always executed when the class is being initiated.  Use the __init__() method to assign values to object properties, or other operations that are necessary to do when the object is being created:',NULL,NULL,NULL);
INSERT INTO media VALUES(28,56,'https://youtu.be/oJbfMBROEO0?si=e5E_O7qbJekPrAuZ','video',NULL,NULL,NULL,NULL);
INSERT INTO media VALUES(29,56,'https://youtu.be/4xUDx_NTIQ0?si=GyCSlqIDhsoSQlmz','video',NULL,NULL,NULL,NULL);
INSERT INTO media VALUES(30,57,NULL,'article','',NULL,NULL,NULL);
INSERT INTO media VALUES(31,58,NULL,'article','',NULL,NULL,NULL);
INSERT INTO media VALUES(32,59,'https://youtu.be/4xUDx_NTIQ0?si=GyCSlqIDhsoSQlmz','video',NULL,NULL,NULL,NULL);
INSERT INTO media VALUES(33,59,NULL,'article','The examples above are classes and objects in their simplest form, and are not really useful in real life applications.  To understand the meaning of classes we have to understand the built-in __init__() method.  All classes have a method called __init__(), which is always executed when the class is being initiated.  Use the __init__() method to assign values to object properties, or other operations that are necessary to do when the object is being created:',NULL,NULL,NULL);
INSERT INTO media VALUES(34,60,NULL,'article','vjhvhgv',NULL,NULL,NULL);
INSERT INTO media VALUES(35,60,NULL,'article','hkjjjhjkhkh',NULL,NULL,NULL);
INSERT INTO media VALUES(36,61,'https://youtu.be/oJbfMBROEO0?si=e5E_O7qbJekPrAuZ','video',NULL,NULL,NULL,NULL);
INSERT INTO media VALUES(37,61,NULL,'article','Use the __init__() method to assign values to object properties, or other operations that are necessary to do when the object is being created:',NULL,NULL,NULL);
INSERT INTO media VALUES(38,62,'https://youtu.be/oJbfMBROEO0?si=e5E_O7qbJekPrAuZ','video',NULL,NULL,NULL,NULL);
INSERT INTO media VALUES(39,62,NULL,'article','To understand the meaning of classes we have to understand the built-in __init__() method.',NULL,NULL,NULL);
INSERT INTO media VALUES(40,63,'https://youtu.be/oJbfMBROEO0?si=e5E_O7qbJekPrAuZ','video',NULL,NULL,NULL,NULL);
INSERT INTO media VALUES(41,63,NULL,'article','【ワシントン=八十島綾平】米相互関税の負担軽減措置を巡り赤沢亮正経済財政・再生相は7日、米政府が相互関税の大統領令を修正し、日本を措置対象に加えることを約束したと明らかにした。米国が徴収しすぎた分の関税は7日に遡って還付する。米政府は修正と同じ時期に、自動車関税を下げるための大統領令も出すとの見通しを示した。',NULL,NULL,NULL);
INSERT INTO media VALUES(42,64,'https://youtu.be/W-ZudclsICM?si=5RIUQsSqp--68xLZ','video',NULL,NULL,NULL,NULL);
INSERT INTO media VALUES(43,64,NULL,'article',' PM for an e-commerce compay working in a matrix enviroment. I am currently globally dispersed project teams remotely for a public organisation. I bring a broad perspectiv',NULL,NULL,NULL);
INSERT INTO media VALUES(44,65,NULL,'article',' PM for an e-commerce compay working in a matrix enviroment. I am currently globally dispersed project teams remotely for a public organisation. I bring a broad perspectiv',NULL,NULL,NULL);
INSERT INTO media VALUES(45,65,'https://youtu.be/oJbfMBROEO0?si=e5E_O7qbJekPrAuZ','video',NULL,NULL,NULL,NULL);
INSERT INTO media VALUES(46,66,'https://youtu.be/4xUDx_NTIQ0?si=GyCSlqIDhsoSQlmz','video',NULL,NULL,NULL,NULL);
INSERT INTO media VALUES(47,66,NULL,'article','dsadsadsadasda',NULL,NULL,NULL);
INSERT INTO media VALUES(48,67,NULL,'article','dddddddddddddddddddddddddddddddddddd',NULL,NULL,NULL);
INSERT INTO media VALUES(49,67,NULL,'article','',NULL,NULL,NULL);
INSERT INTO media VALUES(50,68,'https://youtu.be/4xUDx_NTIQ0?si=GyCSlqIDhsoSQlmz','video',NULL,NULL,NULL,NULL);
INSERT INTO media VALUES(51,68,NULL,'article',' To understand the meaning of classes we have to understand the built-in __init__() method.',NULL,NULL,NULL);
INSERT INTO media VALUES(52,69,'https://youtu.be/oJbfMBROEO0?si=e5E_O7qbJekPrAuZ','video',NULL,NULL,NULL,NULL);
INSERT INTO media VALUES(53,69,NULL,'article','ttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttto',NULL,NULL,NULL);
INSERT INTO media VALUES(54,70,'https://youtu.be/4xUDx_NTIQ0?si=GyCSlqIDhsoSQlmz','video',NULL,NULL,NULL,NULL);
INSERT INTO media VALUES(55,70,NULL,'article','qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq',NULL,NULL,NULL);
INSERT INTO media VALUES(56,71,'https://youtu.be/4xUDx_NTIQ0?si=GyCSlqIDhsoSQlmz','video',NULL,NULL,NULL,NULL);
INSERT INTO media VALUES(57,71,NULL,'article','greeaaaaaaaaaaaaaaaaaaaaaaaaaaaaaat!!',NULL,NULL,NULL);
INSERT INTO media VALUES(58,72,NULL,'article','',NULL,NULL,NULL);
INSERT INTO media VALUES(59,72,'https://youtu.be/4JxBKrr1H4w?si=ZF58yG6erJ8xzolK','video',NULL,NULL,NULL,NULL);
INSERT INTO media VALUES(60,73,NULL,'article','',NULL,NULL,NULL);
INSERT INTO media VALUES(61,73,NULL,'article','',NULL,NULL,NULL);
INSERT INTO media VALUES(62,73,NULL,'article','',NULL,NULL,NULL);
INSERT INTO media VALUES(63,73,'https://youtu.be/4JxBKrr1H4w?si=ZF58yG6erJ8xzolK','video',NULL,NULL,NULL,NULL);
INSERT INTO media VALUES(64,74,'https://youtu.be/1eQNExixj70?t=293','video',NULL,NULL,NULL,NULL);
INSERT INTO media VALUES(65,75,NULL,'article','【ワシントン=河浪武史】ベッセント米財務長官は日本経済新聞との単独インタビューで、相互関税について「時間がたつにつれ角氷のように溶けていくべき存在だ」と述べ、貿易不均衡の是正が進めば縮小する可能性を示した。27.5%の自動車関税の引き下げ時期は、英国と同様に合意から50日前後が1つの目安になると表明した。',NULL,NULL,NULL);
INSERT INTO media VALUES(66,75,'https://www.youtube.com/watch?v=_FPkSBwYeFs&t=220s','video',NULL,NULL,NULL,NULL);
INSERT INTO media VALUES(67,25,'https://youtu.be/j1wgaFJ0750?si=veIWwA7w3dsusZVE&t=117','video',NULL,NULL,NULL,NULL);
INSERT INTO media VALUES(68,53,NULL,'article','shriiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiimp unfamiliar',NULL,NULL,NULL);
INSERT INTO media VALUES(69,54,NULL,'article','yaaaauuuuuuuuuuuuuuuuuuuuuuuuuu success','youtube','IJ85kCdqWao',NULL);
INSERT INTO media VALUES(70,51,NULL,'video',NULL,'youtube','IJ85kCdqWao',NULL);
INSERT INTO media VALUES(71,46,NULL,'video',NULL,'youtube','czhCsHplCd8',274);
INSERT INTO media VALUES(72,46,NULL,'video',NULL,'youtube','Z_0uBH2qunE',NULL);
INSERT INTO media VALUES(73,46,NULL,'video',NULL,'youtube','L18ywLlvWOw',2240);
INSERT INTO media VALUES(74,46,NULL,'video',NULL,'youtube','czhCsHplCd8',274);
INSERT INTO media VALUES(75,46,NULL,'video',NULL,'youtube','4xUDx_NTIQ0',NULL);
INSERT INTO media VALUES(76,46,NULL,'video',NULL,'youtube','czhCsHplCd8',274);
INSERT INTO media VALUES(77,46,NULL,'video',NULL,'youtube','czhCsHplCd8',274);
INSERT INTO media VALUES(78,46,NULL,'video',NULL,'youtube','czhCsHplCd8',274);
INSERT INTO media VALUES(79,40,NULL,'video',NULL,'youtube','czhCsHplCd8',274);
INSERT INTO media VALUES(80,40,NULL,'article','lots and lots blah blah blah https://youtu.be/czhCsHplCd8?si=du7V-SAHEbeRKZzY&t=274',NULL,NULL,NULL);
INSERT INTO sqlite_sequence VALUES('users',11);
INSERT INTO sqlite_sequence VALUES('vocabulary',75);
INSERT INTO sqlite_sequence VALUES('media',80);
COMMIT;
