-- ============================================================
-- HOPITAL PEDIATRIQUE ORAN — BASE DE DONNEES FINALE
-- Version corrigée avec RESET des séquences PostgreSQL
-- Toutes les tables correspondent exactement aux modèles Django
-- PostgreSQL — exécuter APRÈS python manage.py migrate
--
-- NOUVEAU: Réinitialise les séquences AVANT d'insérer les données
--          pour garantir que les IDs hardcodés (address_id 1,2,3...)
--          correspondent exactement aux lignes insérées.
-- ============================================================

-- ============================================================
-- ÉTAPE 0: RESET DES SÉQUENCES (CRITIQUE — NE PAS SAUTER)
-- Sans cela, les IDs générés ne commencent pas à 1
-- et les address_id hardcodés dans users_users seront faux.
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

-- ============================================================
-- STEP 1: SPECIALTIES (inchangé)
-- ============================================================
INSERT INTO users_specialty (name) VALUES ('Pneumologie pédiatrique');
INSERT INTO users_specialty (name) VALUES ('Pédiatrie générale');
INSERT INTO users_specialty (name) VALUES ('Ophtalmologie pédiatrique');

-- ============================================================
-- STEP 2: ADDRESSES (inchangé — 36 adresses)
-- Ces adresses auront les IDs 1 à 36 grâce au reset de séquence.
-- ============================================================
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('12 Rue Larbi Ben Mhidi',          'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('5 Cité des 1000 Logements',        'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('7 Rue de la Paix',                 'Oran',           'Es Senia',        '31130');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('3 Boulevard Millénium',            'Oran',           'Bir El Djir',     '31200');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('22 Rue Hassiba Ben Bouali',        'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('9 Cité USTO',                      'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('14 Rue Ahmed Zabana',              'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('88 Cité Petit Lac',                'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('2 Rue des Frères Bouadou',         'Oran',           'Bir El Djir',     '31200');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('45 Boulevard Soummam',             'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('17 Cité Bousfer',                  'Oran',           'Bousfer',         '31150');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('33 Rue Mohamed Khemisti',          'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('6 Impasse Belcourt',               'Oran',           'Es Senia',        '31130');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('19 Rue de Mostaganem',             'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('52 Cité El Yasmine',               'Oran',           'Bir El Djir',     '31200');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('8 Rue Abdelkader Azzout',          'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('24 Cité Gambetta',                 'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('11 Rue du 1er Novembre',           'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('36 Cité ZHUN Est',                 'Oran',           'Bir El Djir',     '31200');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('3 Rue Houari Boumediene',          'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('77 Boulevard Colonel Lotfi',       'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('15 Cité 5 Juillet',                'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('29 Rue Cheikh Larbi Tébessi',      'Oran',           'Es Senia',        '31130');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('4 Allée des Orangers',             'Oran',           'Bousfer',         '31150');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('18 Cité Petit Lac Ouest',          'Oran',           'Oran',            '31000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('7 Rue des Martyrs',                'Mostaganem',     'Mostaganem',      '27000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('21 Cité El Wiam',                  'Mostaganem',     'Mostaganem',      '27000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('5 Rue Emir Abdelkader',            'Ain Témouchent', 'Ain Témouchent',  '46000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('13 Cité OPGI',                     'Ain Témouchent', 'Ain Témouchent',  '46000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('9 Boulevard de la République',     'Mascara',        'Mascara',         '29000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('32 Rue Khaled Ibn El Walid',       'Mascara',        'Mascara',         '29000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('16 Cité 200 Logements',            'Sidi Bel Abbes', 'Sidi Bel Abbes',  '22000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('44 Avenue Larbi Ben Mhidi',        'Sidi Bel Abbes', 'Sidi Bel Abbes',  '22000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('6 Rue 8 Mai 1945',                 'Relizane',       'Relizane',        '48000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('27 Cité Sonatrach',                'Tlemcen',        'Tlemcen',         '13000');
INSERT INTO users_address (address_line, region, city, code_postal) VALUES ('38 Rue Abou Mediène',              'Tlemcen',        'Tlemcen',         '13000');

-- ============================================================
-- STEP 3: USERS
-- FIX: MEDECIN → DOCTOR (Django role choice)
-- REMOVED: users_role, users_admin, users_parent inserts
-- ============================================================

-- ADMIN (address_id=1 → '12 Rue Larbi Ben Mhidi')
INSERT INTO users_users (password,last_login,is_superuser,username,first_name,last_name,email,is_staff,is_active,date_joined,role,phone,address_id)
VALUES ('pbkdf2_sha256$1200000$R6snFdPgbeGREQ96rtgt3O$ZY9NB4peT3QP6byO3kAORj2J2kk3/+5DMrNal2vhTjA=',NULL,TRUE,'admin','Admin','Systeme','admin@hopital-oran.dz',TRUE,TRUE,NOW(),'ADMIN','0555000000',1);

-- SECRETAIRES
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

-- PARENTS (31 parents)
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
-- STEP 4: SECRETAIRE PROFILES
-- ============================================================
INSERT INTO users_secretaire (user_id, bureau, telephone_interne, horaires_service, photo)
SELECT u.id, 'Bureau 101 - Accueil Principal', '041-23-45-01', 'Dimanche-Jeudi 08h00-16h00', ''
FROM users_users u WHERE u.username = 'sec.fatima';

INSERT INTO users_secretaire (user_id, bureau, telephone_interne, horaires_service, photo)
SELECT u.id, 'Bureau 102 - Admissions', '041-23-45-02', 'Dimanche-Jeudi 09h00-17h00', ''
FROM users_users u WHERE u.username = 'sec.karima';

-- ============================================================
-- STEP 5: DOCTOR PROFILES
-- ============================================================
INSERT INTO users_doctors (user_id,specialty_id,bio,horaire_travail,actif,ville,photo,numero_ordre_medecins)
SELECT u.id,s.id,'Spécialiste en pneumologie pédiatrique, 12 ans expérience. Expert asthme infantile et pathologies respiratoires chroniques.','Dim-Jeu 08h-16h',TRUE,'Oran','','31-MED-0041'
FROM users_users u, users_specialty s WHERE u.username='dr.amrani' AND s.name='Pneumologie pédiatrique';

INSERT INTO users_doctors (user_id,specialty_id,bio,horaire_travail,actif,ville,photo,numero_ordre_medecins)
SELECT u.id,s.id,'Pédiatre généraliste spécialisée dans le suivi des maladies chroniques de l enfant. Diabète, maladies auto-immunes.','Dim-Jeu 09h-17h',TRUE,'Oran','','31-MED-0087'
FROM users_users u, users_specialty s WHERE u.username='dr.khelif' AND s.name='Pédiatrie générale';

INSERT INTO users_doctors (user_id,specialty_id,bio,horaire_travail,actif,ville,photo,numero_ordre_medecins)
SELECT u.id,s.id,'Ophtalmologiste pédiatrique. Expert en strabisme, myopie précoce et pathologies oculaires.','Lun-Jeu 08h30-15h30',TRUE,'Oran','','31-MED-0152'
FROM users_users u, users_specialty s WHERE u.username='dr.benali' AND s.name='Ophtalmologie pédiatrique';

INSERT INTO users_doctors (user_id,specialty_id,bio,horaire_travail,actif,ville,photo,numero_ordre_medecins)
SELECT u.id,s.id,'Pneumologue pédiatrique spécialisée dans les infections respiratoires récidivantes et la mucoviscidose.','Dim-Mer 08h-14h',TRUE,'Bir El Djir','','31-MED-0203'
FROM users_users u, users_specialty s WHERE u.username='dr.meziani' AND s.name='Pneumologie pédiatrique';

INSERT INTO users_doctors (user_id,specialty_id,bio,horaire_travail,actif,ville,photo,numero_ordre_medecins)
SELECT u.id,s.id,'Pédiatre généraliste avec expertise en maladies rares et pathologies métaboliques de l enfant.','Dim-Jeu 10h-18h',TRUE,'Oran','','31-MED-0244'
FROM users_users u, users_specialty s WHERE u.username='dr.boudiaf' AND s.name='Pédiatrie générale';

-- ============================================================
-- STEP 6: PATIENTS (50 enfants)
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
INSERT INTO users_patients (parent_id,first_name,last_name,birth_date,gender,groupe_sanguin,telephone_parent,email,date_creation_dossier) SELECT u.id,'Sirine','Hadj','2019-06-17','F','O+','0770666777','','2023-03-22' FROM users_users u WHERE u.username='parent.hayat';
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
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Pollen de graminées','MODEREE','Rhinite et yeux larmoyants intenses au printemps. Éternuements fréquents.','2023-03-10' FROM users_patients p WHERE p.first_name='Imane' AND p.last_name='Ouali';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Arachides','SEVERE','Urticaire généralisée et gonflement des lèvres. Adrénaline prescrite.','2022-06-15' FROM users_patients p WHERE p.first_name='Amine' AND p.last_name='Mansouri';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Pénicilline','SEVERE','Éruption cutanée généralisée lors du traitement amoxicilline. Contre-indication absolue.','2023-01-20' FROM users_patients p WHERE p.first_name='Rayan' AND p.last_name='Boudiaf';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Lait de vache','LEGERE','Douleurs abdominales et diarrhée. Régime sans lactose.','2022-09-05' FROM users_patients p WHERE p.first_name='Adam' AND p.last_name='Bensalem';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Acariens','MODEREE','Rhinite allergique et aggravation de l asthme. Désensibilisation en cours.','2022-04-12' FROM users_patients p WHERE p.first_name='Ilyasse' AND p.last_name='Rahmani';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Pollen de graminées','LEGERE','Conjonctivite allergique saisonnière. Collyres antihistaminiques.','2023-04-01' FROM users_patients p WHERE p.first_name='Chaima' AND p.last_name='Saidi';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Noix','SEVERE','Angiœdème oral. Porte un EpiPen en permanence.','2022-11-30' FROM users_patients p WHERE p.first_name='Hamza' AND p.last_name='Belarbi';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Poils de chat','LEGERE','Éternuements et yeux rouges au contact des félins.','2023-07-14' FROM users_patients p WHERE p.first_name='Safa' AND p.last_name='Tlemcani';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Œufs','MODEREE','Urticaire et vomissements après ingestion. Régime d éviction.','2022-08-22' FROM users_patients p WHERE p.first_name='Djawad' AND p.last_name='Mekki';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Acariens','MODEREE','Rhinite chronique et eczéma aggravé. Housse anti-acariens prescrite.','2023-02-18' FROM users_patients p WHERE p.first_name='Hana' AND p.last_name='Bensmain';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Aspirine','SEVERE','Bronchospasme sévère. AINS strictement contre-indiqués.','2022-10-05' FROM users_patients p WHERE p.first_name='Bilel' AND p.last_name='Boudinar';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Fraises','LEGERE','Urticaire péribuccale localisée. Éviction recommandée.','2023-06-20' FROM users_patients p WHERE p.first_name='Lyna' AND p.last_name='Djaafri';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Gluten','SEVERE','Maladie cœliaque confirmée par biopsie. Régime sans gluten strict à vie.','2023-01-25' FROM users_patients p WHERE p.first_name='Adem' AND p.last_name='Sellal';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Latex','MODEREE','Urticaire de contact. Précaution lors des soins médicaux.','2022-07-08' FROM users_patients p WHERE p.first_name='Yasmine' AND p.last_name='Benyahia';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Pollen d arbres','LEGERE','Rhinite et toux sèche printanière.','2023-03-30' FROM users_patients p WHERE p.first_name='Walid' AND p.last_name='Boussaid';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Arachides','SEVERE','Choc anaphylactique à l âge de 2 ans. Adrénaline auto-injectable prescrite.','2022-05-15' FROM users_patients p WHERE p.first_name='Ryad' AND p.last_name='Kaci';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Lait de vache','MODEREE','Eczéma atopique aggravé et troubles digestifs. Substitut au soja.','2023-09-10' FROM users_patients p WHERE p.first_name='Inasse' AND p.last_name='Bouziane';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Poissons','LEGERE','Urticaire modérée. Éviction des poissons à chair grasse.','2022-12-12' FROM users_patients p WHERE p.first_name='Selma' AND p.last_name='Ziani';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Acariens','SEVERE','Asthme sévère aggravé. Traitement de fond renforcé.','2022-03-08' FROM users_patients p WHERE p.first_name='Taim' AND p.last_name='Boumediene';
INSERT INTO medical_allergie (patient_id,nom,reaction,description,date_detection) SELECT p.id,'Pollen de graminées','LEGERE','Conjonctivite et rhinite saisonnière légère.','2023-04-25' FROM users_patients p WHERE p.first_name='Nour El Houda' AND p.last_name='Tebbal';

-- ============================================================
-- STEP 8: ANTECEDENTS (29)
-- ============================================================
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Chirurgical','Amygdalectomie suite à angines récidivantes. Guérison complète.','2024-01-15' FROM users_patients p WHERE p.first_name='Imane' AND p.last_name='Ouali';
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Médical','Scoliose idiopathique débutante. Kinésithérapie en cours.','2023-07-19' FROM users_patients p WHERE p.first_name='Walid' AND p.last_name='Boussaid';
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Familial','Antécédents familiaux mucoviscidose (oncle maternel).','2023-06-10' FROM users_patients p WHERE p.first_name='Rima' AND p.last_name='Rahmani';
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Familial','Antécédents familiaux d asthme (père et grand-père paternel).','2023-05-20' FROM users_patients p WHERE p.first_name='Sara' AND p.last_name='Boudiaf';
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Chirurgical','Adénoïdectomie mars 2023. Amélioration respiration nasale.','2023-03-18' FROM users_patients p WHERE p.first_name='Adam' AND p.last_name='Bensalem';
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Familial','Grand-père paternel diabétique T2. Mère asthmatique.','2023-03-01' FROM users_patients p WHERE p.first_name='Rayane' AND p.last_name='Saidi';
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Médical','Bronchite aiguë traitée par amoxicilline. Guérison complète.','2023-02-14' FROM users_patients p WHERE p.first_name='Rayan' AND p.last_name='Boudiaf';
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Médical','Dermite atopique modérée depuis 18 mois. Traitement émollients.','2023-02-07' FROM users_patients p WHERE p.first_name='Hana' AND p.last_name='Bensmain';
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Médical','Maladie coeliaque confirmée par biopsie. Régime sans gluten strict.','2023-01-25' FROM users_patients p WHERE p.first_name='Adem' AND p.last_name='Sellal';
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Médical','Diabète de type 1 diagnostiqué septembre 2022. Insulinothérapie en cours.','2022-09-01' FROM users_patients p WHERE p.first_name='Amine' AND p.last_name='Mansouri';
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Familial','Père diabétique T1. Risque familial élevé. Surveillance glycémique annuelle.','2022-08-15' FROM users_patients p WHERE p.first_name='Zakaria' AND p.last_name='Medjdoub';
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Chirurgical','Fracture radius droit suite à chute. Plâtre 6 semaines.','2022-07-03' FROM users_patients p WHERE p.first_name='Yasser' AND p.last_name='Djaafri';
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Médical','Asthme sévère avec 2 hospitalisations en 2022.','2022-05-30' FROM users_patients p WHERE p.first_name='Bilel' AND p.last_name='Boudinar';
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Chirurgical','Strabisme convergent corrigé chirurgicalement. Port de lunettes.','2022-04-25' FROM users_patients p WHERE p.first_name='Safa' AND p.last_name='Tlemcani';
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Médical','Epilepsie partielle bénigne de l enfance. Traitement valproate.','2022-03-14' FROM users_patients p WHERE p.first_name='Ilyes' AND p.last_name='Ghali';
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Chirurgical','Reflux gastro-oesophagien sévère néonatal. Fundoplicature.','2022-03-01' FROM users_patients p WHERE p.first_name='Youssef' AND p.last_name='Baali';
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Médical','Bronchiolite sévère à VRS à 3 mois. Hospitalisation 10 jours.','2021-12-20' FROM users_patients p WHERE p.first_name='Djawad' AND p.last_name='Mekki';
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Médical','Retard de langage. Suivi orthophoniste depuis 3 ans.','2021-11-08' FROM users_patients p WHERE p.first_name='Taim' AND p.last_name='Boumediene';
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Médical','Asthme modéré diagnostiqué 2021. Traitement fond budésonide.','2021-10-18' FROM users_patients p WHERE p.first_name='Ilyasse' AND p.last_name='Rahmani';
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Médical','Myopie évolutive depuis 4 ans. Suivi ophtalmologique annuel.','2021-09-12' FROM users_patients p WHERE p.first_name='Chaima' AND p.last_name='Saidi';
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Médical','Cardiopathie congénitale CIV fermée spontanément à 2 ans.','2021-07-22' FROM users_patients p WHERE p.first_name='Ryad' AND p.last_name='Kaci';
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Chirurgical','Hernie inguinale droite opérée à 2 ans. Aucune complication.','2021-05-14' FROM users_patients p WHERE p.first_name='Mohamed' AND p.last_name='Dif';
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Familial','Mère porteuse mucoviscidose. Test génétique patient négatif.','2022-06-30' FROM users_patients p WHERE p.first_name='Nour' AND p.last_name='Mansouri';
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Médical','Otites à répétition. 4 épisodes en 2022. Paracentèse envisagée.','2022-11-05' FROM users_patients p WHERE p.first_name='Lyna' AND p.last_name='Djaafri';
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Familial','Grand-père maternel décédé d un cancer du poumon. Non-fumeurs dans la famille.','2023-08-20' FROM users_patients p WHERE p.first_name='Anis' AND p.last_name='Haddar';
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Médical','Prématurité 34 SA. Séjour en néonatologie 3 semaines.','2022-01-15' FROM users_patients p WHERE p.first_name='Ritaj' AND p.last_name='Haddar';
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Médical','Pneumonie lobaire droite à pneumocoque. Hospitalisation 5 jours.','2023-02-01' FROM users_patients p WHERE p.first_name='Israe' AND p.last_name='Boumediene';
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Familial','Frère atteint de drépanocytose SS. Surveillance hématologique.','2022-04-10' FROM users_patients p WHERE p.first_name='Amira' AND p.last_name='Bouhelal';
INSERT INTO medical_antecedent (patient_id,type,description,date_declaration) SELECT p.id,'Chirurgical','Cryptorchidie bilatérale opérée à 18 mois. Suivi endocrinologique.','2023-10-08' FROM users_patients p WHERE p.first_name='Fares' AND p.last_name='Bouhelal';

-- ============================================================
-- STEP 9: APPOINTMENTS (19)
-- ============================================================
INSERT INTO consultations_appointment (patient_id,doctor_id,date_rdv,heure_rdv,motif,status,notes_secretaire,created_by_id)
SELECT p.id,d.id,'2026-03-10','09:00','Contrôle asthme et spirométrie','COMPLETED','RDV confirmé par téléphone',s.id
FROM users_patients p, users_doctors d JOIN users_users u ON d.user_id=u.id, users_users s
WHERE p.first_name='Rayan' AND p.last_name='Boudiaf' AND u.username='dr.amrani' AND s.username='sec.fatima';

INSERT INTO consultations_appointment (patient_id,doctor_id,date_rdv,heure_rdv,motif,status,notes_secretaire,created_by_id)
SELECT p.id,d.id,'2026-03-15','10:30','Suivi diabète T1 et HbA1c','COMPLETED','Résultats bilan à apporter',s.id
FROM users_patients p, users_doctors d JOIN users_users u ON d.user_id=u.id, users_users s
WHERE p.first_name='Amine' AND p.last_name='Mansouri' AND u.username='dr.khelif' AND s.username='sec.fatima';

INSERT INTO consultations_appointment (patient_id,doctor_id,date_rdv,heure_rdv,motif,status,notes_secretaire,created_by_id)
SELECT p.id,d.id,'2026-03-22','08:30','Contrôle myopie et acuité visuelle','COMPLETED','Apporter dernière ordonnance lunettes',s.id
FROM users_patients p, users_doctors d JOIN users_users u ON d.user_id=u.id, users_users s
WHERE p.first_name='Chaima' AND p.last_name='Saidi' AND u.username='dr.benali' AND s.username='sec.karima';

INSERT INTO consultations_appointment (patient_id,doctor_id,date_rdv,heure_rdv,motif,status,notes_secretaire,created_by_id)
SELECT p.id,d.id,'2026-04-02','09:30','Suivi asthme - évaluation traitement fond','COMPLETED','RDV urgent demandé par parent',s.id
FROM users_patients p, users_doctors d JOIN users_users u ON d.user_id=u.id, users_users s
WHERE p.first_name='Ilyasse' AND p.last_name='Rahmani' AND u.username='dr.amrani' AND s.username='sec.fatima';

INSERT INTO consultations_appointment (patient_id,doctor_id,date_rdv,heure_rdv,motif,status,notes_secretaire,created_by_id)
SELECT p.id,d.id,'2026-04-08','11:00','Contrôle cœliaquie et sérologie','COMPLETED','À jeun requis pour bilan',s.id
FROM users_patients p, users_doctors d JOIN users_users u ON d.user_id=u.id, users_users s
WHERE p.first_name='Adem' AND p.last_name='Sellal' AND u.username='dr.khelif' AND s.username='sec.karima';

INSERT INTO consultations_appointment (patient_id,doctor_id,date_rdv,heure_rdv,motif,status,notes_secretaire,created_by_id)
SELECT p.id,d.id,'2026-04-15','09:00','Suivi épilepsie et EEG de contrôle','COMPLETED','EEG programmé au bloc B',s.id
FROM users_patients p, users_doctors d JOIN users_users u ON d.user_id=u.id, users_users s
WHERE p.first_name='Ilyes' AND p.last_name='Ghali' AND u.username='dr.boudiaf' AND s.username='sec.fatima';

INSERT INTO consultations_appointment (patient_id,doctor_id,date_rdv,heure_rdv,motif,status,notes_secretaire,created_by_id)
SELECT p.id,d.id,'2026-04-22','10:00','Renouvellement traitement asthme','CANCELLED','Annulé par la famille - enfant malade',s.id
FROM users_patients p, users_doctors d JOIN users_users u ON d.user_id=u.id, users_users s
WHERE p.first_name='Nour' AND p.last_name='Mansouri' AND u.username='dr.meziani' AND s.username='sec.karima';

INSERT INTO consultations_appointment (patient_id,doctor_id,date_rdv,heure_rdv,motif,status,notes_secretaire,created_by_id)
SELECT p.id,d.id,'2026-04-25','08:30','Suivi maladie cœliaque et croissance','COMPLETED','Courbe de croissance à mettre à jour',s.id
FROM users_patients p, users_doctors d JOIN users_users u ON d.user_id=u.id, users_users s
WHERE p.first_name='Yasmine' AND p.last_name='Benyahia' AND u.username='dr.khelif' AND s.username='sec.fatima';

INSERT INTO consultations_appointment (patient_id,doctor_id,date_rdv,heure_rdv,motif,status,notes_secretaire,created_by_id)
SELECT p.id,d.id,'2026-04-28','09:30','Contrôle hernie opérée - cicatrisation','COMPLETED','Dossier chirurgical à apporter',s.id
FROM users_patients p, users_doctors d JOIN users_users u ON d.user_id=u.id, users_users s
WHERE p.first_name='Mohamed' AND p.last_name='Dif' AND u.username='dr.boudiaf' AND s.username='sec.karima';

INSERT INTO consultations_appointment (patient_id,doctor_id,date_rdv,heure_rdv,motif,status,notes_secretaire,created_by_id)
SELECT p.id,d.id,'2026-05-06','10:00','Suivi diabète T1 - ajustement insuline','CONFIRMED','Carnet glycémique à apporter',s.id
FROM users_patients p, users_doctors d JOIN users_users u ON d.user_id=u.id, users_users s
WHERE p.first_name='Amine' AND p.last_name='Mansouri' AND u.username='dr.khelif' AND s.username='sec.fatima';

INSERT INTO consultations_appointment (patient_id,doctor_id,date_rdv,heure_rdv,motif,status,notes_secretaire,created_by_id)
SELECT p.id,d.id,'2026-05-08','09:00','Bilan annuel asthme - test allergie','CONFIRMED','Test cutané allergènes prévu',s.id
FROM users_patients p, users_doctors d JOIN users_users u ON d.user_id=u.id, users_users s
WHERE p.first_name='Ilyasse' AND p.last_name='Rahmani' AND u.username='dr.amrani' AND s.username='sec.karima';

INSERT INTO consultations_appointment (patient_id,doctor_id,date_rdv,heure_rdv,motif,status,notes_secretaire,created_by_id)
SELECT p.id,d.id,'2026-05-12','11:00','Contrôle vision - renouvellement lunettes','CONFIRMED','Nouvelle prescription lunettes attendue',s.id
FROM users_patients p, users_doctors d JOIN users_users u ON d.user_id=u.id, users_users s
WHERE p.first_name='Ryad' AND p.last_name='Kaci' AND u.username='dr.benali' AND s.username='sec.fatima';

INSERT INTO consultations_appointment (patient_id,doctor_id,date_rdv,heure_rdv,motif,status,notes_secretaire,created_by_id)
SELECT p.id,d.id,'2026-05-15','09:00','Contrôle asthme et Peak-Flow','PENDING','Premier RDV avec Dr. Amrani',s.id
FROM users_patients p, users_doctors d JOIN users_users u ON d.user_id=u.id, users_users s
WHERE p.first_name='Rayan' AND p.last_name='Boudiaf' AND u.username='dr.amrani' AND s.username='sec.karima';

INSERT INTO consultations_appointment (patient_id,doctor_id,date_rdv,heure_rdv,motif,status,notes_secretaire,created_by_id)
SELECT p.id,d.id,'2026-05-16','10:00','Suivi croissance et vaccination','PENDING','Carnet de vaccination à apporter',s.id
FROM users_patients p, users_doctors d JOIN users_users u ON d.user_id=u.id, users_users s
WHERE p.first_name='Nour' AND p.last_name='Mansouri' AND u.username='dr.meziani' AND s.username='sec.fatima';

INSERT INTO consultations_appointment (patient_id,doctor_id,date_rdv,heure_rdv,motif,status,notes_secretaire,created_by_id)
SELECT p.id,d.id,'2026-05-20','08:30','Consultation strabisme post-opératoire','PENDING','2ème contrôle post-opératoire',s.id
FROM users_patients p, users_doctors d JOIN users_users u ON d.user_id=u.id, users_users s
WHERE p.first_name='Safa' AND p.last_name='Tlemcani' AND u.username='dr.benali' AND s.username='sec.karima';

INSERT INTO consultations_appointment (patient_id,doctor_id,date_rdv,heure_rdv,motif,status,notes_secretaire,created_by_id)
SELECT p.id,d.id,'2026-05-22','10:30','Suivi épilepsie - évaluation valproate','PENDING','Bilan hépatique à apporter',s.id
FROM users_patients p, users_doctors d JOIN users_users u ON d.user_id=u.id, users_users s
WHERE p.first_name='Ilyes' AND p.last_name='Ghali' AND u.username='dr.boudiaf' AND s.username='sec.fatima';

INSERT INTO consultations_appointment (patient_id,doctor_id,date_rdv,heure_rdv,motif,status,notes_secretaire,created_by_id)
SELECT p.id,d.id,'2026-05-25','09:00','Dermite atopique - évaluation SCORAD','PENDING','Photos lésions à apporter',s.id
FROM users_patients p, users_doctors d JOIN users_users u ON d.user_id=u.id, users_users s
WHERE p.first_name='Hana' AND p.last_name='Bensmain' AND u.username='dr.khelif' AND s.username='sec.karima';

INSERT INTO consultations_appointment (patient_id,doctor_id,date_rdv,heure_rdv,motif,status,notes_secretaire,created_by_id)
SELECT p.id,d.id,'2026-06-03','11:00','Suivi asthme sévère - hospitalisation récente','PENDING','Compte rendu hospitalisation à apporter',s.id
FROM users_patients p, users_doctors d JOIN users_users u ON d.user_id=u.id, users_users s
WHERE p.first_name='Bilel' AND p.last_name='Boudinar' AND u.username='dr.amrani' AND s.username='sec.fatima';

-- ============================================================
-- STEP 10: CONSULTATIONS (8 for completed appointments)
-- ============================================================
INSERT INTO consultations_consultation (appointment_id,doctor_id,patient_id,date_consultation,motif_consultation,anamnese,examen_clinique,conclusion,recommendations,prochain_rdv)
SELECT a.id,d.id,p.id,'2026-03-10','Contrôle asthme et spirométrie','Asthme persistant modéré diagnostiqué en 2021. Traitement fond budésonide 200mcg/j. Pas de crise nocturne depuis 3 mois. Compliance correcte.','TA: 100/65 mmHg. FC: 88 bpm. SpO2: 98%. Auscultation: quelques sibilants expiratoires bilatéraux discrets. Spirométrie: VEMS 78% théorique, légère obstruction.','Asthme persistant modéré partiellement contrôlé. Obstruction légère à la spirométrie.','Augmenter budésonide à 400mcg/j. Ajouter salbutamol de secours. Éviction allergènes. Contrôle dans 6 semaines.','2026-05-15'
FROM consultations_appointment a JOIN users_patients p ON a.patient_id=p.id JOIN users_doctors d ON a.doctor_id=d.id JOIN users_users u ON d.user_id=u.id
WHERE p.first_name='Rayan' AND p.last_name='Boudiaf' AND u.username='dr.amrani' AND a.date_rdv::date='2026-03-10';

INSERT INTO consultations_consultation (appointment_id,doctor_id,patient_id,date_consultation,motif_consultation,anamnese,examen_clinique,conclusion,recommendations,prochain_rdv)
SELECT a.id,d.id,p.id,'2026-03-15','Suivi diabète T1 et HbA1c','Diabète T1 depuis 2022. Insuline basale glargine + bolus rapide. HbA1c à 7.8% (objectif <7.5%). Quelques hypoglycémies nocturnes.','Poids: 32 kg. Taille: 128 cm. IMC: 19.5. Examen normal. Pas de signe de neuropathie.','Diabète T1 avec équilibre glycémique insuffisant. Hypoglycémies nocturnes à corriger.','Ajuster dose basale glargine: réduire de 10%. Contrôle glycémique renforcé. Consultation diététique. Bilan ophtalmologique annuel.','2026-05-06'
FROM consultations_appointment a JOIN users_patients p ON a.patient_id=p.id JOIN users_doctors d ON a.doctor_id=d.id JOIN users_users u ON d.user_id=u.id
WHERE p.first_name='Amine' AND p.last_name='Mansouri' AND u.username='dr.khelif' AND a.date_rdv::date='2026-03-15';

INSERT INTO consultations_consultation (appointment_id,doctor_id,patient_id,date_consultation,motif_consultation,anamnese,examen_clinique,conclusion,recommendations,prochain_rdv)
SELECT a.id,d.id,p.id,'2026-03-22','Contrôle myopie et acuité visuelle','Myopie évolutive depuis l âge de 7 ans. Lunettes -2.50/-2.75. Dernière correction il y a 1 an.','Acuité visuelle OD: 8/10, OG: 7/10 avec correction. Fond d œil normal. Réfraction sous cycloplégie: -3.00/-3.25.','Myopie évolutive. Aggravation de -0.50D en 1 an.','Nouvelle correction: -3.00 OD / -3.25 OG. Limiter le temps d écran. Activités extérieures recommandées. Contrôle dans 6 mois.','2026-09-22'
FROM consultations_appointment a JOIN users_patients p ON a.patient_id=p.id JOIN users_doctors d ON a.doctor_id=d.id JOIN users_users u ON d.user_id=u.id
WHERE p.first_name='Chaima' AND p.last_name='Saidi' AND u.username='dr.benali' AND a.date_rdv::date='2026-03-22';

INSERT INTO consultations_consultation (appointment_id,doctor_id,patient_id,date_consultation,motif_consultation,anamnese,examen_clinique,conclusion,recommendations,prochain_rdv)
SELECT a.id,d.id,p.id,'2026-04-02','Suivi asthme - évaluation traitement fond','Asthme modéré sous budésonide 200mcg. Parent signale 2 crises nocturnes le mois dernier. Utilisation salbutamol 3x/semaine.','SpO2: 97%. Auscultation: sibilants modérés. Peak-Flow: 72% du théorique. Sensibilisation acariens confirmée.','Asthme non contrôlé. Sensibilisation aux acariens. Traitement insuffisant.','Augmenter budésonide 400mcg + ajouter montelukast. Housse anti-acariens. Plan d action écrit. Contrôle 6 semaines.','2026-05-08'
FROM consultations_appointment a JOIN users_patients p ON a.patient_id=p.id JOIN users_doctors d ON a.doctor_id=d.id JOIN users_users u ON d.user_id=u.id
WHERE p.first_name='Ilyasse' AND p.last_name='Rahmani' AND u.username='dr.amrani' AND a.date_rdv::date='2026-04-02';

INSERT INTO consultations_consultation (appointment_id,doctor_id,patient_id,date_consultation,motif_consultation,anamnese,examen_clinique,conclusion,recommendations,prochain_rdv)
SELECT a.id,d.id,p.id,'2026-04-08','Contrôle cœliaquie et sérologie','Maladie cœliaque sous régime sans gluten depuis 1 an. Parents rapportent compliance correcte. Pas de symptôme digestif.','Poids: 28 kg (+1.5kg/6 mois). Taille: 112 cm. Abdomen souple. Sérologie anti-tTG: 8 UI/mL (N<10).','Maladie cœliaque bien contrôlée sous régime sans gluten. Normalisation sérologique.','Continuer régime sans gluten strict. Supplémentation vitamines D et fer. Sérologie de contrôle dans 1 an. Croissance satisfaisante.','2027-04-08'
FROM consultations_appointment a JOIN users_patients p ON a.patient_id=p.id JOIN users_doctors d ON a.doctor_id=d.id JOIN users_users u ON d.user_id=u.id
WHERE p.first_name='Adem' AND p.last_name='Sellal' AND u.username='dr.khelif' AND a.date_rdv::date='2026-04-08';

INSERT INTO consultations_consultation (appointment_id,doctor_id,patient_id,date_consultation,motif_consultation,anamnese,examen_clinique,conclusion,recommendations,prochain_rdv)
SELECT a.id,d.id,p.id,'2026-04-15','Suivi épilepsie et EEG de contrôle','Épilepsie partielle bénigne sous valproate 500mg/j. Dernière crise il y a 8 mois. Bonne tolérance traitement.','Examen neurologique normal. EEG: persistance foyer temporal droit, activité réduite vs EEG précédent. Bilan hépatique normal.','Épilepsie partielle bénigne en bonne évolution sous valproate. Amélioration EEG.','Continuer valproate même dose. Contrôle EEG dans 6 mois. Pas de restriction scolaire. Information famille sur CAT en cas de crise.','2026-10-15'
FROM consultations_appointment a JOIN users_patients p ON a.patient_id=p.id JOIN users_doctors d ON a.doctor_id=d.id JOIN users_users u ON d.user_id=u.id
WHERE p.first_name='Ilyes' AND p.last_name='Ghali' AND u.username='dr.boudiaf' AND a.date_rdv::date='2026-04-15';

INSERT INTO consultations_consultation (appointment_id,doctor_id,patient_id,date_consultation,motif_consultation,anamnese,examen_clinique,conclusion,recommendations,prochain_rdv)
SELECT a.id,d.id,p.id,'2026-04-25','Suivi maladie cœliaque et croissance','Maladie cœliaque confirmée. Sous régime sans gluten depuis 8 mois. Amélioration des douleurs abdominales.','Poids: 27 kg. Taille: 118 cm. Courbe de croissance: rattrapage staturo-pondéral. Sérologie en cours.','Bonne évolution de la maladie cœliaque. Rattrapage de croissance satisfaisant.','Poursuivre régime sans gluten. Supplémentation calcium et vitamine D. Prochain bilan dans 6 mois.','2026-10-25'
FROM consultations_appointment a JOIN users_patients p ON a.patient_id=p.id JOIN users_doctors d ON a.doctor_id=d.id JOIN users_users u ON d.user_id=u.id
WHERE p.first_name='Yasmine' AND p.last_name='Benyahia' AND u.username='dr.khelif' AND a.date_rdv::date='2026-04-25';

INSERT INTO consultations_consultation (appointment_id,doctor_id,patient_id,date_consultation,motif_consultation,anamnese,examen_clinique,conclusion,recommendations,prochain_rdv)
SELECT a.id,d.id,p.id,'2026-04-28','Contrôle hernie opérée - cicatrisation','Hernie inguinale opérée à 2 ans. Contrôle de routine à 10 ans.','Cicatrice inguinale droite propre. Pas de récidive. Orifice inguinal fermé. Examen des testicules normal.','Guérison complète hernie inguinale. Aucune récidive. Pas de suivi chirurgical nécessaire.','Aucun traitement nécessaire. Activité physique normale autorisée. Pas de restriction.','2027-04-28'
FROM consultations_appointment a JOIN users_patients p ON a.patient_id=p.id JOIN users_doctors d ON a.doctor_id=d.id JOIN users_users u ON d.user_id=u.id
WHERE p.first_name='Mohamed' AND p.last_name='Dif' AND u.username='dr.boudiaf' AND a.date_rdv::date='2026-04-28';

-- ============================================================
-- STEP 11: DIAGNOSTICS (8)
-- ============================================================
INSERT INTO consultations_diagnostic (consultation_id,code_cim10,libelle,type_diagnostic,description)
SELECT c.id,'J45.1','Asthme allergique persistant modéré','PRINCIPAL','Asthme avec sensibilisation aux acariens. Obstruction réversible aux EFR.'
FROM consultations_consultation c JOIN users_patients p ON c.patient_id=p.id WHERE p.first_name='Rayan' AND p.last_name='Boudiaf' AND c.date_consultation='2026-03-10';

INSERT INTO consultations_diagnostic (consultation_id,code_cim10,libelle,type_diagnostic,description)
SELECT c.id,'E10.9','Diabète de type 1 sans complication','PRINCIPAL','Diabète insulino-dépendant diagnostiqué à l âge de 6 ans. HbA1c 7.8%.'
FROM consultations_consultation c JOIN users_patients p ON c.patient_id=p.id WHERE p.first_name='Amine' AND p.last_name='Mansouri' AND c.date_consultation='2026-03-15';

INSERT INTO consultations_diagnostic (consultation_id,code_cim10,libelle,type_diagnostic,description)
SELECT c.id,'H52.1','Myopie','PRINCIPAL','Myopie évolutive bilatérale. Aggravation de -0.50D en 1 an.'
FROM consultations_consultation c JOIN users_patients p ON c.patient_id=p.id WHERE p.first_name='Chaima' AND p.last_name='Saidi' AND c.date_consultation='2026-03-22';

INSERT INTO consultations_diagnostic (consultation_id,code_cim10,libelle,type_diagnostic,description)
SELECT c.id,'J45.1','Asthme allergique persistant modéré non contrôlé','PRINCIPAL','Asthme avec 2 crises nocturnes/mois et utilisation fréquente bronchodilatateur de secours.'
FROM consultations_consultation c JOIN users_patients p ON c.patient_id=p.id WHERE p.first_name='Ilyasse' AND p.last_name='Rahmani' AND c.date_consultation='2026-04-02';

INSERT INTO consultations_diagnostic (consultation_id,code_cim10,libelle,type_diagnostic,description)
SELECT c.id,'K90.0','Maladie cœliaque','PRINCIPAL','Maladie cœliaque confirmée biopsie duodénale. Sérologie normalisée sous régime.'
FROM consultations_consultation c JOIN users_patients p ON c.patient_id=p.id WHERE p.first_name='Adem' AND p.last_name='Sellal' AND c.date_consultation='2026-04-08';

INSERT INTO consultations_diagnostic (consultation_id,code_cim10,libelle,type_diagnostic,description)
SELECT c.id,'G40.2','Épilepsie partielle symptomatique','PRINCIPAL','Épilepsie partielle bénigne de l enfance. Bonne évolution sous valproate.'
FROM consultations_consultation c JOIN users_patients p ON c.patient_id=p.id WHERE p.first_name='Ilyes' AND p.last_name='Ghali' AND c.date_consultation='2026-04-15';

INSERT INTO consultations_diagnostic (consultation_id,code_cim10,libelle,type_diagnostic,description)
SELECT c.id,'K90.0','Maladie cœliaque en rémission','PRINCIPAL','Maladie cœliaque avec rattrapage staturo-pondéral sous régime sans gluten.'
FROM consultations_consultation c JOIN users_patients p ON c.patient_id=p.id WHERE p.first_name='Yasmine' AND p.last_name='Benyahia' AND c.date_consultation='2026-04-25';

INSERT INTO consultations_diagnostic (consultation_id,code_cim10,libelle,type_diagnostic,description)
SELECT c.id,'Z09','Examen de contrôle post-opératoire','PRINCIPAL','Contrôle hernie inguinale opérée. Guérison complète. Pas de récidive.'
FROM consultations_consultation c JOIN users_patients p ON c.patient_id=p.id WHERE p.first_name='Mohamed' AND p.last_name='Dif' AND c.date_consultation='2026-04-28';

-- ============================================================
-- STEP 12: TRAITEMENTS (13)
-- ============================================================
INSERT INTO consultations_traitement (consultation_id,medicament,dosage,frequence,duree,voie_administration,instructions)
SELECT c.id,'Budésonide','400 mcg','2 fois/jour','6 semaines','Inhalée','Rincer bouche après inhalation. Utiliser chambre d inhalation.'
FROM consultations_consultation c JOIN users_patients p ON c.patient_id=p.id WHERE p.first_name='Rayan' AND p.last_name='Boudiaf' AND c.date_consultation='2026-03-10';

INSERT INTO consultations_traitement (consultation_id,medicament,dosage,frequence,duree,voie_administration,instructions)
SELECT c.id,'Salbutamol','100 mcg/bouffée','À la demande (max 4x/j)','Si besoin','Inhalée','En cas de gêne respiratoire. Max 2 bouffées à la fois.'
FROM consultations_consultation c JOIN users_patients p ON c.patient_id=p.id WHERE p.first_name='Rayan' AND p.last_name='Boudiaf' AND c.date_consultation='2026-03-10';

INSERT INTO consultations_traitement (consultation_id,medicament,dosage,frequence,duree,voie_administration,instructions)
SELECT c.id,'Insuline Glargine','Dose ajustée (-10%)','1 fois/soir','Continue','Sous-cutanée','Injection cuisse ou abdomen. Rotation des sites. Auto-surveillance glycémique.'
FROM consultations_consultation c JOIN users_patients p ON c.patient_id=p.id WHERE p.first_name='Amine' AND p.last_name='Mansouri' AND c.date_consultation='2026-03-15';

INSERT INTO consultations_traitement (consultation_id,medicament,dosage,frequence,duree,voie_administration,instructions)
SELECT c.id,'Insuline Aspart','Selon ratio insuline/glucides','Avant chaque repas','Continue','Sous-cutanée','Adapter selon glycémie préprandiale et glucides consommés.'
FROM consultations_consultation c JOIN users_patients p ON c.patient_id=p.id WHERE p.first_name='Amine' AND p.last_name='Mansouri' AND c.date_consultation='2026-03-15';

INSERT INTO consultations_traitement (consultation_id,medicament,dosage,frequence,duree,voie_administration,instructions)
SELECT c.id,'Verres correcteurs','OD -3.00 / OG -3.25','Port permanent','Continue','Optique','Renouveler ordonnance lunettes. Contrôle dans 6 mois.'
FROM consultations_consultation c JOIN users_patients p ON c.patient_id=p.id WHERE p.first_name='Chaima' AND p.last_name='Saidi' AND c.date_consultation='2026-03-22';

INSERT INTO consultations_traitement (consultation_id,medicament,dosage,frequence,duree,voie_administration,instructions)
SELECT c.id,'Budésonide','400 mcg','2 fois/jour','6 semaines','Inhalée','Majoration du traitement de fond. Réévaluation dans 6 semaines.'
FROM consultations_consultation c JOIN users_patients p ON c.patient_id=p.id WHERE p.first_name='Ilyasse' AND p.last_name='Rahmani' AND c.date_consultation='2026-04-02';

INSERT INTO consultations_traitement (consultation_id,medicament,dosage,frequence,duree,voie_administration,instructions)
SELECT c.id,'Montelukast','5 mg','1 fois/soir','6 semaines','Orale','À prendre le soir au coucher. En complément du traitement inhalé.'
FROM consultations_consultation c JOIN users_patients p ON c.patient_id=p.id WHERE p.first_name='Ilyasse' AND p.last_name='Rahmani' AND c.date_consultation='2026-04-02';

INSERT INTO consultations_traitement (consultation_id,medicament,dosage,frequence,duree,voie_administration,instructions)
SELECT c.id,'Régime sans gluten','Strict','Continue','À vie','Alimentaire','Éviction totale gluten: blé, orge, seigle. Avoine avec prudence. Label sans gluten.'
FROM consultations_consultation c JOIN users_patients p ON c.patient_id=p.id WHERE p.first_name='Adem' AND p.last_name='Sellal' AND c.date_consultation='2026-04-08';

INSERT INTO consultations_traitement (consultation_id,medicament,dosage,frequence,duree,voie_administration,instructions)
SELECT c.id,'Vitamine D3','1000 UI','1 fois/jour','Continue','Orale','Supplémentation vitamin D. À prendre au cours d un repas.'
FROM consultations_consultation c JOIN users_patients p ON c.patient_id=p.id WHERE p.first_name='Adem' AND p.last_name='Sellal' AND c.date_consultation='2026-04-08';

INSERT INTO consultations_traitement (consultation_id,medicament,dosage,frequence,duree,voie_administration,instructions)
SELECT c.id,'Valproate de sodium','500 mg','2 fois/jour','Continue','Orale','Bilan hépatique et NFS tous les 3 mois. Surveiller signes hépatotoxicité.'
FROM consultations_consultation c JOIN users_patients p ON c.patient_id=p.id WHERE p.first_name='Ilyes' AND p.last_name='Ghali' AND c.date_consultation='2026-04-15';

INSERT INTO consultations_traitement (consultation_id,medicament,dosage,frequence,duree,voie_administration,instructions)
SELECT c.id,'Calcium','500 mg','1 fois/jour','Continue','Orale','Supplémentation calcium. En complément de l alimentation.'
FROM consultations_consultation c JOIN users_patients p ON c.patient_id=p.id WHERE p.first_name='Yasmine' AND p.last_name='Benyahia' AND c.date_consultation='2026-04-25';

INSERT INTO consultations_traitement (consultation_id,medicament,dosage,frequence,duree,voie_administration,instructions)
SELECT c.id,'Vitamine D3','800 UI','1 fois/jour','Continue','Orale','Supplémentation vitamine D pour maladie cœliaque.'
FROM consultations_consultation c JOIN users_patients p ON c.patient_id=p.id WHERE p.first_name='Yasmine' AND p.last_name='Benyahia' AND c.date_consultation='2026-04-25';

INSERT INTO consultations_traitement (consultation_id,medicament,dosage,frequence,duree,voie_administration,instructions)
SELECT c.id,'Aucun traitement','N/A','N/A','N/A','N/A','Guérison complète. Pas de traitement médicamenteux nécessaire.'
FROM consultations_consultation c JOIN users_patients p ON c.patient_id=p.id WHERE p.first_name='Mohamed' AND p.last_name='Dif' AND c.date_consultation='2026-04-28';

-- ============================================================
-- STEP 13: DOCUMENTS (3)
-- ============================================================
INSERT INTO documents_document (patient_id,consultation_id,nom_fichier,type_doc,fichier,url_stockage,date_upload)
SELECT p.id,c.id,'ordonnance_rayan_20260310.pdf','ORDONNANCE','documents/ordonnances/rayan_20260310.pdf','documents/ordonnances/rayan_20260310.pdf',NOW()
FROM users_patients p JOIN consultations_consultation c ON c.appointment_id IN (SELECT a.id FROM consultations_appointment a WHERE a.patient_id=p.id AND a.date_rdv::date='2026-03-10')
WHERE p.first_name='Rayan' AND p.last_name='Boudiaf';

INSERT INTO documents_document (patient_id,consultation_id,nom_fichier,type_doc,fichier,url_stockage,date_upload)
SELECT p.id,c.id,'bilan_hba1c_amine_20260315.pdf','ANALYSE','documents/analyses/amine_hba1c_20260315.pdf','documents/analyses/amine_hba1c_20260315.pdf',NOW()
FROM users_patients p JOIN consultations_consultation c ON c.appointment_id IN (SELECT a.id FROM consultations_appointment a WHERE a.patient_id=p.id AND a.date_rdv::date='2026-03-15')
WHERE p.first_name='Amine' AND p.last_name='Mansouri';

INSERT INTO documents_document (patient_id,consultation_id,nom_fichier,type_doc,fichier,url_stockage,date_upload)
SELECT p.id,c.id,'serologie_coeliaque_yasmine_20260425.pdf','ANALYSE','documents/analyses/yasmine_transglutaminase_20260425.pdf','documents/analyses/yasmine_transglutaminase_20260425.pdf',NOW()
FROM users_patients p JOIN consultations_consultation c ON c.appointment_id IN (SELECT a.id FROM consultations_appointment a WHERE a.patient_id=p.id AND a.date_rdv::date='2026-04-25')
WHERE p.first_name='Yasmine' AND p.last_name='Benyahia';

-- ============================================================
-- STEP 14: NOTIFICATIONS (7)
-- ============================================================
INSERT INTO notifications_notification (recipient_id,notif_type,title,message,is_read,created_at,appointment_id) SELECT u.id,'REMINDER','Nouveau rendez-vous','Nouveau RDV de Rayan Boudiaf le 15/05/2026 à 09:00.',FALSE,NOW(),a.id FROM users_users u, consultations_appointment a JOIN users_patients p ON a.patient_id=p.id AND p.first_name='Rayan' AND a.status='PENDING' AND a.date_rdv::date='2026-05-15' WHERE u.username='dr.amrani';
INSERT INTO notifications_notification (recipient_id,notif_type,title,message,is_read,created_at,appointment_id) SELECT u.id,'REMINDER','Rendez-vous confirmé','Le RDV de Amine avec Dr. Khelif est confirmé pour le 06/05/2026.',FALSE,NOW(),a.id FROM users_users u, consultations_appointment a JOIN users_patients p ON a.patient_id=p.id AND p.first_name='Amine' AND a.status='CONFIRMED' AND a.date_rdv::date='2026-05-06' WHERE u.username='parent.ahmed';
INSERT INTO notifications_notification (recipient_id,notif_type,title,message,is_read,created_at,appointment_id) SELECT u.id,'REMINDER','Nouveau rendez-vous','Nouveau RDV de Nour Mansouri le 16/05/2026 à 10:00.',FALSE,NOW(),a.id FROM users_users u, consultations_appointment a JOIN users_patients p ON a.patient_id=p.id AND p.first_name='Nour' AND a.status='PENDING' AND a.date_rdv::date='2026-05-16' WHERE u.username='dr.meziani';
INSERT INTO notifications_notification (recipient_id,notif_type,title,message,is_read,created_at,appointment_id) SELECT u.id,'MESSAGE','Rendez-vous annulé','Le RDV de Nour prévu le 22/04/2026 a été annulé.',TRUE,NOW(),a.id FROM users_users u, consultations_appointment a JOIN users_patients p ON a.patient_id=p.id AND p.first_name='Nour' AND a.status='CANCELLED' AND a.date_rdv::date='2026-04-22' WHERE u.username='parent.ahmed';
INSERT INTO notifications_notification (recipient_id,notif_type,title,message,is_read,created_at,appointment_id) SELECT u.id,'REMINDER','Rendez-vous confirmé','RDV de Ilyasse avec Dr. Amrani confirmé pour le 08/05/2026.',FALSE,NOW(),a.id FROM users_users u, consultations_appointment a JOIN users_patients p ON a.patient_id=p.id AND p.first_name='Ilyasse' AND a.status='CONFIRMED' AND a.date_rdv::date='2026-05-08' WHERE u.username='parent.sofiane';
INSERT INTO notifications_notification (recipient_id,notif_type,title,message,is_read,created_at,appointment_id) SELECT u.id,'MESSAGE','Résultats disponibles','Les résultats de Yasmine Benyahia sont disponibles.',FALSE,NOW(),a.id FROM users_users u, consultations_appointment a JOIN users_patients p ON a.patient_id=p.id AND p.first_name='Yasmine' AND a.status='COMPLETED' AND a.date_rdv::date='2026-04-25' WHERE u.username='parent.sihem';
INSERT INTO notifications_notification (recipient_id,notif_type,title,message,is_read,created_at,appointment_id) SELECT u.id,'MESSAGE','Compte rendu consultation','Le compte rendu de Mohamed Dif du 28/04 est disponible.',FALSE,NOW(),a.id FROM users_users u, consultations_appointment a JOIN users_patients p ON a.patient_id=p.id AND p.first_name='Mohamed' AND a.status='COMPLETED' AND a.date_rdv::date='2026-04-28' WHERE u.username='parent.yacine';

-- ============================================================
-- STEP 15: MESSAGES (table: notifications_message)
-- ============================================================
INSERT INTO notifications_message (expediteur_id,destinataire_id,contenu,date_envoi,lu)
SELECT e.id,d.id,'Bonjour docteur, Rayan tousse encore beaucoup depuis hier soir, dois-je m inquiéter ?',NOW()-INTERVAL '2 days',TRUE FROM users_users e,users_users d WHERE e.username='parent.lina' AND d.username='dr.amrani';

INSERT INTO notifications_message (expediteur_id,destinataire_id,contenu,date_envoi,lu)
SELECT e.id,d.id,'Bonjour. Si fièvre > 39C ou respiration difficile, venez aux urgences. Sinon continuez le traitement.',NOW()-INTERVAL '2 days'+INTERVAL '1 hour',TRUE FROM users_users e,users_users d WHERE e.username='dr.amrani' AND d.username='parent.lina';

INSERT INTO notifications_message (expediteur_id,destinataire_id,contenu,date_envoi,lu)
SELECT e.id,d.id,'Docteur, la glycémie de Amine était à 3.2 g/L ce matin après le petit déjeuner, est-ce normal ?',NOW()-INTERVAL '1 day',FALSE FROM users_users e,users_users d WHERE e.username='parent.ahmed' AND d.username='dr.khelif';

INSERT INTO notifications_message (expediteur_id,destinataire_id,contenu,date_envoi,lu)
SELECT e.id,d.id,'Bonjour, est-il possible de décaler le RDV du 17 mai pour Wissam ? Nous ne pouvons pas nous libérer.',NOW()-INTERVAL '12 hours',FALSE FROM users_users e,users_users d WHERE e.username='parent.meriem' AND d.username='sec.karima';

-- ============================================================
-- STEP 16: TRACEACTION
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
--
-- VERIFICATION — run in pgAdmin Query Tool:
-- SELECT 'users_specialty' AS t, COUNT(*) FROM users_specialty
-- UNION ALL SELECT 'users_address',              COUNT(*) FROM users_address
-- UNION ALL SELECT 'users_users',                COUNT(*) FROM users_users
-- UNION ALL SELECT 'users_secretaire',           COUNT(*) FROM users_secretaire
-- UNION ALL SELECT 'users_doctors',              COUNT(*) FROM users_doctors
-- UNION ALL SELECT 'users_patients',             COUNT(*) FROM users_patients
-- UNION ALL SELECT 'consultations_appointment',  COUNT(*) FROM consultations_appointment
-- UNION ALL SELECT 'consultations_consultation', COUNT(*) FROM consultations_consultation
-- UNION ALL SELECT 'consultations_diagnostic',   COUNT(*) FROM consultations_diagnostic
-- UNION ALL SELECT 'consultations_traitement',   COUNT(*) FROM consultations_traitement
-- UNION ALL SELECT 'medical_allergie',           COUNT(*) FROM medical_allergie
-- UNION ALL SELECT 'medical_antecedent',         COUNT(*) FROM medical_antecedent
-- UNION ALL SELECT 'documents_document',         COUNT(*) FROM documents_document
-- UNION ALL SELECT 'notifications_notification', COUNT(*) FROM notifications_notification
-- UNION ALL SELECT 'notifications_message',      COUNT(*) FROM notifications_message
-- UNION ALL SELECT 'users_traceaction',          COUNT(*) FROM users_traceaction;
-- Expected: 3·36·39·2·5·50·19·8·8·13·20·29·3·7·4·16
-- ============================================================
