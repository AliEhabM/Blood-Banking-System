-- Medical Organizations and Hospitals
INSERT INTO Organization (OrgUname, OrgPw, OrgName, OrgLocation)
VALUES ('hc_clinic', 'C1in!c@123', 'Healthcare Clinic', 'New York');

INSERT INTO Organization (OrgUname, OrgPw, OrgName, OrgLocation)
VALUES ('med_research', 'R3search#456', 'Medical Research Institute', 'Boston');

INSERT INTO Organization (OrgUname, OrgPw, OrgName, OrgLocation)
VALUES ('city_hospital', 'H0sp!tal*789', 'City Hospital', 'Chicago');

INSERT INTO Organization (OrgUname, OrgPw, OrgName, OrgLocation)
VALUES ('cardio_center', 'Card!0@123', 'Cardiovascular Center', 'Los Angeles');

INSERT INTO Organization (OrgUname, OrgPw, OrgName, OrgLocation)
VALUES ('ped_care', 'P3di@tric#456', 'Pediatric Care Foundation', 'San Francisco');

INSERT INTO Organization (OrgUname, OrgPw, OrgName, OrgLocation)
VALUES ('onco_institute', '0ncol0gy*789', 'Oncology Institute', 'Houston');

INSERT INTO Organization (OrgUname, OrgPw, OrgName, OrgLocation)
VALUES ('mental_health', 'M3nt@l@123', 'Mental Health Organization', 'Philadelphia');

INSERT INTO Organization (OrgUname, OrgPw, OrgName, OrgLocation)
VALUES ('geri_center', 'G3ri@tr!c#456', 'Geriatric Care Center', 'Miami');

INSERT INTO Organization (OrgUname, OrgPw, OrgName, OrgLocation)
VALUES ('ortho_surgeon', 'Orth0@123', 'Orthopedic Surgeon Clinic', 'Atlanta');

INSERT INTO Organization (OrgUname, OrgPw, OrgName, OrgLocation)
VALUES ('emer_med', 'Em3rgency#789', 'Emergency Medical Services', 'Dallas');

INSERT INTO Organization (OrgUname, OrgPw, OrgName, OrgLocation)
VALUES ('cancer_support', 'C@nc3r!23', 'Cancer Support Services', 'Seattle');

INSERT INTO Organization (OrgUname, OrgPw, OrgName, OrgLocation)
VALUES ('nursing_home', 'Nurs!ng#456', 'Serenity Nursing Home', 'Denver');

INSERT INTO Organization (OrgUname, OrgPw, OrgName, OrgLocation)
VALUES ('rehab_center', 'R3h@b!l1t@t!0n', 'Rehabilitation Center', 'Phoenix');

INSERT INTO Organization (OrgUname, OrgPw, OrgName, OrgLocation)
VALUES ('health_tech', 'H34lthT3ch#456', 'Health Tech Innovations', 'San Diego');

INSERT INTO Organization (OrgUname, OrgPw, OrgName, OrgLocation)
VALUES ('mobile_clinic', 'M0b!l3Cl!n1c@123', 'Mobile Health Clinic', 'Detroit');





INSERT INTO Physician (DrFirstName, DrLastName, DrUName, DrPw)
VALUES ('Tomas', 'Perkins', 'tomaPerkins', 'GenericDoctor');

INSERT INTO Physician (DrFirstName, DrLastName, DrUName, DrPw)
VALUES ('Mihaelo', 'Michael', 'mikeMihaelo', 'GenericDoctor');

INSERT INTO Physician (DrFirstName, DrLastName, DrUName, DrPw)
VALUES ('Abduljabbar', 'Abdulrahim', 'abdulabdul', 'GenericDoctor');

INSERT INTO Physician (DrFirstName, DrLastName, DrUName, DrPw)
VALUES ('Medhat', 'Shalaby', 'yanharAbyad', 'yallaYSalah');



INSERT INTO Receptionist (EmpFirstName, EmpLastName, EmpUName, EmpPw, HireDate)
VALUES ('Karim', 'Saad', 'kimoZ', '123employee', TO_CHAR(CURRENT_DATE, 'DD-MON-YY'));

INSERT INTO Receptionist (EmpFirstName, EmpLastName, EmpUName, EmpPw, HireDate)
VALUES ('Ali', 'Eyad', 'notAliEhab', '123employee', TO_CHAR(CURRENT_DATE, 'DD-MON-YY'));

INSERT INTO Receptionist (EmpFirstName, EmpLastName, EmpUName, EmpPw, HireDate)
VALUES ('Steven', 'Steven', 'doubleSteven', '123employee', TO_CHAR(CURRENT_DATE, 'DD-MON-YY'));

INSERT INTO Receptionist (EmpFirstName, EmpLastName, EmpUName, EmpPw, HireDate)
VALUES ('Abdelbaset', 'Hammooda', 'ya3ene', '123employee', TO_CHAR(CURRENT_DATE, 'DD-MON-YY'));


INSERT INTO BloodType (BTypeName) VALUES('A+');

INSERT INTO BloodType (BTypeName) VALUES('A-');

INSERT INTO BloodType (BTypeName) VALUES('B+');

INSERT INTO BloodType (BTypeName) VALUES('B-');

INSERT INTO BloodType (BTypeName) VALUES('AB+');

INSERT INTO BloodType (BTypeName) VALUES('AB-');

INSERT INTO BloodType (BTypeName) VALUES('O+');

INSERT INTO BloodType (BTypeName) VALUES('O-');



INSERT INTO Disease (DiseaseName) VALUES ('HIV-1');

INSERT INTO Disease (DiseaseName) VALUES ('HIV-2');

INSERT INTO Disease (DiseaseName) VALUES ('Zika Virus');

INSERT INTO Disease (DiseaseName) VALUES ('Hepatitis B');

INSERT INTO Disease (DiseaseName) VALUES ('Hepatitis C');

INSERT INTO Disease (DiseaseName) VALUES ('HTLV-I');

INSERT INTO Disease (DiseaseName) VALUES ('HTLV-II');

INSERT INTO Disease (DiseaseName) VALUES ('West Nile virus');

INSERT INTO Disease (DiseaseName) VALUES ('Cytomegalovirus');