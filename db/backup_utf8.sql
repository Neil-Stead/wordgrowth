BEGIN TRANSACTION;
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(22) NOT NULL UNIQUE,
    email VARCHAR(44) UNIQUE,
    password_hash VARCHAR(600) NOT NULL  -- Increased for bcrypt hashes
);
INSERT INTO "users" VALUES(1,'test',NULL,'1');
INSERT INTO "users" VALUES(2,'testuser2',NULL,'scrypt:32768:8:1$ghhbDcTbw48pXPeC$d9ac851d665daf7e1fa9c569619564f3a5d7200595dc99479c928a0e95f60830da456efe296b1a450df5e582a6cb954119065effa6b168f307cd4101767fd3e2');
INSERT INTO "users" VALUES(3,'testuseremail','email@email.com','scrypt:32768:8:1$LbBuakKAHJiVr948$0864c1f5c5c0e7f3ee643f218833633a69db236f961ee6f9a268d641d4623841123f56986a80d3918e502358ffadc9e733411e781a5dbc5ea6b9b212467567a4');
INSERT INTO "users" VALUES(4,'nikki',NULL,'scrypt:32768:8:1$zhQJG9JEzkHX7Nm8$56f4db7c4b569794f62ae5af2f6ee436b54b645db58bf87ee32b6685e435ebd198949eb8c8e683483a7adedb8f2c25ac4e50dcebf43dbbdc72ea1e4f3fb3beff');
INSERT INTO "users" VALUES(5,'demouser',NULL,'scrypt:32768:8:1$RFk4pRKjO8fYQJef$03d20097c58704bff3d33b4e120367db586d6c34f9558a5d30cfc46ef41f599d9e42088877bd0e8c2189f912e9f8fe74e56825dd8e9e5c0ca91715ce801ad078');
INSERT INTO "users" VALUES(6,'testregister',NULL,'scrypt:32768:8:1$OcNeLeNlqIr2ut8P$08c3d8c10a091229a519995116d03071f1930da862dbfadf5e6675cf1ca7d564e3dc471fb1c44117113d966c826f3e8a3951daaa9f9f58fa246f44cac006b41b');
INSERT INTO "users" VALUES(7,'register2',NULL,'scrypt:32768:8:1$SvR1uLp982ebBm4Y$a5fbb56061391ea507dc4889d16f121a6cb8d41dcb2ed69e9090cf9071bd65fbf58f262a6eb30e776eb3b9f7328e675bdba513688a080cbb92b3508086c17b46');
INSERT INTO "users" VALUES(8,'register3',NULL,'scrypt:32768:8:1$ty6YI2b0jPRk8aWF$2ae04ea8adda2fca01c3f00d8cc6e17d4e637d56500beebcc3a42771b28197d440ffa1f514548d4330bff88eaeb1b0f8da60951e049a84313686bdcb8ae15cae');
INSERT INTO "users" VALUES(9,'Neil1',NULL,'scrypt:32768:8:1$a3IELWOIHWrW3zNu$c71c19831917d05bba3be0b4a86b8b781938b907dc55f957a4ff4be71f11f425dbb967d99158bbac9fea79f7ffcba01c7dcc4aedd370535fe54018363851df7a');
INSERT INTO "users" VALUES(10,'Neil',NULL,'scrypt:32768:8:1$NBjFlcYaZScjFsYF$51dd1ad0c4c1e43b717fd076364898ef600c227c3151791baad980b942d6e24bdb15601d505f7eeb14962333aa171692f39defa58b5e6fafcc4c85c45a4cbbe9');
INSERT INTO "users" VALUES(11,'NeilS',NULL,'scrypt:32768:8:1$GcEkfOPTDLLPVr5a$81190161b41de0b0cc535d488f5785da3b36415b6e5c4d437f0a17a30b2f620d0828cb0c4ad07379827da6d46b6e9145b3394e7a7e2add46afc1e3cc000260be');
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
INSERT INTO "vocabulary" VALUES(1,3,'apple','green or red fruit',NULL,NULL);
INSERT INTO "vocabulary" VALUES(2,3,'insinuate','to suggest something obliquely',NULL,NULL);
INSERT INTO "vocabulary" VALUES(3,3,'ORANGE','An orange coloured fruit',' ','in the godfather oranges are symbolic');
INSERT INTO "vocabulary" VALUES(4,3,'orange','orange colored fruit',NULL,NULL);
INSERT INTO "vocabulary" VALUES(5,3,'Yellow','bright color that looks yellow','sick','Yellow is a song by Coldplay');
INSERT INTO "vocabulary" VALUES(6,3,'Yellow','A song by coldplay','Good song','I listened to yellow yesterday');
INSERT INTO "vocabulary" VALUES(11,3,'football','game with a ball and kick with feet','','');
INSERT INTO "vocabulary" VALUES(12,3,'hello','a greeting when first meeting someone','easy word','Hello world');
INSERT INTO "vocabulary" VALUES(13,2,'House','living place','my first word','I live in a house.');
INSERT INTO "vocabulary" VALUES(14,3,'watch','What happens if the definition extends so far that it actually would take up two lines of space in the table on the index page? What do you think?','','Nice watch!');
INSERT INTO "vocabulary" VALUES(15,3,'When in Rome, do as the Romans do','follow the local culture','its an idiom','He said, when in Rome, do as the Romans do. What an idiot.');
INSERT INTO "vocabulary" VALUES(16,3,'insinuate','to suggest something without specifically saying it','','I insuated that shrimps are not a very suitable pet');
INSERT INTO "vocabulary" VALUES(17,3,'house','place to live','','I live in a house hooray');
INSERT INTO "vocabulary" VALUES(18,3,'cats','lots of furry animals','','I love cats');
INSERT INTO "vocabulary" VALUES(19,3,'dogs','lots of dogs','','');
INSERT INTO "vocabulary" VALUES(20,3,'canine','fancy word for dogs','not tooth','K9 was a dog in doctor who');
INSERT INTO "vocabulary" VALUES(21,3,'flabbergasted','to be extraordinarily astonished','','She was flabbergasted');
INSERT INTO "vocabulary" VALUES(25,3,'barking','noise a dog makes','','I heard the dog barking');
INSERT INTO "vocabulary" VALUES(26,3,'lavatory','a room, building, or cubicle containing a toilet or toilets','','he locked himself in the downstairs lavatory');
INSERT INTO "vocabulary" VALUES(28,3,'hack','break into something or take a shortcut','','It was hacked');
INSERT INTO "vocabulary" VALUES(29,4,'shrimp','cute aquatic animal with a lot of legs','','');
INSERT INTO "vocabulary" VALUES(30,5,'mountain','tall geological feature - bigger than a hill','','Climbing mountains is a good hobby if you want to keep fit');
INSERT INTO "vocabulary" VALUES(32,10,'TrEe','A green tall plant good for the planet','','There are lots of trees near the river.');
INSERT INTO "vocabulary" VALUES(39,3,'multiple','lots','','');
INSERT INTO "vocabulary" VALUES(40,3,'lots','multiple','','lots and lots and lots');
INSERT INTO "vocabulary" VALUES(41,3,'lots','multpipl','','');
INSERT INTO "vocabulary" VALUES(42,3,'many','lots','','');
INSERT INTO "vocabulary" VALUES(43,3,'yoghury','vreamy food','','');
INSERT INTO "vocabulary" VALUES(44,3,'god','beards and stuff','','');
INSERT INTO "vocabulary" VALUES(45,3,'alarm','bringbring','','');
INSERT INTO "vocabulary" VALUES(46,3,'boat','the boat','','the boat was passig by');
INSERT INTO "vocabulary" VALUES(47,3,'other boat','the other boat','','');
INSERT INTO "vocabulary" VALUES(48,3,'reverse','the other way','','');
INSERT INTO "vocabulary" VALUES(49,3,'darn','mistaake','','');
INSERT INTO "vocabulary" VALUES(50,3,'example','tings that show','','');
INSERT INTO "vocabulary" VALUES(51,3,'examples','many things that show','','');
INSERT INTO "vocabulary" VALUES(52,3,'familiar ','know well','','');
INSERT INTO "vocabulary" VALUES(53,3,'unfamiliar','dont know','','');
INSERT INTO "vocabulary" VALUES(54,3,'success','winning a million dollar feeling','','');
INSERT INTO "vocabulary" VALUES(55,3,'third','its a charm','','');
INSERT INTO "vocabulary" VALUES(56,3,'test','make sure something works','','');
INSERT INTO "vocabulary" VALUES(57,3,'one','the one','','');
INSERT INTO "vocabulary" VALUES(58,3,'two ','the second','','');
INSERT INTO "vocabulary" VALUES(59,3,'bomb','Isreal','','');
INSERT INTO "vocabulary" VALUES(60,3,'hello','yeah','','khkjhjk');
INSERT INTO "vocabulary" VALUES(61,3,'bass','heavy beats','','');
INSERT INTO "vocabulary" VALUES(62,3,'creek','water ery place','','');
INSERT INTO "vocabulary" VALUES(63,3,'shabby','not to hot','','');
INSERT INTO "vocabulary" VALUES(64,3,'trance','state of it','','');
INSERT INTO "vocabulary" VALUES(65,3,'yuck','sick','','');
INSERT INTO "vocabulary" VALUES(66,3,'red','blood','','');
INSERT INTO "vocabulary" VALUES(67,3,'plant pot','hold a plant','','https://youtu.be/oJbfMBROEO0?si=e5E_O7qbJekPrAuZ');
INSERT INTO "vocabulary" VALUES(68,3,'road','long flat thing','','');
INSERT INTO "vocabulary" VALUES(69,3,'soul','the inside','','');
INSERT INTO "vocabulary" VALUES(70,3,'tears','creying','','');
INSERT INTO "vocabulary" VALUES(71,3,'fate','the fates','','');
INSERT INTO "vocabulary" VALUES(72,3,'operations','these are the thingsw we do all the time','','');
INSERT INTO "vocabulary" VALUES(73,3,'videos','things to watch online','','');
INSERT INTO "vocabulary" VALUES(74,3,'lavatory','a room, building, or cubicle containing a toilet or toilets','','he locked himself in the downstairs lavatory');
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
COMMIT;
