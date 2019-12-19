--=======================================
--WEB계정
--=======================================
--member테이블 생성
create table member(
    memberid varchar2(15),
    password varchar2(300) not null,
    membername varchar2(30) not null,
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

insert into member
values('abcde','1234','알파치노','M',45, 
      'abcde@naver.com','01012341234','서울시 강남구 역삼동', '운동,등산,독서',default);
insert into member
values('honggd','1234','홍길동','M',35, 
      'honggd@naver.com','01012341234','서울시 중구 동대문동', '등산,독서',default);
insert into member
values('sinsa','1234','신사임당','F',53, 
      'sinsa@naver.com','01012341234','서울시 관악구 인헌동', '독서',default);
--관리자계정 추가
insert into member
values('admin','1234','관리자','M',16, 
      'admin@iei.or.kr','01012341234','서울시 강동구', '게임,독서',default);

--조회
select * from member;


--커밋
commit;

--기존회원들 비밀번호 모두 변경
update member 
set password = '1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==';
commit;


--회원관리 페이징처리
--조회
select * from member;

--페이징쿼리
--rownum이용방법
select *
from(
    select rownum rnum, V.*
    from(
        select *
        from member
        order by enrolldate desc) V) V
where rnum between ? and ?;

--윈도우함수 rank
select *
from(
    select rank() over(order by enrolldate desc) rnum,
          M.*
    from member M) V
where rnum between ? and ?;

--select * from( select rank() over(order by enrolldate desc) rnum, M.* from member M) V where rnum between ? and ?;


--회원아이디
select *
from(
    select rank() over(order by enrolldate desc) rnum,
          M.*
    from member M
    where memberid like '%e%') V 
where rnum between 11 and 20;

--select * from( select rank() over(order by enrolldate desc) rnum, M.* from member M where memberid like ? ) V  where rnum between ? and ?


--게시판생성
create table board(
    board_no number,
    board_title varchar2(100),
    board_writer varchar2(15),
    board_content varchar2(4000),
    board_original_filename varchar2(100),
    board_renamed_filename varchar2(100),
    board_date date default sysdate,
    board_readcount number default 0,
    constraint pk_board_no primary key(board_no),
    constraint fk_board_writer foreign key(board_writer) 
                            references member(memberid) 
                            on delete set null
);

create sequence seq_board_no;

Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 1','abcd','반갑습니다',null,null,to_date('18/01/11','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 2','bcde','반갑습니다',null,null,to_date('18/02/12','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 3','cdef','반갑습니다',null,null,to_date('18/02/13','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 4','defg','반갑습니다',null,null,to_date('18/02/14','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 5','efgh','반갑습니다',null,null,to_date('18/02/15','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 6','fghi','반갑습니다',null,null,to_date('18/02/16','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 7','ghij','반갑습니다',null,null,to_date('18/02/17','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 8','hijk','반갑습니다',null,null,to_date('18/02/18','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 9','ijkl','반갑습니다',null,null,to_date('18/02/19','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 10','jklm','반갑습니다',null,null,to_date('18/02/20','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 11','klmn','반갑습니다',null,null,to_date('18/03/11','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 12','lmno','반갑습니다',null,null,to_date('18/03/12','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 13','mnop','반갑습니다',null,null,to_date('18/03/13','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 14','nopq','반갑습니다',null,null,to_date('18/03/14','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 15','opqr','반갑습니다',null,null,to_date('18/03/15','RR/MM/DD'),0);


Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 16','pqrs','반갑습니다',null,null,to_date('18/03/16','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 17','qrst','반갑습니다',null,null,to_date('18/03/17','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 18','rstu','반갑습니다',null,null,to_date('18/03/18','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 19','stuv','반갑습니다',null,null,to_date('18/03/19','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 20','tuvw','반갑습니다',null,null,to_date('18/03/20','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 21','uvwx','반갑습니다',null,null,to_date('18/04/01','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 22','vwxy','반갑습니다',null,null,to_date('18/04/02','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 23','wxyz','반갑습니다',null,null,to_date('18/04/03','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 24','admin','반갑습니다',null,null,to_date('18/04/04','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 25','abcde','반갑습니다',null,null,to_date('18/04/05','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 26','admin','반갑습니다',null,null,to_date('18/04/06','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 27','abcde','반갑습니다',null,null,to_date('18/04/07','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 28','admin','반갑습니다',null,null,to_date('18/04/08','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 29','abcde','반갑습니다',null,null,to_date('18/04/09','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 30','admin','반갑습니다',null,null,to_date('18/04/10','RR/MM/DD'),0);



Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 31','abcd','반갑습니다',null,null,to_date('18/01/11','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 32','bcde','반갑습니다',null,null,to_date('18/02/12','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 33','cdef','반갑습니다',null,null,to_date('18/02/13','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 34','defg','반갑습니다',null,null,to_date('18/02/14','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 35','efgh','반갑습니다',null,null,to_date('18/02/15','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 36','fghi','반갑습니다',null,null,to_date('18/02/16','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 37','ghij','반갑습니다',null,null,to_date('18/02/17','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 38','hijk','반갑습니다',null,null,to_date('18/02/18','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 39','ijkl','반갑습니다',null,null,to_date('18/02/19','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 40','jklm','반갑습니다',null,null,to_date('18/02/20','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 41','klmn','반갑습니다',null,null,to_date('18/03/11','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 42','lmno','반갑습니다',null,null,to_date('18/03/12','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 43','mnop','반갑습니다',null,null,to_date('18/03/13','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 44','nopq','반갑습니다',null,null,to_date('18/03/14','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 45','opqr','반갑습니다',null,null,to_date('18/03/15','RR/MM/DD'),0);


Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 46','pqrs','반갑습니다',null,null,to_date('18/03/16','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 47','qrst','반갑습니다',null,null,to_date('18/03/17','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 48','rstu','반갑습니다',null,null,to_date('18/03/18','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 49','stuv','반갑습니다',null,null,to_date('18/03/19','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 50','tuvw','반갑습니다',null,null,to_date('18/03/20','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 51','uvwx','반갑습니다',null,null,to_date('18/04/01','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 52','vwxy','반갑습니다',null,null,to_date('18/04/02','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 53','wxyz','반갑습니다',null,null,to_date('18/04/03','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 54','admin','반갑습니다',null,null,to_date('18/04/04','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 55','abcde','반갑습니다',null,null,to_date('18/04/05','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 56','admin','반갑습니다',null,null,to_date('18/04/06','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 57','abcde','반갑습니다',null,null,to_date('18/04/07','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 58','admin','반갑습니다',null,null,to_date('18/04/08','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 59','abcde','반갑습니다',null,null,to_date('18/04/09','RR/MM/DD'),0);
Insert into WEB.BOARD (BOARD_NO,BOARD_TITLE,BOARD_WRITER,BOARD_CONTENT,BOARD_ORIGINAL_FILENAME,BOARD_RENAMED_FILENAME,BOARD_DATE,BOARD_READCOUNT) values (SEQ_BOARD_NO.nextval,'안녕하세요, 게시판입니다 - 60','admin','반갑습니다',null,null,to_date('18/04/10','RR/MM/DD'),0);

select * from board;
commit;

--페이징 쿼리
select *
from(
select rank() over(order by board_no desc) rnum,
      B.*
from board B) V
where rnum between 6 and 10;

--select * from( select rank() over(order by board_no desc) rnum, B.* from board B) V where rnum between ? and ?

select * from board order by board_date desc;


--게시판 댓글테이블 생성
create table board_comment(
    board_comment_no number,                    --댓글고유번호
    board_comment_level number default 1,           --댓글(1)/대댓글(2)여부
    board_comment_writer varchar2(15),
    board_comment_content varchar2(2000),
    board_ref number,                            --게시글 번호
    board_comment_ref number,                   --대댓글인 경우 참조하고 있는 댓글 번호, 댓글인 경우 null
    board_comment_date date default sysdate,
    constraint pk_board_comment_no primary key(board_comment_no),
    constraint fk_board_comment_writer foreign key(board_comment_writer)
                                    references member(memberid) 
                                    on delete set null,
    constraint fk_board_ref foreign key(board_ref)
                         references board(board_no) 
                         on delete cascade,
    constraint fk_board_comment_ref foreign key(board_comment_ref)
                                  references board_comment(board_comment_no)
                                  on delete cascade
);

create sequence seq_board_comment;

--계층형쿼리
--댓글/대댓글 테스트 레코드 추가
--1.댓글
insert into board_comment 
values(SEQ_BOARD_COMMENT.nextval, default, 'opqr', '글 잘읽었습니다', 104, null, default);
insert into board_comment 
values(SEQ_BOARD_COMMENT.nextval, default, 'efgh', '좋은 정보 감사합니다.', 104, null, default);
insert into board_comment 
values(SEQ_BOARD_COMMENT.nextval, default, 'honggd', 'ㅋㅋㅋㅋㅋㅋㅋ', 104, null, default);

select * from board_comment;

--2. 대댓글
-- 댓글1번에 대한 대댓글
insert into board_comment 
values(SEQ_BOARD_COMMENT.nextval, 2, 'stuv', '좋은 글인거 같습니다', 104, 1, default);
insert into board_comment 
values(SEQ_BOARD_COMMENT.nextval, 2, 'admin', '읽어주셔서 감사합니다.', 104, 1, default);
---댓글2번에 대한 대댓글
insert into board_comment 
values(SEQ_BOARD_COMMENT.nextval, 2, 'wxyz', '좋', 104, 2, default);
insert into board_comment 
values(SEQ_BOARD_COMMENT.nextval, 2, 'admin', '은', 104, 2, default);
insert into board_comment 
values(SEQ_BOARD_COMMENT.nextval, 2, 'honggd', '정', 104, 2, default);
insert into board_comment 
values(SEQ_BOARD_COMMENT.nextval, 2, 'hijk', '보', 104, 2, default);

commit;

--기준컬럼을 가지고 행간의 수직적 관계를 표현가능
--조직도, 메뉴, 답변형게시판등에서 사용 가능

--start with : 부모행(루트노드)
--connect by : 부모행-자식행 관계 설정
--prior : connect by절에서 부모행을 가리키는 키워드
--level : 의사컬럼. 계층정보를 나타냄. select, where, order by절에서 사용가능

select *
from board_comment 
where board_ref = 104
start with board_comment_level = 1
connect by board_comment_ref = prior board_comment_no
order siblings by board_comment_no asc;

--level 사용예
select lpad(' ',(level-1)*5) || a.board_comment_content, 
      a.board_comment_no,
      a.board_comment_level, 
      a.board_comment_ref
from board_comment A
where board_ref = 104
start with board_comment_level = 1
connect by board_comment_ref = prior board_comment_no
order siblings by board_comment_no asc;

--select * from board_comment where board_ref = ? start with board_comment_level = 1 connect by board_comment_ref = prior board_comment_no order siblings by board_comment_no asc


--=======================================================
-- ajax 검색어 자동완성 실습
--=======================================================
create table classmate(
    name varchar2(30) not null
);
insert into classmate values('김민호');
insert into classmate values('김효정');
insert into classmate values('민병준');
insert into classmate values('서경환');
insert into classmate values('신윤지');
insert into classmate values('신하진');
insert into classmate values('오근호');
insert into classmate values('유찬호');
insert into classmate values('유혜민');
insert into classmate values('이단비');

insert into classmate values('이도현');
insert into classmate values('이소현');
insert into classmate values('이정훈');
insert into classmate values('이주현');
insert into classmate values('이창택');
insert into classmate values('이하은');
insert into classmate values('임지은');
insert into classmate values('임하라');
insert into classmate values('장예찬');
insert into classmate values('전희진');
																															
insert into classmate values('정영균');
insert into classmate values('정주영');
insert into classmate values('정진섭');
insert into classmate values('주보라');
insert into classmate values('최주영');
insert into classmate values('최현규');
insert into classmate values('허준');
insert into classmate values('홍성준');

select * from classmate;
commit;

--친구 검색
select *
from classmate
where name like '%이%';

select *
from classmate
where name like '%진%';




