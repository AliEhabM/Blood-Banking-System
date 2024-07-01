CREATE USER bloodBank IDENTIFIED BY 123;

GRANT ALL PRIVILEGES TO bloodBank;

CREATE ROLE receptionist;
create user recept_user1 identified by 123;

GRANT SELECT, INSERT ON bloodBank.donor TO receptionist;
GRANT SELECT, INSERT, UPDATE ON bloodBank.requests TO receptionist;
GRANT SELECT ON bloodBank.bloodType TO receptionist;
GRANT SELECT ON bloodbank.organization TO receptionist;
GRANT SELECT ON bloodbank.DISEASE TO receptionist;
GRANT INSERT ON bloodbank.testsfor TO receptionist;
GRANT SELECT, UPDATE ON bloodBank.BloodBagInfo TO receptionist;
GRANT receptionist TO recept_user1;

CREATE USER org_user1 IDENTIFIED BY 123;
CREATE ROLE org;

GRANT SELECT, INSERT, DELETE ON bloodBank.requests TO org;
GRANT SELECT ON bloodBank.bloodType TO org;

CREATE USER doctor IDENTIFIED BY 123;
CREATE ROLE physic;

GRANT SELECT, UPDATE ON bloodBank.testsfor TO physic;
GRANT SELECT ON bloodBank.donor TO physic;
GRANT SELECT ON bloodbank.DIsease to physic;
GRANT SELECT, UPDATE ON bloodbank.testsfor TO physic;
GRANT SELECT ON bloodBank.bloodType TO physic;
GRANT SELECT, UPDATE ON bloodBank.bloodbaginfo TO physic;


GRANT CREATE SESSION TO physic, org, receptionist;

GRANT physic to doctor;
GRANT org TO org_user1;
GRANT receptionist TO recept_user1;

