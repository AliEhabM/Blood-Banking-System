CREATE SEQUENCE bloodType_seq START WITH 1 INCREMENT BY 1 NOCYCLE NOCACHE;

CREATE TABLE BloodType(
  BTypeID Number(2),
  BTypeName nvarchar2(4),
  PRIMARY KEY (BTypeID)
);



CREATE SEQUENCE donorID_seq START WITH 1 INCREMENT BY 1 NOCYCLE NOCACHE;

CREATE TABLE Donor (
  DonorID Number(10),
  DonorFirstName nvarchar2(25),
  DonorLastName nvarchar2(25),
  DonorSSID nvarchar2(32) NOT NULL UNIQUE,
  PhoneNumber nvarchar2(16),
  BloodType Number(4) REFERENCES BloodType(BTypeID) NOT NULL,
  PRIMARY KEY (DonorID)
);



CREATE SEQUENCE empID_seq START WITH 1 INCREMENT BY 1 NOCYCLE NOCACHE;

CREATE TABLE Receptionist(
  EmpID Number(10),
  EmpFirstName nvarchar2(25),
  EmpLastName nvarchar2(25),
  EmpUname nvarchar2(16) UNIQUE NOT NULL,
  EmpPw nvarchar2(16) NOT NULL,
  HireDate date,
  PRIMARY KEY (EmpID)
);



CREATE SEQUENCE OrgID_seq START WITH 1 INCREMENT BY 1 NOCYCLE NOCACHE;

CREATE TABLE Organization(
  OrgID Number(10),
  OrgUname nvarchar2(16) UNIQUE NOT NULL,
  OrgPw nvarchar2(16) NOT NULL,
  OrgName nvarchar2(50),
  OrgLocation nvarchar2(50),
  PRIMARY KEY (OrgID)
);



CREATE SEQUENCE DrID_seq START WITH 1 INCREMENT BY 1 NOCYCLE NOCACHE;

CREATE TABLE Physician(
  DrID Number(10),
  DrFirstName nvarchar2(25),
  DrLastName nvarchar2(25),
  DrUname nvarchar2(16) UNIQUE NOT NULL,
  DrPw nvarchar2(16) NOT NULL,
  PRIMARY KEY (DrID)
);



CREATE SEQUENCE diseaseID_seq START WITH 1 INCREMENT BY 1 NOCYCLE NOCACHE;

CREATE TABLE Disease(
  DiseaseID Number(5),
  DiseaseName nvarchar2(25),
  PRIMARY KEY (DiseaseID)
);



CREATE TABLE TestsFor(
  TestResult CHAR(1),
  TestDate Date,
  DrID Number(10) REFERENCES Physician(DrID),
  DiseaseID Number(10) REFERENCES Disease(DiseaseID),
  DonorID Number(10) REFERENCES Donor(DonorID),
  PRIMARY KEY (DonorID, DiseaseID, TestDate)
);
/

CREATE SEQUENCE requests_seq START WITH 1 INCREMENT BY 1 NOCYCLE NOCACHE;

CREATE TABLE Requests(
  ReqID Number(10),
  ReqDate Date,
  ReqAmount Number(3),
  ReqBloodType Number(4) REFERENCES BloodType(BTypeID),
  ReqBy Number(10) REFERENCES Organization(OrgID),
  HandledBy Number(10) REFERENCES Receptionist(EmpID),
  PRIMARY KEY (ReqID)
);

CREATE SEQUENCE BagID_seq START WITH 1 INCREMENT BY 1 NOCYCLE NOCACHE;

CREATE TABLE BloodBagInfo(
  BagID Number(10),
  DonationDate Date,
  IssuedDate Date,
  IssuedTo Number(10) REFERENCES Requests(ReqID),
  DonorID Number(10) REFERENCES Donor(DonorID),
  PRIMARY KEY (BagID)
);


CREATE OR REPLACE TRIGGER EmpID_on_Insert
  BEFORE INSERT ON Receptionist
  FOR EACH ROW
    WHEN (new.EmpID IS NULL)
BEGIN
  :new.EmpID := EmpID_seq.nextval;
END;
/

CREATE OR REPLACE TRIGGER DonorID_on_Insert
  BEFORE INSERT ON Donor
  FOR EACH ROW
    WHEN (new.DonorID IS NULL)
BEGIN
  :new.DonorID := DonorID_seq.nextval;
END;
/

CREATE OR REPLACE TRIGGER BType_on_Insert
  BEFORE INSERT ON BloodType
  FOR EACH ROW
    WHEN (new.BTypeID IS NULL)
BEGIN
  :new.BTypeID := BloodType_seq.nextval;
END;
/

CREATE OR REPLACE TRIGGER OrgID_on_Insert
  BEFORE INSERT ON Organization
  FOR EACH ROW
    WHEN (new.OrgID IS NULL)
BEGIN
  :new.OrgID := OrgID_seq.nextval;
END;
/


CREATE OR REPLACE TRIGGER DrID_on_Insert
  BEFORE INSERT ON Physician
  FOR EACH ROW
    WHEN (new.DrID IS NULL)
BEGIN
  :new.DrID := DrID_seq.nextval;
END;
/


CREATE OR REPLACE TRIGGER DiseaseID_on_Insert
  BEFORE INSERT ON Disease
  FOR EACH ROW
    WHEN (new.DiseaseID IS NULL)
BEGIN
  :new.DiseaseID := DiseaseID_seq.nextval;
END;
/


CREATE OR REPLACE TRIGGER requests_on_Insert
  BEFORE INSERT ON Requests
  FOR EACH ROW
    WHEN (new.ReqID IS NULL)
BEGIN
  :new.ReqID := requests_seq.nextval;
END;
/


CREATE OR REPLACE TRIGGER BagID_on_Insert
  BEFORE INSERT ON BloodBagInfo
  FOR EACH ROW
  WHEN (new.BagID IS NULL)
BEGIN
  :new.BagID := bagID_seq.nextval;
END;
/