--==================================================
--WEB계정
--==================================================
--member테이블 생성
create table member(
    memberid varchar2(15),
    password varchar2(300) not null,
    membername VARCHAR2(30) not null,
    gender char(1),
    age number,
    email varchar2(30),
    phone char(11) not null,
    address varchar2(300),
    hobby varchar2(300),
    enrolldate date default sysdate,
    constraint pk_member_id primary key(memberid),
    constraint ch_member_gender check(gender in ('M','F'))
);