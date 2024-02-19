--Drop table patient if already existing
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PATIENT CASCADE CONSTRAINT PURGE';
	EXCEPTION
    WHEN OTHERS THEN
    NULL;
END;
/
--Create table patient
create table patient (
pat_id varchar2(10 CHAR),
pat_name varchar2(60 CHAR),
pat_gender varchar2(2 CHAR),
pat_address varchar2(100 CHAR),
pat_number number(11,0),
pat_doc_code varchar2(10 CHAR),
constraint pk_patient primary key (pat_id),
constraint uq_doc_code unique (pat_doc_code)
);
/

--Drop table patient_diagnosis if already existing
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE PATIENT_DIAGNOSIS CASCADE CONSTRAINT PURGE';
	EXCEPTION
    WHEN OTHERS THEN
    NULL;
END;
/
--Create table patient_diagnosis
create table patient_diagnosis(
Diag_ID varchar2(10 CHAR),
diag_details varchar2(200 CHAR),
diag_remarks varchar2(200 CHAR),
diag_date date,
pat_id varchar2(10 CHAR),
constraint pk_patient_diagnosis primary key  (diag_id),
constraint fk_pat_id foreign key (pat_id)
references patient(pat_id)
);
/

--Drop table doctor if already existing
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE DOCTOR CASCADE CONSTRAINT PURGE';
	EXCEPTION
    WHEN OTHERS THEN
    NULL;
END;
/
--create table doctor
create table doctor(
doc_code varchar2(10 CHAR),
doc_name varchar2(60 CHAR),
doc_gender varchar2(2 CHAR),
doc_address varchar2(200 CHAR),
doc_designation varchar2(30 CHAR),
doc_number number(11,0),
constraint pk_doctor primary key (doc_code),
constraint fk_doc_code foreign key (doc_code)
references patient(pat_doc_code)
);
/

--Drop table bill if already existing
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE BILL CASCADE CONSTRAINT PURGE';
	EXCEPTION
    WHEN OTHERS THEN
    NULL;
END;
/
--create table bill
create table bill(
bill_no integer,
pat_id varchar2(10 CHAR),
pat_name varchar2(60 CHAR),
pat_gender varchar2(2 CHAR),
pat_address varchar2(100 CHAR),
doc_name varchar2(60 CHAR),
amount NUMBER(19,9),
constraint pk_bill primary key (bill_no),
constraint fk_bill_pat_id foreign key (pat_id)
references patient(pat_id)
);
/


-- Patient entries
INSERT INTO PATIENT VALUES ('P101','John Smith','M','123 Main St, Cityville',1112223333,'D011');
INSERT INTO PATIENT VALUES ('P102','Alice Johnson','F','456 Oak St, Townsville',4445556666,'D014');
INSERT INTO PATIENT VALUES ('P103','Michael Davis','M','789 Pine St, Villagetown',7778889999,'D013');
INSERT INTO PATIENT VALUES ('P104','Emily White','F','101 Cedar St, Hamletville',2223334444,'D015');
INSERT INTO PATIENT VALUES ('P105','Daniel Brown','M','202 Maple St, Countryside',5556667777,'D012');

-- Patient_diagnosis entries
INSERT INTO PATIENT_DIAGNOSIS VALUES ('DIAG101','Fever and flu symptoms','Prescribed antibiotics',SYSDATE,'P101');
INSERT INTO PATIENT_DIAGNOSIS VALUES ('DIAG102','Broken arm','Recommending a cast and pain medication',SYSDATE,'P102');
INSERT INTO PATIENT_DIAGNOSIS VALUES ('DIAG103','Allergic reaction','Avoid allergen and prescribed antihistamines',SYSDATE,'P103');
INSERT INTO PATIENT_DIAGNOSIS VALUES ('DIAG104','Migraine headaches','Prescribed pain relievers and lifestyle changes',SYSDATE,'P104');
INSERT INTO PATIENT_DIAGNOSIS VALUES ('DIAG105','Routine checkup','No significant health issues detected',SYSDATE,'P105');

-- Doctor entries
INSERT INTO DOCTOR VALUES ('D011','Dr. Jennifer Miller','F','Hospital Ave, Health City','General Practitioner',9876543210);
INSERT INTO DOCTOR VALUES ('D012','Dr. Robert Wilson','M','Cardio Center, Heartville','Cardiologist',8765432109);
INSERT INTO DOCTOR VALUES ('D013','Dr. Olivia Davis','F','Dermatology Plaza, Skincare City','Dermatologist',7654321098);
INSERT INTO DOCTOR VALUES ('D014','Dr. Ethan Taylor','M','Oral Care St, Dentaltown','Dentist',6543210987);
INSERT INTO DOCTOR VALUES ('D015','Dr. Sophia Parker','F','Neurological Institute, Brainville','Neurologist',5432109876);
