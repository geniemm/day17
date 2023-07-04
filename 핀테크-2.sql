create table test_func( id number, num varchar2(20) );
insert into test_func values(1,'34.5678');
select * from test_func where id=1;
-- 소수점수를 자르며 반올림 된다.
select round(num, 2) from test_func where id=1;
select round(num/2, 2) from test_func where id=1;
-- 소수점수 버림
select trunc(num, 2)from test_func where id=2;
delete from test_func where id=2;

insert into test_func values(2, '55');
--mod 연산은 나머지를 구해준다
select num from test_func where id=2;
select mod(num, 2) from test_func where id=2;

insert into test_Func values(3,'77');
insert into test_Func values(4,'67.123');
insert into test_Func values(5,'123.123');
insert into test_Func values(6,'99');
insert into test_Func values(7,'99.456');
insert into test_Func values(8,'128');
insert into test_Func values(9,'123.777');
insert into test_Func values(10,'101.44');

select * from test_func where mod(id,2)=1;
select id, round(num/2, 2) from test_func where mod(id,2)=0;

insert into test_func values(11,'welcom To oracle');
select * from test_func where id=11;
-- 대문자변환
select upper(num) from test_func where id=11;
--소문자 변환
select lower(num) from test_func where id=11;
--공백 다음 첫 문자는 대문자 변환
select initcap(num) from test_func where id=11;

create table testCompany(
  name varchar2(20),
  연봉 varchar2(20),
  class varchar2(20)
);
insert into testCompany values('hong gil dong_M','3600','Manager');
insert into testCompany values('kim gea ddong_M','2555','ManaGer');
insert into testCompany values('Go gil dong_M','2800','ManaGER');
insert into testCompany values('hong gil dong_E','3111','EmpLoyee');
insert into testCompany values('kim gea ddong_E','2600','EmpLoYee');
insert into testCompany values('Go gil dong_E','2950','employee');


select * from testCompany where lower(class)='manager';
select * from testCompany where lower(class)='employee' 
                                                and 연봉>=2800;
select initcap(name),trunc(연봉/12,0),class from testCompany;


create table testClass(class varchar2(10), score number);
insert into testClass values('A반',11);
insert into testClass values('A반',12);
insert into testClass values('A반',13);
insert into testClass values('B반',21);
insert into testClass values('B반',22);
insert into testClass values('B반',23);
insert into testClass values('1',31);
insert into testClass values('1',32);
insert into testClass values('1',33);
insert into testClass values('',40);

select * from testclass;
select sum(score) from testclass;
select avg(score) from testclass;
select max(score), min(score) from testclass;
select count(class) from testclass; --null값은 개수로 포함되지 않음
select count(*) from testclass; -- 전체 개수를 얻어옴

--확인되는 컬럼과 group의 컬럼과 동일한 컬럼이 들어와야 한다
select class, sum(score) from testclass group by class;
-- 그룹으로 묶어서 조건을 사용할 경우 having절을 이용한다.
select class, sum(score) from testclass group by class
                                    having sum(score)>50;

select class, count(*) from testClass group by class;
select class, avg(score) from testClass 
                group by class order by avg(score) desc;
select class, max(score), min(score) from testClass group by class;


create table testName(id varchar2(20), class varchar2(20));
insert into testName values('홍길동','A반');
insert into testName values('김개똥','B반');
insert into testName values('고길동','C반');

create table testLesson(id varchar2(20), lesson varchar2(20), score number);
insert into testLesson values('홍길동','python',80);
insert into testLesson values('홍길동','java',90);
insert into testLesson values('홍길동','c언어',70);
insert into testLesson values('김개똥','server2012',70);
insert into testLesson values('김개똥','linux',90);
insert into testLesson values('고길동','jsp',100);

select * from testname;
select * from testlesson;
select * from testlesson, testname;

select * from testname N inner join testlesson L on N.id = L.id;
select N.*, L.score from testname N inner join testlesson L on N.id = L.id;

select N.*, L.score from testname N inner join testlesson L on N.id = L.id where score<90;




select N.id,N.class,L.lesson,L.score from 
    testName N inner join testlesson L on N.id=L.id 
                                        and N.id='홍길동';
-- on다음에 조건은 join의 조건이며 where절을 사용할 수 있다
select N.id,N.class,L.lesson,L.score from 
    testName N inner join testlesson L on N.id=L.id 
                                        where N.id='홍길동';
select N.id, N.CLASS, sum(L.score), avg(L.score) from 
        testName N inner join testlesson L on N.id=L.id 
                    group by N.id,N.CLASS order by class asc;

-- foreign key : 무결성 제약조건 성립
CREATE TABLE membership
(
    m_id      VARCHAR2(20)    NOT NULL, 
    m_pwd     VARCHAR2(20)   not NULL, 
    m_name    VARCHAR2(20)    NULL, 
    m_addr    VARCHAR2(20)    NULL, 
     PRIMARY KEY (m_id)
);

CREATE TABLE board
(
    b_num        INT             NOT NULL, 
    b_id         VARCHAR2(20)    NULL, 
    b_title      VARCHAR2(20)    NULL, 
    b_content    VARCHAR2(20)    NULL, 
    b_date       DATE            NULL, 
     PRIMARY KEY (b_num)
);

select * from membership;
select * from board;
insert into board(b_num,b_id) values(1,'aaa');
delete from board;

ALTER TABLE board
    ADD CONSTRAINT fk_b_id_m_id2 FOREIGN KEY (b_id)
        REFERENCES membership (m_id) ;
CREATE SEQUENCE board_SEQ
START WITH 1
INCREMENT BY 1;  -- board_SEQ++

drop table membership;
drop table membership cascade constraints;

insert into membership(m_id, m_pwd, m_name, m_addr)
                values('aaa','aaa','홍길동','산골짜기');
insert into board(b_num,b_id, b_title, b_content, b_date)
    values(board_SEQ.nextval, 'aaa','제목','내용', sysdate);
select * from board;

insert into board(b_num,b_id, b_title, b_content, b_date)
    values( (select max(b_num) from board)+1 , 
                            'aaa','제목','내용', sysdate);


select * from all_sequences;--모든 계정의 시퀀스
select * from all_sequences where sequence_owner='JAVA';
select * from user_sequences;--로그인한 계정의 시퀀스

select * from all_constraints;
select * from all_constraints where owner='JAVA';
select * from user_constraints;

select * from membership;
select * from board;
delete from membership where m_id='aaa';
alter table board drop constraint FK_B_ID_M_ID2;

ALTER TABLE board
    ADD CONSTRAINT fk_b_id_m_id2 FOREIGN KEY (b_id)
        REFERENCES membership (m_id) on DELETE cascade;

select * from membership;
select * from board;
delete from membership where m_id='aaa';

select * from user_sequences;
drop sequence BOARD_SEQ;

