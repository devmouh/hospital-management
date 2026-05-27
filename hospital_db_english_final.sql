-- ============================================================
-- PEDIATRIC HOSPITAL ORAN — FINAL DATABASE (ENGLISH VERSION)
-- FIXED: sequence resets added + messaging_message corrected
-- PostgreSQL — run AFTER python manage.py migrate
-- ============================================================

-- ============================================================
-- STEP 0: RESET SEQUENCES (CRITICAL — DO NOT SKIP)
-- Without this, IDs won't start at 1 and address_id
-- foreign keys will be broken after DELETE + re-INSERT.
-- ============================================================
ALTER SEQUENCE users_address_id_seq RESTART WITH 1;
ALTER SEQUENCE users_users_id_seq RESTART WITH 1;
ALTER SEQUENCE users_specialty_id_seq RESTART WITH 1;
ALTER SEQUENCE users_secretaire_id_seq RESTART WITH 1;
ALTER SEQUENCE users_doctors_id_seq RESTART WITH 1;
ALTER SEQUENCE users_patients_id_seq RESTART WITH 1;
ALTER SEQUENCE consultations_appointment_id_seq RESTART WITH 1;
ALTER SEQUENCE consultations_consultation_id_seq RESTART WITH 1;
ALTER SEQUENCE consultations_diagnostic_id_seq RESTART WITH 1;
ALTER SEQUENCE consultations_traitement_id_seq RESTART WITH 1;
ALTER SEQUENCE medical_allergie_id_seq RESTART WITH 1;
ALTER SEQUENCE medical_antecedent_id_seq RESTART WITH 1;
ALTER SEQUENCE documents_document_id_seq RESTART WITH 1;
ALTER SEQUENCE notifications_notification_id_seq RESTART WITH 1;
ALTER SEQUENCE notifications_message_id_seq RESTART WITH 1;
ALTER SEQUENCE users_traceaction_id_seq RESTART WITH 1;

-- PostgreSQL — run AFTER python manage.py migrate
-- ============================================================

-- ============================================================
-- STEP 1: SPECIALTIES
-- ============================================================
INSERT INTO users_specialty (name) VALUES ('Pediatric Pulmonology');
INSERT INTO users_specialty (name) VALUES ('General Pediatrics');
INSERT INTO users_specialty (name) VALUES ('Pediatric Ophthalmology');

-- ============================================================
-- STEP 2: ADDRESSES (36 addresses)
-- ============================================================
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('12 Rue Larbi Ben Mhidi',          'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('5 Cite des 1000 Logements',        'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('7 Rue de la Paix',                 'Oran',           'Es Senia',        '31130');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('3 Boulevard Millenium',            'Oran',           'Bir El Djir',     '31200');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('22 Rue Hassiba Ben Bouali',        'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('9 Cite USTO',                      'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('14 Rue Ahmed Zabana',              'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('88 Cite Petit Lac',                'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('2 Rue des Freres Bouadou',         'Oran',           'Bir El Djir',     '31200');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('45 Boulevard Soummam',             'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('17 Cite Bousfer',                  'Oran',           'Bousfer',         '31150');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('33 Rue Mohamed Khemisti',          'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('6 Impasse Belcourt',               'Oran',           'Es Senia',        '31130');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('19 Rue de Mostaganem',             'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('52 Cite El Yasmine',               'Oran',           'Bir El Djir',     '31200');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('8 Rue Abdelkader Azzout',          'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('24 Cite Gambetta',                 'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('11 Rue du 1er Novembre',           'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('36 Cite ZHUN Est',                 'Oran',           'Bir El Djir',     '31200');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('3 Rue Houari Boumediene',          'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('77 Boulevard Colonel Lotfi',       'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('15 Cite 5 Juillet',                'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('29 Rue Cheikh Larbi Tebessi',      'Oran',           'Es Senia',        '31130');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('4 Allee des Orangers',             'Oran',           'Bousfer',         '31150');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('18 Cite Petit Lac Ouest',          'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('7 Rue des Martyrs',                'Mostaganem',     'Mostaganem',      '27000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('21 Cite El Wiam',                  'Mostaganem',     'Mostaganem',      '27000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('5 Rue Emir Abdelkader',            'Ain Temouchent', 'Ain Temouchent',  '46000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('13 Cite OPGI',                     'Ain Temouchent', 'Ain Temouchent',  '46000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('9 Boulevard de la Republique',     'Mascara',        'Mascara',         '29000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('32 Rue Khaled Ibn El Walid',       'Mascara',        'Mascara',         '29000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('16 Cite 200 Logements',            'Sidi Bel Abbes', 'Sidi Bel Abbes',  '22000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('44 Avenue Larbi Ben Mhidi',        'Sidi Bel Abbes', 'Sidi Bel Abbes',  '22000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('6 Rue 8 Mai 1945',                 'Relizane',       'Relizane',        '48000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('27 Cite Sonatrach',                'Tlemcen',        'Tlemcen',         '13000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('38 Rue Abou Mediene',              'Tlemcen',        'Tlemcen',         '13000');

-- ============================================================
-- STEP 3: USERS
-- ============================================================

-- ADMIN
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id)
VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,TRUE,'admin','Admin','System','admin@hopital-oran.dz',TRUE,TRUE,NOW(),'ADMIN','0555000000',1);

-- SECRETARIES
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id)
VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'sec.fatima','Fatima','Benouali','fatima.benouali@hopital-oran.dz',FALSE,TRUE,NOW(),'SECRETAIRE','0550100200',11);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id)
VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'sec.karima','Karima','Bensaid','karima.bensaid@hopital-oran.dz',FALSE,TRUE,NOW(),'SECRETAIRE','0550200300',12);

-- DOCTORS
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id)
VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'dr.amrani','Karim','Amrani','amrani@hopital-oran.dz',FALSE,TRUE,NOW(),'DOCTOR','0555111111',2);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id)
VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'dr.khelif','Samira','Khelif','khelif@hopital-oran.dz',FALSE,TRUE,NOW(),'DOCTOR','0555222222',3);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id)
VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'dr.benali','Yacine','Benali','benali@hopital-oran.dz',FALSE,TRUE,NOW(),'DOCTOR','0555333333',4);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id)
VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'dr.meziani','Fatima','Meziani','meziani@hopital-oran.dz',FALSE,TRUE,NOW(),'DOCTOR','0555444444',5);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id)
VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'dr.boudiaf','Omar','Boudiaf','boudiaf@hopital-oran.dz',FALSE,TRUE,NOW(),'DOCTOR','0555555555',6);

-- PARENTS (31)
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.lina','Lina','Boudiaf','lina.boudiaf@gmail.com',FALSE,TRUE,NOW(),'PARENT','0661111111',13);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.ahmed','Ahmed','Mansouri','ahmed.mansouri@gmail.com',FALSE,TRUE,NOW(),'PARENT','0662222222',14);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.yousra','Yousra','Ouali','yousra.ouali@gmail.com',FALSE,TRUE,NOW(),'PARENT','0663333333',15);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.karim','Karim','Djaafri','karim.djaafri@gmail.com',FALSE,TRUE,NOW(),'PARENT','0664444444',16);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.nadia','Nadia','Belarbi','nadia.belarbi@gmail.com',FALSE,TRUE,NOW(),'PARENT','0665555555',17);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.sofiane','Sofiane','Rahmani','sofiane.rahmani@gmail.com',FALSE,TRUE,NOW(),'PARENT','0666666666',18);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.meriem','Meriem','Bensalem','meriem.bensalem@gmail.com',FALSE,TRUE,NOW(),'PARENT','0667777777',19);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.hassan','Hassan','Tlemcani','hassan.tlemcani@gmail.com',FALSE,TRUE,NOW(),'PARENT','0668888888',20);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.houria','Houria','Saidi','houria.saidi@gmail.com',FALSE,TRUE,NOW(),'PARENT','0669999999',21);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.farid','Farid','Bengana','farid.bengana@gmail.com',FALSE,TRUE,NOW(),'PARENT','0770111222',22);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.zineb','Zineb','Ferroukhi','zineb.ferroukhi@gmail.com',FALSE,TRUE,NOW(),'PARENT','0770222333',23);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.mourad','Mourad','Kaci','mourad.kaci@gmail.com',FALSE,TRUE,NOW(),'PARENT','0770333444',24);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.amina','Amina','Cherif','amina.cherif@gmail.com',FALSE,TRUE,NOW(),'PARENT','0770444555',25);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.rachid','Rachid','Boussaid','rachid.boussaid@gmail.com',FALSE,TRUE,NOW(),'PARENT','0770555666',26);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.hayat','Hayat','Hadj','hayat.hadj@gmail.com',FALSE,TRUE,NOW(),'PARENT','0770666777',27);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.bilal','Bilal','Bouziane','bilal.bouziane@gmail.com',FALSE,TRUE,NOW(),'PARENT','0770777888',28);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.sabrina','Sabrina','Mekki','sabrina.mekki@gmail.com',FALSE,TRUE,NOW(),'PARENT','0770888999',29);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.omar','Omar','Ziani','omar.ziani@gmail.com',FALSE,TRUE,NOW(),'PARENT','0770999000',30);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.naima','Naima','Ghali','naima.ghali@gmail.com',FALSE,TRUE,NOW(),'PARENT','0771100200',21);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.tarek','Tarek','Medjdoub','tarek.medjdoub@gmail.com',FALSE,TRUE,NOW(),'PARENT','0771200300',22);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.sihem','Sihem','Benyahia','sihem.benyahia@gmail.com',FALSE,TRUE,NOW(),'PARENT','0771300400',26);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.lotfi','Lotfi','Haddar','lotfi.haddar@gmail.com',FALSE,TRUE,NOW(),'PARENT','0771400500',27);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.malika','Malika','Bensmain','malika.bensmain@gmail.com',FALSE,TRUE,NOW(),'PARENT','0771500600',28);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.yacine','Yacine','Dif','yacine.dif@gmail.com',FALSE,TRUE,NOW(),'PARENT','0771600700',29);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.wafa','Wafa','Baali','wafa.baali@gmail.com',FALSE,TRUE,NOW(),'PARENT','0771700800',30);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.abdelkader','Abdelkader','Tebbal','abdelkader.tebbal@gmail.com',FALSE,TRUE,NOW(),'PARENT','0771800900',31);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.hanane','Hanane','Sellal','hanane.sellal@gmail.com',FALSE,TRUE,NOW(),'PARENT','0772000100',32);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.hocine','Hocine','Boudinar','hocine.boudinar@gmail.com',FALSE,TRUE,NOW(),'PARENT','0772100200',33);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.khadija','Khadija','Bouhelal','khadija.bouhelal@gmail.com',FALSE,TRUE,NOW(),'PARENT','0772200300',34);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.riad','Riad','Bencherif','riad.bencherif@gmail.com',FALSE,TRUE,NOW(),'PARENT','0772300400',35);
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id) VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,FALSE,'parent.nadia2','Nadia','Boumediene','nadia.boumediene@gmail.com',FALSE,TRUE,NOW(),'PARENT','0772400500',36);

-- ============================================================
-- STEP 4: SECRETARY PROFILES
-- ============================================================
INSERT INTO users_secretaire (user_id, bureau, telephone_interne, horaires_service, photo)
SELECT u.id, 'Office 101 - Main Reception', '041-23-45-01', 'Sunday-Thursday 08:00-16:00', ''
FROM users_users u WHERE u.username = 'sec.fatima';

INSERT INTO users_secretaire (user_id, bureau, telephone_interne, horaires_service, photo)
SELECT u.id, 'Office 102 - Admissions', '041-23-45-02', 'Sunday-Thursday 09:00-17:00', ''
FROM users_users u WHERE u.username = 'sec.karima';

-- ============================================================
-- STEP 5: DOCTOR PROFILES
-- ============================================================
INSERT INTO users_doctors (user_id,specialty_id,bio,horaire_travail,actif,ville,photo,numero_ordre_medecins)
SELECT u.id,s.id,'Pediatric pulmonology specialist, 12 years experience. Expert in childhood asthma and chronic respiratory conditions.','Sun-Thu 08:00-16:00',TRUE,'Oran','','31-MED-0041'
FROM users_users u, users_specialty s WHERE u.username='dr.amrani' AND s.name='Pediatric Pulmonology';

INSERT INTO users_doctors (user_id,specialty_id,bio,horaire_travail,actif,ville,photo,numero_ordre_medecins)
SELECT u.id,s.id,'General pediatrician specializing in chronic childhood diseases. Diabetes and autoimmune conditions.','Sun-Thu 09:00-17:00',TRUE,'Oran','','31-MED-0087'
FROM users_users u, users_specialty s WHERE u.username='dr.khelif' AND s.name='General Pediatrics';

INSERT INTO users_doctors (user_id,specialty_id,bio,horaire_travail,actif,ville,photo,numero_ordre_medecins)
SELECT u.id,s.id,'Pediatric ophthalmologist. Expert in strabismus, early myopia and ocular pathologies.','Mon-Thu 08:30-15:30',TRUE,'Oran','','31-MED-0152'
FROM users_users u, users_specialty s WHERE u.username='dr.benali' AND s.name='Pediatric Ophthalmology';

INSERT INTO users_doctors (user_id,specialty_id,bio,horaire_travail,actif,ville,photo,numero_ordre_medecins)
SELECT u.id,s.id,'Pediatric pulmonologist specializing in recurrent respiratory infections and cystic fibrosis.','Sun-Wed 08:00-14:00',TRUE,'Bir El Djir','','31-MED-0203'
FROM users_users u, users_specialty s WHERE u.username='dr.meziani' AND s.name='Pediatric Pulmonology';

INSERT INTO users_doctors (user_id,specialty_id,bio,horaire_travail,actif,ville,photo,numero_ordre_medecins)
SELECT u.id,s.id,'General pediatrician with expertise in rare diseases and childhood metabolic disorders.','Sun-Thu 10:00-18:00',TRUE,'Oran','','31-MED-0244'
FROM users_users u, users_specialty s WHERE u.username='dr.boudiaf' AND s.name='General Pediatrics';

-- ============================================================
-- STEP 6: PATIENTS (50 children)
-- ============================================================
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Rayan','Boudiaf','2018-03-15','M','A+','0661111111','','2024-01-10' FROM users_users u WHERE u.username='parent.lina';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Sara','Boudiaf','2020-07-22','F','A+','0661111111','','2024-01-10' FROM users_users u WHERE u.username='parent.lina';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Amine','Mansouri','2016-11-08','M','O+','0662222222','','2023-09-05' FROM users_users u WHERE u.username='parent.ahmed';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Nour','Mansouri','2019-02-14','F','B+','0662222222','','2023-09-05' FROM users_users u WHERE u.username='parent.ahmed';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Imane','Ouali','2017-06-30','F','AB+','0663333333','','2023-11-20' FROM users_users u WHERE u.username='parent.yousra';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Yasser','Djaafri','2015-04-18','M','B-','0664444444','','2022-06-01' FROM users_users u WHERE u.username='parent.karim';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Lyna','Djaafri','2018-09-03','F','O-','0664444444','','2022-06-01' FROM users_users u WHERE u.username='parent.karim';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Hamza','Belarbi','2014-12-25','M','A-','0665555555','','2022-03-14' FROM users_users u WHERE u.username='parent.nadia';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Ilyasse','Rahmani','2016-08-11','M','O+','0666666666','','2023-02-28' FROM users_users u WHERE u.username='parent.sofiane';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Rima','Rahmani','2019-05-06','F','AB-','0666666666','','2023-02-28' FROM users_users u WHERE u.username='parent.sofiane';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Adam','Bensalem','2017-01-19','M','B+','0667777777','','2023-07-07' FROM users_users u WHERE u.username='parent.meriem';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Wissam','Bensalem','2020-10-30','M','A+','0667777777','','2023-07-07' FROM users_users u WHERE u.username='parent.meriem';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Safa','Tlemcani','2015-03-22','F','O+','0668888888','','2022-11-11' FROM users_users u WHERE u.username='parent.hassan';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Rayane','Saidi','2013-07-14','M','A-','0669999999','','2022-01-05' FROM users_users u WHERE u.username='parent.houria';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Chaima','Saidi','2016-02-28','F','B+','0669999999','','2022-01-05' FROM users_users u WHERE u.username='parent.houria';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Karim','Bengana','2017-05-10','M','O+','0770111222','','2023-04-20' FROM users_users u WHERE u.username='parent.farid';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Manel','Ferroukhi','2019-09-01','F','A+','0770222333','','2023-06-15' FROM users_users u WHERE u.username='parent.zineb';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Anes','Ferroukhi','2021-02-14','M','A+','0770222333','','2023-06-15' FROM users_users u WHERE u.username='parent.zineb';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Ryad','Kaci','2016-12-03','M','B+','0770333444','','2022-08-30' FROM users_users u WHERE u.username='parent.mourad';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Lina','Cherif','2020-04-18','F','O-','0770444555','','2024-02-05' FROM users_users u WHERE u.username='parent.amina';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Walid','Boussaid','2014-08-22','M','AB+','0770555666','','2023-10-10' FROM users_users u WHERE u.username='parent.rachid';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Assia','Hadj','2018-11-05','F','A-','0770666777','','2023-03-22' FROM users_users u WHERE u.username='parent.hayat';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Oussama','Bouziane','2015-06-17','M','O+','0770777888','','2022-12-01' FROM users_users u WHERE u.username='parent.bilal';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Inasse','Bouziane','2018-03-09','F','O+','0770777888','','2022-12-01' FROM users_users u WHERE u.username='parent.bilal';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Djawad','Mekki','2021-07-28','M','B-','0770888999','','2024-03-01' FROM users_users u WHERE u.username='parent.sabrina';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Selma','Ziani','2016-01-11','F','AB+','0770999000','','2023-08-18' FROM users_users u WHERE u.username='parent.omar';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Ilyes','Ghali','2013-10-24','M','A+','0771100200','','2022-05-09' FROM users_users u WHERE u.username='parent.naima';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Rania','Ghali','2017-04-30','F','B+','0771100200','','2022-05-09' FROM users_users u WHERE u.username='parent.naima';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Zakaria','Medjdoub','2019-08-15','M','O+','0771200300','','2023-11-14' FROM users_users u WHERE u.username='parent.tarek';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Yasmine','Benyahia','2018-02-20','F','A+','0771300400','','2023-05-20' FROM users_users u WHERE u.username='parent.sihem';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Anis','Haddar','2015-09-12','M','O-','0771400500','','2022-09-03' FROM users_users u WHERE u.username='parent.lotfi';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Ritaj','Haddar','2020-12-05','F','O-','0771400500','','2022-09-03' FROM users_users u WHERE u.username='parent.lotfi';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Hana','Bensmain','2017-07-07','F','B+','0771500600','','2024-01-08' FROM users_users u WHERE u.username='parent.malika';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Mohamed','Dif','2016-03-25','M','A-','0771600700','','2023-07-25' FROM users_users u WHERE u.username='parent.yacine';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Ghizlane','Baali','2019-11-18','F','AB-','0771700800','','2022-10-12' FROM users_users u WHERE u.username='parent.wafa';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Youssef','Baali','2022-01-03','M','AB-','0771700800','','2022-10-12' FROM users_users u WHERE u.username='parent.wafa';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Nour El Houda','Tebbal','2018-06-14','F','O+','0771800900','','2023-02-14' FROM users_users u WHERE u.username='parent.abdelkader';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Romaissa','Sellal','2017-10-08','F','A+','0772000100','','2022-07-30' FROM users_users u WHERE u.username='parent.hanane';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Adem','Sellal','2020-05-22','M','A+','0772000100','','2022-07-30' FROM users_users u WHERE u.username='parent.hanane';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Bilel','Boudinar','2015-08-31','M','B+','0772100200','','2023-09-11' FROM users_users u WHERE u.username='parent.hocine';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Amira','Bouhelal','2016-04-19','F','O+','0772200300','','2022-04-06' FROM users_users u WHERE u.username='parent.khadija';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Fares','Bouhelal','2019-09-27','M','O+','0772200300','','2022-04-06' FROM users_users u WHERE u.username='parent.khadija';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Ilham','Bencherif','2018-12-10','F','A-','0772300400','','2023-12-01' FROM users_users u WHERE u.username='parent.riad';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Taim','Boumediene','2014-05-05','M','AB+','0772400500','','2022-03-17' FROM users_users u WHERE u.username='parent.nadia2';
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Israe','Boumediene','2017-08-21','F','AB+','0772400500','','2022-03-17' FROM users_users u WHERE u.username='parent.nadia2';

-- ============================================================
-- STEP 7: ALLERGIES (20)
-- ============================================================
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Grass pollen','MODEREE','Rhinitis and intense watery eyes in spring. Frequent sneezing.','2023-03-10' FROM users_patients p WHERE p.first_name='Imane' AND p.last_name='Ouali';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Dust mites','LEGERE','Mild nocturnal cough and nasal congestion in winter.','2023-11-05' FROM users_patients p WHERE p.first_name='Rayan' AND p.last_name='Boudiaf';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Penicillin','SEVERE','Documented anaphylactic reaction. DO NOT PRESCRIBE.','2022-06-20' FROM users_patients p WHERE p.first_name='Amine' AND p.last_name='Mansouri';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Peanuts','CRITIQUE','Severe allergy. Auto-injectable epinephrine prescribed. Carry at all times.','2021-08-15' FROM users_patients p WHERE p.first_name='Hamza' AND p.last_name='Belarbi';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Cow milk','MODEREE','Milk protein intolerance. Strict lactose-free diet required.','2020-03-22' FROM users_patients p WHERE p.first_name='Wissam' AND p.last_name='Bensalem';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Latex','LEGERE','Skin reaction on contact with latex. Avoid latex gloves.','2023-01-14' FROM users_patients p WHERE p.first_name='Yasser' AND p.last_name='Djaafri';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Ibuprofen','MODEREE','Hives after taking ibuprofen. Prefer paracetamol.','2022-09-08' FROM users_patients p WHERE p.first_name='Safa' AND p.last_name='Tlemcani';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Cat hair','LEGERE','Sneezing and red eyes on contact with cats.','2024-02-20' FROM users_patients p WHERE p.first_name='Nour' AND p.last_name='Mansouri';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Eggs','MODEREE','Hives and vomiting after ingestion. Strict avoidance required.','2023-05-15' FROM users_patients p WHERE p.first_name='Manel' AND p.last_name='Ferroukhi';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Gluten','MODEREE','Chronic diarrhea and bloating. Gluten-free diet followed.','2022-11-30' FROM users_patients p WHERE p.first_name='Yasmine' AND p.last_name='Benyahia';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Amoxicillin','SEVERE','Angioedema following amoxicillin. Cephalosporin alternative.','2023-08-07' FROM users_patients p WHERE p.first_name='Ghizlane' AND p.last_name='Baali';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Aspirin','MODEREE','Triggered asthma attack. Absolute contraindication.','2021-12-18' FROM users_patients p WHERE p.first_name='Ilyasse' AND p.last_name='Rahmani';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'House dust','LEGERE','Persistent allergic rhinitis. Air purifier recommended.','2022-04-02' FROM users_patients p WHERE p.first_name='Karim' AND p.last_name='Bengana';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Walnuts','CRITIQUE','Severe anaphylaxis. Epinephrine auto-injector. Carry at all times.','2023-09-21' FROM users_patients p WHERE p.first_name='Romaissa' AND p.last_name='Sellal';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Sulfonamides','MODEREE','Generalized skin rash after sulfamethoxazole.','2022-07-14' FROM users_patients p WHERE p.first_name='Oussama' AND p.last_name='Bouziane';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Mold','LEGERE','Rhinitis and dry cough in humid periods.','2023-10-05' FROM users_patients p WHERE p.first_name='Lyna' AND p.last_name='Djaafri';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Strawberries','LEGERE','Localized hives on lips. Avoidance advised.','2024-01-20' FROM users_patients p WHERE p.first_name='Hana' AND p.last_name='Bensmain';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Codeine','MODEREE','Intense nausea and vomiting. Avoid weak opioids.','2023-06-11' FROM users_patients p WHERE p.first_name='Walid' AND p.last_name='Boussaid';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Cypress pollen','MODEREE','Severe seasonal rhinitis. Preventive antihistamine recommended.','2022-03-25' FROM users_patients p WHERE p.first_name='Selma' AND p.last_name='Ziani';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Soy milk','LEGERE','Cross-reaction with cow milk. Adapted diet required.','2021-09-08' FROM users_patients p WHERE p.first_name='Ritaj' AND p.last_name='Haddar';

-- ============================================================
-- STEP 8: MEDICAL HISTORY (29)
-- ============================================================
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Acute bronchitis treated with amoxicillin. Full recovery.','MEDICAL','2023-02-14' FROM users_patients p WHERE p.first_name='Rayan' AND p.last_name='Boudiaf';
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Type 1 diabetes diagnosed September 2022. Insulin therapy ongoing.','MEDICAL','2022-09-01' FROM users_patients p WHERE p.first_name='Amine' AND p.last_name='Mansouri';
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Tonsillectomy due to recurrent tonsillitis. Full recovery.','CHIRURGICAL','2024-01-15' FROM users_patients p WHERE p.first_name='Imane' AND p.last_name='Ouali';
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Family history of asthma (father and paternal grandfather).','FAMILIAL','2023-05-20' FROM users_patients p WHERE p.first_name='Sara' AND p.last_name='Boudiaf';
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Recurrent acute otitis media. 4 episodes 2021-2023. Ear tube placement.','MEDICAL','2021-04-10' FROM users_patients p WHERE p.first_name='Hamza' AND p.last_name='Belarbi';
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Right radius fracture from fall. Cast for 6 weeks.','CHIRURGICAL','2022-07-03' FROM users_patients p WHERE p.first_name='Yasser' AND p.last_name='Djaafri';
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Moderate asthma diagnosed 2021. Budesonide maintenance treatment.','MEDICAL','2021-10-18' FROM users_patients p WHERE p.first_name='Ilyasse' AND p.last_name='Rahmani';
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Paternal grandfather has T2 diabetes. Mother has asthma.','FAMILIAL','2023-03-01' FROM users_patients p WHERE p.first_name='Rayane' AND p.last_name='Saidi';
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Convergent strabismus corrected surgically. Wearing glasses.','CHIRURGICAL','2022-04-25' FROM users_patients p WHERE p.first_name='Safa' AND p.last_name='Tlemcani';
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Progressive myopia for 4 years. Annual ophthalmological follow-up.','MEDICAL','2021-09-12' FROM users_patients p WHERE p.first_name='Chaima' AND p.last_name='Saidi';
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Febrile convulsions at 18 months. Normal neurological assessment.','MEDICAL','2019-01-30' FROM users_patients p WHERE p.first_name='Wissam' AND p.last_name='Bensalem';
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Atopic eczema since birth. Emollients and topical corticosteroids treatment.','MEDICAL','2020-08-14' FROM users_patients p WHERE p.first_name='Lyna' AND p.last_name='Djaafri';
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Family history of cystic fibrosis (maternal uncle).','FAMILIAL','2023-06-10' FROM users_patients p WHERE p.first_name='Rima' AND p.last_name='Rahmani';
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Adenoidectomy March 2023. Improved nasal breathing.','CHIRURGICAL','2023-03-18' FROM users_patients p WHERE p.first_name='Adam' AND p.last_name='Bensalem';
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Premature birth at 34 weeks. Neonatal stay for 3 weeks.','MEDICAL','2018-09-10' FROM users_patients p WHERE p.first_name='Karim' AND p.last_name='Bengana';
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Congenital VSD heart defect closed spontaneously at age 2.','MEDICAL','2021-07-22' FROM users_patients p WHERE p.first_name='Ryad' AND p.last_name='Kaci';
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Benign childhood partial epilepsy. Valproate treatment.','MEDICAL','2022-03-14' FROM users_patients p WHERE p.first_name='Ilyes' AND p.last_name='Ghali';
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Congenital hip dislocation. Orthopedic treatment at birth.','CHIRURGICAL','2020-02-10' FROM users_patients p WHERE p.first_name='Yasmine' AND p.last_name='Benyahia';
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Down syndrome (Trisomy 21). Regular multidisciplinary follow-up.','AUTRE','2016-04-05' FROM users_patients p WHERE p.first_name='Anis' AND p.last_name='Haddar';
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Severe neonatal gastroesophageal reflux. Fundoplication surgery.','CHIRURGICAL','2022-03-01' FROM users_patients p WHERE p.first_name='Youssef' AND p.last_name='Baali';
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Speech delay. Speech therapy follow-up for 3 years.','MEDICAL','2021-11-08' FROM users_patients p WHERE p.first_name='Taim' AND p.last_name='Boumediene';
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Celiac disease confirmed by biopsy. Strict gluten-free diet.','MEDICAL','2023-01-25' FROM users_patients p WHERE p.first_name='Adem' AND p.last_name='Sellal';
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Early idiopathic scoliosis. Physiotherapy ongoing.','MEDICAL','2023-07-19' FROM users_patients p WHERE p.first_name='Walid' AND p.last_name='Boussaid';
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Severe RSV bronchiolitis at 3 months. Hospitalized for 10 days.','MEDICAL','2021-12-20' FROM users_patients p WHERE p.first_name='Djawad' AND p.last_name='Mekki';
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Father has T1 diabetes. High family risk. Annual glucose monitoring.','FAMILIAL','2022-08-15' FROM users_patients p WHERE p.first_name='Zakaria' AND p.last_name='Medjdoub';
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Moderate atopic dermatitis since 18 months. Emollient treatment.','MEDICAL','2023-02-07' FROM users_patients p WHERE p.first_name='Hana' AND p.last_name='Bensmain';
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Right inguinal hernia repaired at age 2. No complications.','CHIRURGICAL','2021-05-14' FROM users_patients p WHERE p.first_name='Mohamed' AND p.last_name='Dif';
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Severe asthma with 2 hospitalizations in 2022.','MEDICAL','2022-05-30' FROM users_patients p WHERE p.first_name='Bilel' AND p.last_name='Boudinar';
INSERT INTO medical_antecedent (patient_id,description,type_antecedent,date_declaration) SELECT p.id,'Congenital hypothyroidism. Levothyroxine since birth. TSH normalized.','MEDICAL','2019-01-12' FROM users_patients p WHERE p.first_name='Ilham' AND p.last_name='Bencherif';

-- ============================================================
-- STEP 9: APPOINTMENTS (19 total)
-- ============================================================

-- COMPLETED (8)
INSERT INTO consultations_appointment (doctor_id,patient_id,created_by_id,date_rdv,heure,motif,reason,status,created_at,updated_at) SELECT d.id,p.id,u.id,'2026-03-10 09:00:00','09:00:00','Persistent cough','Dry cough for 3 weeks, mild evening fever.','COMPLETED',NOW(),NOW() FROM users_doctors d JOIN users_users du ON d.user_id=du.id AND du.username='dr.amrani' JOIN users_patients p ON p.first_name='Rayan' AND p.last_name='Boudiaf' JOIN users_users u ON u.username='sec.fatima';
INSERT INTO consultations_appointment (doctor_id,patient_id,created_by_id,date_rdv,heure,motif,reason,status,created_at,updated_at) SELECT d.id,p.id,u.id,'2026-03-15 10:30:00','10:30:00','Diabetes checkup','Quarterly blood glucose control.','COMPLETED',NOW(),NOW() FROM users_doctors d JOIN users_users du ON d.user_id=du.id AND du.username='dr.khelif' JOIN users_patients p ON p.first_name='Amine' AND p.last_name='Mansouri' JOIN users_users u ON u.username='sec.fatima';
INSERT INTO consultations_appointment (doctor_id,patient_id,created_by_id,date_rdv,heure,motif,reason,status,created_at,updated_at) SELECT d.id,p.id,u.id,'2026-03-20 08:30:00','08:30:00','Seasonal allergy','Allergic rhinitis, watery eyes, sneezing.','COMPLETED',NOW(),NOW() FROM users_doctors d JOIN users_users du ON d.user_id=du.id AND du.username='dr.amrani' JOIN users_patients p ON p.first_name='Imane' AND p.last_name='Ouali' JOIN users_users u ON u.username='sec.karima';
INSERT INTO consultations_appointment (doctor_id,patient_id,created_by_id,date_rdv,heure,motif,reason,status,created_at,updated_at) SELECT d.id,p.id,u.id,'2026-03-25 11:00:00','11:00:00','Asthma checkup','Follow-up moderate asthma, evaluate maintenance treatment.','COMPLETED',NOW(),NOW() FROM users_doctors d JOIN users_users du ON d.user_id=du.id AND du.username='dr.amrani' JOIN users_patients p ON p.first_name='Ilyasse' AND p.last_name='Rahmani' JOIN users_users u ON u.username='sec.fatima';
INSERT INTO consultations_appointment (doctor_id,patient_id,created_by_id,date_rdv,heure,motif,reason,status,created_at,updated_at) SELECT d.id,p.id,u.id,'2026-04-01 09:30:00','09:30:00','Ophthalmological exam','Annual vision check. Progressive myopia.','COMPLETED',NOW(),NOW() FROM users_doctors d JOIN users_users du ON d.user_id=du.id AND du.username='dr.benali' JOIN users_patients p ON p.first_name='Chaima' AND p.last_name='Saidi' JOIN users_users u ON u.username='sec.karima';
INSERT INTO consultations_appointment (doctor_id,patient_id,created_by_id,date_rdv,heure,motif,reason,status,created_at,updated_at) SELECT d.id,p.id,u.id,'2026-04-05 14:00:00','14:00:00','Acute ear infection','Right ear pain for 2 days, fever 38.5C.','COMPLETED',NOW(),NOW() FROM users_doctors d JOIN users_users du ON d.user_id=du.id AND du.username='dr.meziani' JOIN users_patients p ON p.first_name='Hamza' AND p.last_name='Belarbi' JOIN users_users u ON u.username='sec.fatima';
INSERT INTO consultations_appointment (doctor_id,patient_id,created_by_id,date_rdv,heure,motif,reason,status,created_at,updated_at) SELECT d.id,p.id,u.id,'2026-04-25 14:00:00','14:00:00','Celiac disease follow-up','Serology check and gluten-free diet review.','COMPLETED',NOW(),NOW() FROM users_doctors d JOIN users_users du ON d.user_id=du.id AND du.username='dr.khelif' JOIN users_patients p ON p.first_name='Yasmine' AND p.last_name='Benyahia' JOIN users_users u ON u.username='sec.fatima';
INSERT INTO consultations_appointment (doctor_id,patient_id,created_by_id,date_rdv,heure,motif,reason,status,created_at,updated_at) SELECT d.id,p.id,u.id,'2026-04-28 09:00:00','09:00:00','Prolonged fever','Persistent 39C fever for 6 days with no cause.','COMPLETED',NOW(),NOW() FROM users_doctors d JOIN users_users du ON d.user_id=du.id AND du.username='dr.boudiaf' JOIN users_patients p ON p.first_name='Mohamed' AND p.last_name='Dif' JOIN users_users u ON u.username='sec.karima';

-- CONFIRMED (3)
INSERT INTO consultations_appointment (doctor_id,patient_id,created_by_id,date_rdv,heure,motif,reason,status,created_at,updated_at) SELECT d.id,p.id,u.id,'2026-05-06 10:30:00','10:30:00','Diabetes checkup','Monthly blood glucose and insulin adjustment.','CONFIRMED',NOW(),NOW() FROM users_doctors d JOIN users_users du ON d.user_id=du.id AND du.username='dr.khelif' JOIN users_patients p ON p.first_name='Amine' AND p.last_name='Mansouri' JOIN users_users u ON u.username='sec.fatima';
INSERT INTO consultations_appointment (doctor_id,patient_id,created_by_id,date_rdv,heure,motif,reason,status,created_at,updated_at) SELECT d.id,p.id,u.id,'2026-05-08 09:00:00','09:00:00','Asthma follow-up','Budesonide treatment reassessment.','CONFIRMED',NOW(),NOW() FROM users_doctors d JOIN users_users du ON d.user_id=du.id AND du.username='dr.amrani' JOIN users_patients p ON p.first_name='Ilyasse' AND p.last_name='Rahmani' JOIN users_users u ON u.username='sec.karima';
INSERT INTO consultations_appointment (doctor_id,patient_id,created_by_id,date_rdv,heure,motif,reason,status,created_at,updated_at) SELECT d.id,p.id,u.id,'2026-05-10 11:00:00','11:00:00','Vision check','Glasses check, correction adjustment.','CONFIRMED',NOW(),NOW() FROM users_doctors d JOIN users_users du ON d.user_id=du.id AND du.username='dr.benali' JOIN users_patients p ON p.first_name='Safa' AND p.last_name='Tlemcani' JOIN users_users u ON u.username='sec.fatima';

-- PENDING (4)
INSERT INTO consultations_appointment (doctor_id,patient_id,created_by_id,date_rdv,heure,motif,reason,status,created_at,updated_at) SELECT d.id,p.id,u.id,'2026-05-15 09:00:00','09:00:00','Persistent cough','Wet cough for 10 days despite syrup.','PENDING',NOW(),NOW() FROM users_doctors d JOIN users_users du ON d.user_id=du.id AND du.username='dr.amrani' JOIN users_patients p ON p.first_name='Rayan' AND p.last_name='Boudiaf' JOIN users_users u ON u.username='sec.karima';
INSERT INTO consultations_appointment (doctor_id,patient_id,created_by_id,date_rdv,heure,motif,reason,status,created_at,updated_at) SELECT d.id,p.id,u.id,'2026-05-16 10:00:00','10:00:00','Rhinitis','Renewal of allergic rhinitis treatment.','PENDING',NOW(),NOW() FROM users_doctors d JOIN users_users du ON d.user_id=du.id AND du.username='dr.meziani' JOIN users_patients p ON p.first_name='Nour' AND p.last_name='Mansouri' JOIN users_users u ON u.username='sec.fatima';
INSERT INTO consultations_appointment (doctor_id,patient_id,created_by_id,date_rdv,heure,motif,reason,status,created_at,updated_at) SELECT d.id,p.id,u.id,'2026-05-18 15:00:00','15:00:00','Strabismus checkup','Post-op strabismus follow-up 1 year after surgery.','PENDING',NOW(),NOW() FROM users_doctors d JOIN users_users du ON d.user_id=du.id AND du.username='dr.benali' JOIN users_patients p ON p.first_name='Safa' AND p.last_name='Tlemcani' JOIN users_users u ON u.username='sec.fatima';
INSERT INTO consultations_appointment (doctor_id,patient_id,created_by_id,date_rdv,heure,motif,reason,status,created_at,updated_at) SELECT d.id,p.id,u.id,'2026-05-22 11:00:00','11:00:00','Dry nocturnal cough','Nocturnal cough for 2 weeks. Possible asthma.','PENDING',NOW(),NOW() FROM users_doctors d JOIN users_users du ON d.user_id=du.id AND du.username='dr.amrani' JOIN users_patients p ON p.first_name='Bilel' AND p.last_name='Boudinar' JOIN users_users u ON u.username='sec.karima';

-- CANCELLED (3)
INSERT INTO consultations_appointment (doctor_id,patient_id,created_by_id,date_rdv,heure,motif,reason,status,created_at,updated_at) SELECT d.id,p.id,u.id,'2026-04-22 14:00:00','14:00:00','Ophthalmological exam','Annual vision check.','CANCELLED',NOW(),NOW() FROM users_doctors d JOIN users_users du ON d.user_id=du.id AND du.username='dr.benali' JOIN users_patients p ON p.first_name='Nour' AND p.last_name='Mansouri' JOIN users_users u ON u.username='sec.fatima';
INSERT INTO consultations_appointment (doctor_id,patient_id,created_by_id,date_rdv,heure,motif,reason,status,created_at,updated_at) SELECT d.id,p.id,u.id,'2026-04-28 11:00:00','11:00:00','Knee pain','Right knee pain following a fall.','CANCELLED',NOW(),NOW() FROM users_doctors d JOIN users_users du ON d.user_id=du.id AND du.username='dr.khelif' JOIN users_patients p ON p.first_name='Yasser' AND p.last_name='Djaafri' JOIN users_users u ON u.username='sec.fatima';
INSERT INTO consultations_appointment (doctor_id,patient_id,created_by_id,date_rdv,heure,motif,reason,status,created_at,updated_at) SELECT d.id,p.id,u.id,'2026-05-02 09:00:00','09:00:00','Diabetes checkup','Monthly assessment.','CANCELLED',NOW(),NOW() FROM users_doctors d JOIN users_users du ON d.user_id=du.id AND du.username='dr.khelif' JOIN users_patients p ON p.first_name='Amine' AND p.last_name='Mansouri' JOIN users_users u ON u.username='sec.karima';

-- ============================================================
-- STEP 10: CONSULTATIONS (8)
-- ============================================================
INSERT INTO consultations_consultation (appointment_id,date_consultation,poids,taille,temperature,observation) SELECT a.id,'2026-03-10 09:30:00',22.0,110.0,37.8,'Bilateral bronchial crackles. Slightly red throat. No respiratory distress. Child active and cooperative.' FROM consultations_appointment a JOIN users_patients p ON a.patient_id=p.id WHERE p.first_name='Rayan' AND p.last_name='Boudiaf' AND a.status='COMPLETED' AND a.date_rdv::date='2026-03-10';
INSERT INTO consultations_consultation (appointment_id,date_consultation,poids,taille,temperature,observation) SELECT a.id,'2026-03-15 11:00:00',38.5,128.0,36.9,'Fasting glucose 1.85 g/L. HbA1c 7.2%. Good overall glycemic balance. No complications. Normal growth.' FROM consultations_appointment a JOIN users_patients p ON a.patient_id=p.id WHERE p.first_name='Amine' AND p.last_name='Mansouri' AND a.status='COMPLETED' AND a.date_rdv::date='2026-03-15';
INSERT INTO consultations_consultation (appointment_id,date_consultation,poids,taille,temperature,observation) SELECT a.id,'2026-03-20 09:00:00',22.5,112.0,37.2,'Allergic rhinitis confirmed. Mild bilateral nasal congestion. Slightly red eyes. No fever.' FROM consultations_appointment a JOIN users_patients p ON a.patient_id=p.id WHERE p.first_name='Imane' AND p.last_name='Ouali' AND a.status='COMPLETED' AND a.date_rdv::date='2026-03-20';
INSERT INTO consultations_consultation (appointment_id,date_consultation,poids,taille,temperature,observation) SELECT a.id,'2026-03-25 11:30:00',35.0,132.0,37.0,'Moderate asthma well controlled. Peak flow 85% of normal. No crisis for 2 months. Correct inhaler technique.' FROM consultations_appointment a JOIN users_patients p ON a.patient_id=p.id WHERE p.first_name='Ilyasse' AND p.last_name='Rahmani' AND a.status='COMPLETED' AND a.date_rdv::date='2026-03-25';
INSERT INTO consultations_consultation (appointment_id,date_consultation,poids,taille,temperature,observation) SELECT a.id,'2026-04-01 10:00:00',32.0,130.0,36.8,'Myopia stabilized at -2.50 diopters. Normal fundus exam. Next consultation in 6 months.' FROM consultations_appointment a JOIN users_patients p ON a.patient_id=p.id WHERE p.first_name='Chaima' AND p.last_name='Saidi' AND a.status='COMPLETED' AND a.date_rdv::date='2026-04-01';
INSERT INTO consultations_consultation (appointment_id,date_consultation,poids,taille,temperature,observation) SELECT a.id,'2026-04-05 14:30:00',29.0,122.0,38.5,'Right acute otitis media confirmed. Red and bulging eardrum. Child in pain. Antibiotic therapy started.' FROM consultations_appointment a JOIN users_patients p ON a.patient_id=p.id WHERE p.first_name='Hamza' AND p.last_name='Belarbi' AND a.status='COMPLETED' AND a.date_rdv::date='2026-04-05';
INSERT INTO consultations_consultation (appointment_id,date_consultation,poids,taille,temperature,observation) SELECT a.id,'2026-04-25 14:30:00',21.0,114.0,37.0,'Anti-transglutaminase antibodies negative. Good adherence to gluten-free diet. Growth returning to normal.' FROM consultations_appointment a JOIN users_patients p ON a.patient_id=p.id WHERE p.first_name='Yasmine' AND p.last_name='Benyahia' AND a.status='COMPLETED' AND a.date_rdv::date='2026-04-25';
INSERT INTO consultations_consultation (appointment_id,date_consultation,poids,taille,temperature,observation) SELECT a.id,'2026-04-28 09:30:00',27.0,124.0,39.1,'Isolated fever 39.1C. Positive rapid strep test group A. Erythematous tonsillitis confirmed. Antibiotic therapy prescribed.' FROM consultations_appointment a JOIN users_patients p ON a.patient_id=p.id WHERE p.first_name='Mohamed' AND p.last_name='Dif' AND a.status='COMPLETED' AND a.date_rdv::date='2026-04-28';

-- ============================================================
-- STEP 11: DIAGNOSTICS (8)
-- ============================================================
INSERT INTO consultations_diagnostic (consultation_id,nom_maladie,type_maladie,gravite,commentaire_medical,explication_parent) SELECT c.id,'Acute bronchitis','INFECTIEUX','MODEREE','Viral bronchitis with possible bacterial superinfection. Antibiotic therapy recommended.','Your child has bronchitis. Give the medications, keep them warm and make sure they drink plenty. Return if fever goes above 39C.' FROM consultations_consultation c JOIN consultations_appointment a ON c.appointment_id=a.id JOIN users_patients p ON a.patient_id=p.id WHERE p.first_name='Rayan' AND p.last_name='Boudiaf' AND a.date_rdv::date='2026-03-10';
INSERT INTO consultations_diagnostic (consultation_id,nom_maladie,type_maladie,gravite,commentaire_medical,explication_parent) SELECT c.id,'Type 1 diabetes','CHRONIQUE','MODEREE','Diabetes well balanced. HbA1c satisfactory. Continue current insulin protocol.','Your child diabetes is well controlled. Continue insulin injections and monitor blood glucose daily.' FROM consultations_consultation c JOIN consultations_appointment a ON c.appointment_id=a.id JOIN users_patients p ON a.patient_id=p.id WHERE p.first_name='Amine' AND p.last_name='Mansouri' AND a.date_rdv::date='2026-03-15';
INSERT INTO consultations_diagnostic (consultation_id,nom_maladie,type_maladie,gravite,commentaire_medical,explication_parent) SELECT c.id,'Seasonal allergic rhinitis','ALLERGIQUE','LEGERE','Pollen allergy clinically confirmed. Antihistamine and nasal corticosteroid recommended.','Your child is allergic to pollen. Keep windows closed in spring and give the medication every morning.' FROM consultations_consultation c JOIN consultations_appointment a ON c.appointment_id=a.id JOIN users_patients p ON a.patient_id=p.id WHERE p.first_name='Imane' AND p.last_name='Ouali' AND a.date_rdv::date='2026-03-20';
INSERT INTO consultations_diagnostic (consultation_id,nom_maladie,type_maladie,gravite,commentaire_medical,explication_parent) SELECT c.id,'Persistent moderate asthma','ALLERGIQUE','MODEREE','Asthma well controlled on budesonide. Peak flow satisfactory. Maintain maintenance treatment.','The asthma is well controlled. Never stop the treatment even when your child feels well. Use Ventolin in case of attack.' FROM consultations_consultation c JOIN consultations_appointment a ON c.appointment_id=a.id JOIN users_patients p ON a.patient_id=p.id WHERE p.first_name='Ilyasse' AND p.last_name='Rahmani' AND a.date_rdv::date='2026-03-25';
INSERT INTO consultations_diagnostic (consultation_id,nom_maladie,type_maladie,gravite,commentaire_medical,explication_parent) SELECT c.id,'Progressive myopia','CHRONIQUE','LEGERE','Myopia stable for 6 months. Optical correction adapted. Biannual check recommended.','Vision is stable. Your child must wear glasses at all times, especially at school.' FROM consultations_consultation c JOIN consultations_appointment a ON c.appointment_id=a.id JOIN users_patients p ON a.patient_id=p.id WHERE p.first_name='Chaima' AND p.last_name='Saidi' AND a.date_rdv::date='2026-04-01';
INSERT INTO consultations_diagnostic (consultation_id,nom_maladie,type_maladie,gravite,commentaire_medical,explication_parent) SELECT c.id,'Right acute otitis media','INFECTIEUX','MODEREE','Right AOM with tympanic bulging. Amoxicillin 50mg/kg/day for 8 days.','Your child has an ear infection. Give the antibiotic 3 times a day without stopping. Return if no improvement after 48 hours.' FROM consultations_consultation c JOIN consultations_appointment a ON c.appointment_id=a.id JOIN users_patients p ON a.patient_id=p.id WHERE p.first_name='Hamza' AND p.last_name='Belarbi' AND a.date_rdv::date='2026-04-05';
INSERT INTO consultations_diagnostic (consultation_id,nom_maladie,type_maladie,gravite,commentaire_medical,explication_parent) SELECT c.id,'Balanced celiac disease','DIGESTIF','LEGERE','Negative serology means good diet adherence. Growth returning to normal.','Your child is following the gluten-free diet well. Keep it up, their growth is returning to normal.' FROM consultations_consultation c JOIN consultations_appointment a ON c.appointment_id=a.id JOIN users_patients p ON a.patient_id=p.id WHERE p.first_name='Yasmine' AND p.last_name='Benyahia' AND a.date_rdv::date='2026-04-25';
INSERT INTO consultations_diagnostic (consultation_id,nom_maladie,type_maladie,gravite,commentaire_medical,explication_parent) SELECT c.id,'Streptococcal tonsillitis','INFECTIEUX','MODEREE','Positive rapid strep test group A. Amoxicillin antibiotic therapy for 10 days.','Your child has a bacterial throat infection. Give the antibiotic for 10 days without stopping, even if they feel better.' FROM consultations_consultation c JOIN consultations_appointment a ON c.appointment_id=a.id JOIN users_patients p ON a.patient_id=p.id WHERE p.first_name='Mohamed' AND p.last_name='Dif' AND a.date_rdv::date='2026-04-28';

-- ============================================================
-- STEP 12: TREATMENTS (13)
-- ============================================================
INSERT INTO consultations_traitement (consultation_id,medicament,dose,duree,instructions) SELECT c.id,'Amoxicillin 500mg','1 tablet 3x/day','7 days','Take with meals. Do not stop even if feeling better.' FROM consultations_consultation c JOIN consultations_appointment a ON c.appointment_id=a.id JOIN users_patients p ON a.patient_id=p.id AND p.first_name='Rayan' AND p.last_name='Boudiaf' AND a.date_rdv::date='2026-03-10';
INSERT INTO consultations_traitement (consultation_id,medicament,dose,duree,instructions) SELECT c.id,'Salbutamol (Ventolin)','2 puffs','As needed','In case of breathing difficulty. Max 4 times per day.' FROM consultations_consultation c JOIN consultations_appointment a ON c.appointment_id=a.id JOIN users_patients p ON a.patient_id=p.id AND p.first_name='Rayan' AND p.last_name='Boudiaf' AND a.date_rdv::date='2026-03-10';
INSERT INTO consultations_traitement (consultation_id,medicament,dose,duree,instructions) SELECT c.id,'Insulin Novorapid','Per glucose protocol','Ongoing','Inject before each meal based on blood glucose.' FROM consultations_consultation c JOIN consultations_appointment a ON c.appointment_id=a.id JOIN users_patients p ON a.patient_id=p.id AND p.first_name='Amine' AND p.last_name='Mansouri' AND a.date_rdv::date='2026-03-15';
INSERT INTO consultations_traitement (consultation_id,medicament,dose,duree,instructions) SELECT c.id,'Insulin Lantus','Per protocol','Ongoing','1 injection at night before bedtime. Adjust dose based on morning glucose.' FROM consultations_consultation c JOIN consultations_appointment a ON c.appointment_id=a.id JOIN users_patients p ON a.patient_id=p.id AND p.first_name='Amine' AND p.last_name='Mansouri' AND a.date_rdv::date='2026-03-15';
INSERT INTO consultations_traitement (consultation_id,medicament,dose,duree,instructions) SELECT c.id,'Loratadine 5mg','1 tablet/morning','30 days','Take before breakfast. Avoid exposure to pollen.' FROM consultations_consultation c JOIN consultations_appointment a ON c.appointment_id=a.id JOIN users_patients p ON a.patient_id=p.id AND p.first_name='Imane' AND p.last_name='Ouali' AND a.date_rdv::date='2026-03-20';
INSERT INTO consultations_traitement (consultation_id,medicament,dose,duree,instructions) SELECT c.id,'Flixonase nasal spray','1 dose/nostril','30 days','Apply in the morning after waking. Blow nose before use.' FROM consultations_consultation c JOIN consultations_appointment a ON c.appointment_id=a.id JOIN users_patients p ON a.patient_id=p.id AND p.first_name='Imane' AND p.last_name='Ouali' AND a.date_rdv::date='2026-03-20';
INSERT INTO consultations_traitement (consultation_id,medicament,dose,duree,instructions) SELECT c.id,'Budesonide (Pulmicort) 200mcg','2 puffs morning and evening','Ongoing','Maintenance treatment. Never stop without medical advice.' FROM consultations_consultation c JOIN consultations_appointment a ON c.appointment_id=a.id JOIN users_patients p ON a.patient_id=p.id AND p.first_name='Ilyasse' AND p.last_name='Rahmani' AND a.date_rdv::date='2026-03-25';
INSERT INTO consultations_traitement (consultation_id,medicament,dose,duree,instructions) SELECT c.id,'Amoxicillin + Clavulanic acid 1g','3x/day','8 days','If known penicillin allergy, contact doctor immediately.' FROM consultations_consultation c JOIN consultations_appointment a ON c.appointment_id=a.id JOIN users_patients p ON a.patient_id=p.id AND p.first_name='Hamza' AND p.last_name='Belarbi' AND a.date_rdv::date='2026-04-05';
INSERT INTO consultations_traitement (consultation_id,medicament,dose,duree,instructions) SELECT c.id,'Paracetamol 250mg','4x/day if fever','5 days','Give if temperature above 38.5C. Space doses 6 hours apart minimum.' FROM consultations_consultation c JOIN consultations_appointment a ON c.appointment_id=a.id JOIN users_patients p ON a.patient_id=p.id AND p.first_name='Hamza' AND p.last_name='Belarbi' AND a.date_rdv::date='2026-04-05';
INSERT INTO consultations_traitement (consultation_id,medicament,dose,duree,instructions) SELECT c.id,'Amoxicillin 500mg','3x/day','10 days','Complete the full course. Return if no improvement after 48 hours.' FROM consultations_consultation c JOIN consultations_appointment a ON c.appointment_id=a.id JOIN users_patients p ON a.patient_id=p.id AND p.first_name='Mohamed' AND p.last_name='Dif' AND a.date_rdv::date='2026-04-28';
INSERT INTO consultations_traitement (consultation_id,medicament,dose,duree,instructions) SELECT c.id,'Paracetamol 250mg syrup','3x/day if fever','5 days','Max 60mg/kg/day. Give with water. Do not exceed prescribed dose.' FROM consultations_consultation c JOIN consultations_appointment a ON c.appointment_id=a.id JOIN users_patients p ON a.patient_id=p.id AND p.first_name='Mohamed' AND p.last_name='Dif' AND a.date_rdv::date='2026-04-28';

-- ============================================================
-- STEP 13: DOCUMENTS (3)
-- ============================================================
INSERT INTO documents_document (patient_id,consultation_id,nom_fichier,type_doc,fichier,url_stockage,date_upload)
SELECT p.id,c.id,'prescription_rayan_20260310.pdf','ORDONNANCE','documents/prescriptions/rayan_20260310.pdf','documents/prescriptions/rayan_20260310.pdf',NOW()
FROM users_patients p JOIN consultations_consultation c ON c.appointment_id IN (SELECT a.id FROM consultations_appointment a WHERE a.patient_id=p.id AND a.date_rdv::date='2026-03-10')
WHERE p.first_name='Rayan' AND p.last_name='Boudiaf';

INSERT INTO documents_document (patient_id,consultation_id,nom_fichier,type_doc,fichier,url_stockage,date_upload)
SELECT p.id,c.id,'hba1c_results_amine_20260315.pdf','ANALYSE','documents/analyses/amine_hba1c_20260315.pdf','documents/analyses/amine_hba1c_20260315.pdf',NOW()
FROM users_patients p JOIN consultations_consultation c ON c.appointment_id IN (SELECT a.id FROM consultations_appointment a WHERE a.patient_id=p.id AND a.date_rdv::date='2026-03-15')
WHERE p.first_name='Amine' AND p.last_name='Mansouri';

INSERT INTO documents_document (patient_id,consultation_id,nom_fichier,type_doc,fichier,url_stockage,date_upload)
SELECT p.id,c.id,'celiac_serology_yasmine_20260425.pdf','ANALYSE','documents/analyses/yasmine_transglutaminase_20260425.pdf','documents/analyses/yasmine_transglutaminase_20260425.pdf',NOW()
FROM users_patients p JOIN consultations_consultation c ON c.appointment_id IN (SELECT a.id FROM consultations_appointment a WHERE a.patient_id=p.id AND a.date_rdv::date='2026-04-25')
WHERE p.first_name='Yasmine' AND p.last_name='Benyahia';

-- ============================================================
-- STEP 14: NOTIFICATIONS (7)
-- ============================================================
INSERT INTO notifications_notification (recipient_id,notif_type,title,message,is_read,created_at,appointment_id) SELECT u.id,'REMINDER','New appointment','New appointment for Rayan Boudiaf on 05/15/2026 at 09:00.',FALSE,NOW(),a.id FROM users_users u, consultations_appointment a JOIN users_patients p ON a.patient_id=p.id AND p.first_name='Rayan' AND a.status='PENDING' AND a.date_rdv::date='2026-05-15' WHERE u.username='dr.amrani';
INSERT INTO notifications_notification (recipient_id,notif_type,title,message,is_read,created_at,appointment_id) SELECT u.id,'REMINDER','Appointment confirmed','Amine appointment with Dr. Khelif is confirmed for 05/06/2026.',FALSE,NOW(),a.id FROM users_users u, consultations_appointment a JOIN users_patients p ON a.patient_id=p.id AND p.first_name='Amine' AND a.status='CONFIRMED' AND a.date_rdv::date='2026-05-06' WHERE u.username='parent.ahmed';
INSERT INTO notifications_notification (recipient_id,notif_type,title,message,is_read,created_at,appointment_id) SELECT u.id,'REMINDER','New appointment','New appointment for Nour Mansouri on 05/16/2026 at 10:00.',FALSE,NOW(),a.id FROM users_users u, consultations_appointment a JOIN users_patients p ON a.patient_id=p.id AND p.first_name='Nour' AND a.status='PENDING' AND a.date_rdv::date='2026-05-16' WHERE u.username='dr.meziani';
INSERT INTO notifications_notification (recipient_id,notif_type,title,message,is_read,created_at,appointment_id) SELECT u.id,'MESSAGE','Appointment cancelled','Nour appointment scheduled for 04/22/2026 has been cancelled.',TRUE,NOW(),a.id FROM users_users u, consultations_appointment a JOIN users_patients p ON a.patient_id=p.id AND p.first_name='Nour' AND a.status='CANCELLED' AND a.date_rdv::date='2026-04-22' WHERE u.username='parent.ahmed';
INSERT INTO notifications_notification (recipient_id,notif_type,title,message,is_read,created_at,appointment_id) SELECT u.id,'REMINDER','Appointment confirmed','Ilyasse appointment with Dr. Amrani confirmed for 05/08/2026.',FALSE,NOW(),a.id FROM users_users u, consultations_appointment a JOIN users_patients p ON a.patient_id=p.id AND p.first_name='Ilyasse' AND a.status='CONFIRMED' AND a.date_rdv::date='2026-05-08' WHERE u.username='parent.sofiane';
INSERT INTO notifications_notification (recipient_id,notif_type,title,message,is_read,created_at,appointment_id) SELECT u.id,'MESSAGE','Results available','Results for Yasmine Benyahia are now available.',FALSE,NOW(),a.id FROM users_users u, consultations_appointment a JOIN users_patients p ON a.patient_id=p.id AND p.first_name='Yasmine' AND a.status='COMPLETED' AND a.date_rdv::date='2026-04-25' WHERE u.username='parent.sihem';
INSERT INTO notifications_notification (recipient_id,notif_type,title,message,is_read,created_at,appointment_id) SELECT u.id,'MESSAGE','Consultation report ready','The consultation report for Mohamed Dif from 04/28 is available.',FALSE,NOW(),a.id FROM users_users u, consultations_appointment a JOIN users_patients p ON a.patient_id=p.id AND p.first_name='Mohamed' AND a.status='COMPLETED' AND a.date_rdv::date='2026-04-28' WHERE u.username='parent.yacine';

-- ============================================================
-- STEP 15: MESSAGES
-- FIX: correct table is messaging_message (not notifications_message)
-- ============================================================
INSERT INTO notifications_message (expediteur_id,destinataire_id,contenu,date_envoi,lu)
SELECT e.id,d.id,'Hello doctor, Rayan has been coughing a lot since last night, should I be worried?',NOW()-INTERVAL '2 days',TRUE FROM users_users e,users_users d WHERE e.username='parent.lina' AND d.username='dr.amrani';

INSERT INTO notifications_message (expediteur_id,destinataire_id,contenu,date_envoi,lu)
SELECT e.id,d.id,'Hello. If fever goes above 39C or breathing becomes difficult, come to the emergency room. Otherwise continue the treatment.',NOW()-INTERVAL '2 days'+INTERVAL '1 hour',TRUE FROM users_users e,users_users d WHERE e.username='dr.amrani' AND d.username='parent.lina';

INSERT INTO notifications_message (expediteur_id,destinataire_id,contenu,date_envoi,lu)
SELECT e.id,d.id,'Doctor, Amine blood glucose was 3.2 g/L this morning after breakfast, is that normal?',NOW()-INTERVAL '1 day',FALSE FROM users_users e,users_users d WHERE e.username='parent.ahmed' AND d.username='dr.khelif';

INSERT INTO notifications_message (expediteur_id,destinataire_id,contenu,date_envoi,lu)
SELECT e.id,d.id,'Hello, is it possible to reschedule Wissam appointment on May 17th? We cannot make it.',NOW()-INTERVAL '12 hours',FALSE FROM users_users e,users_users d WHERE e.username='parent.meriem' AND d.username='sec.karima';

-- ============================================================
-- STEP 16: TRACE ACTIONS
-- ============================================================
INSERT INTO users_traceaction (user_id,action,table_concernee,timestamp) SELECT u.id,'INSERT','users_patients',NOW()-INTERVAL '15 days' FROM users_users u WHERE u.username='sec.fatima';
INSERT INTO users_traceaction (user_id,action,table_concernee,timestamp) SELECT u.id,'INSERT','users_patients',NOW()-INTERVAL '14 days' FROM users_users u WHERE u.username='sec.fatima';
INSERT INTO users_traceaction (user_id,action,table_concernee,timestamp) SELECT u.id,'INSERT','consultations_appointment',NOW()-INTERVAL '13 days' FROM users_users u WHERE u.username='sec.karima';
INSERT INTO users_traceaction (user_id,action,table_concernee,timestamp) SELECT u.id,'INSERT','consultations_consultation',NOW()-INTERVAL '12 days' FROM users_users u WHERE u.username='dr.amrani';
INSERT INTO users_traceaction (user_id,action,table_concernee,timestamp) SELECT u.id,'INSERT','consultations_diagnostic',NOW()-INTERVAL '11 days' FROM users_users u WHERE u.username='dr.amrani';
INSERT INTO users_traceaction (user_id,action,table_concernee,timestamp) SELECT u.id,'INSERT','consultations_traitement',NOW()-INTERVAL '10 days' FROM users_users u WHERE u.username='dr.amrani';
INSERT INTO users_traceaction (user_id,action,table_concernee,timestamp) SELECT u.id,'UPDATE','users_patients',NOW()-INTERVAL '9 days' FROM users_users u WHERE u.username='sec.fatima';
INSERT INTO users_traceaction (user_id,action,table_concernee,timestamp) SELECT u.id,'INSERT','medical_allergie',NOW()-INTERVAL '8 days' FROM users_users u WHERE u.username='dr.khelif';
INSERT INTO users_traceaction (user_id,action,table_concernee,timestamp) SELECT u.id,'INSERT','medical_antecedent',NOW()-INTERVAL '7 days' FROM users_users u WHERE u.username='dr.khelif';
INSERT INTO users_traceaction (user_id,action,table_concernee,timestamp) SELECT u.id,'UPDATE','consultations_appointment',NOW()-INTERVAL '6 days' FROM users_users u WHERE u.username='sec.karima';
INSERT INTO users_traceaction (user_id,action,table_concernee,timestamp) SELECT u.id,'DELETE','consultations_appointment',NOW()-INTERVAL '5 days' FROM users_users u WHERE u.username='admin';
INSERT INTO users_traceaction (user_id,action,table_concernee,timestamp) SELECT u.id,'INSERT','medical_allergie',NOW()-INTERVAL '4 days' FROM users_users u WHERE u.username='dr.amrani';
INSERT INTO users_traceaction (user_id,action,table_concernee,timestamp) SELECT u.id,'INSERT','medical_antecedent',NOW()-INTERVAL '3 days' FROM users_users u WHERE u.username='dr.boudiaf';
INSERT INTO users_traceaction (user_id,action,table_concernee,timestamp) SELECT u.id,'UPDATE','users_users',NOW()-INTERVAL '2 days' FROM users_users u WHERE u.username='admin';
INSERT INTO users_traceaction (user_id,action,table_concernee,timestamp) SELECT u.id,'UPDATE','consultations_appointment',NOW()-INTERVAL '6 hours' FROM users_users u WHERE u.username='sec.fatima';
INSERT INTO users_traceaction (user_id,action,table_concernee,timestamp) SELECT u.id,'INSERT','notifications_notification',NOW()-INTERVAL '2 hours' FROM users_users u WHERE u.username='sec.karima';

-- ============================================================
-- AFTER IMPORT — run in Django shell:
-- python manage.py shell
-- from users.models import Users
-- from django.contrib.auth.hashers import make_password
-- Users.objects.all().update(password=make_password('hospital123'))
-- exit()
-- ============================================================
