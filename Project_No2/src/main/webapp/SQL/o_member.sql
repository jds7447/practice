CREATE TABLE O_MEMBER (
    ID VARCHAR2(10),
    PASS VARCHAR2(10) NOT NULL,
    NAME VARCHAR2(30) NOT NULL,
    PHONENUM VARCHAR2(50),
    BIRTHDAY VARCHAR2(30),
    GENDER VARCHAR2(1) CONSTRAINT EMP07_GENDER_CK CHECK (GENDER IN('M', 'F')),
    POSTCODE VARCHAR2(50),
    ADDRESS VARCHAR2(100),
    REGIDATE DATE DEFAULT SYSDATE NOT NULL,  --가입날짜
    PRIMARY KEY(ID, PHONENUM) 
);