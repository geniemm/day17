create table test_func(id number, num varchar2(20));
insert into test_func values(1, '34.5678');
select * From test_func where id = 1;
-- round  : 소수점 수를 자르며 반올림 한다.
select round (num,2) from test_func where id =1;
-- num의 값 소수점 2번째 자리까지 반올림해라
select round (num/2 ,2) from test_func where id =1;

-- trunc : 소수점 수 버림
select trunc (num,2) from test_func where id =1;
insert into test_func values(2, '55');

-- mod : 나머지를 구해준다.
select num from test_func where id =2;
select mod(num,2) from test_func where id =2;

insert into test_func values (3,'12');
insert into test_func values (4,'123');
insert into test_func values (5,'1234');
insert into test_func values (6,'12345');
insert into test_func values (7,'123456');
insert into test_func values (8,'2468');
insert into test_func values (9,'1357');
insert into test_func values (10,'9999');


select * from test_func where mod(id,2)=1;

select id, round(num/2,2) from test_func where mod(id,2)=0;



insert into test_func values(11,'welcome to oralce');
select * from test_func where id =11;
-- 대문자 변환
select upper(num) from test_func where id =11;
-- 소문자 변환
select lower(num) from test_func where id =11;
-- 공백 다음 첫 문자는 대문자 변환
select initcap(num) from test_func where id =11;



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

select name from testcompany where upper(class) = 'MANAGER';
select * from testcompany where upper(class) = 'EMPLOYEE' and "연봉">=2800;
select initcap(name),trunc("연봉"/12)from testcompany;



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
select sum(score) from testclass; -- sum : 합을 구해주는 함수
select avg(score) from testclass;
select max(score),min(score) from testclass;
select count(class) from testClass ; -- null 값은 개수로 포함되지 않음
select count(*) from testClass ;

-- 확인되는 컬럼과 group의 컬럼과 동일한 컬럼이 들어와야 한다.
select class, sum(score) from testClass group by class
-- group으로 묶으면 where을 사용할 수 없고, having을 이용한다.
                    having sum(score) > 20;
                    
select class, count(*) from testClass group by class;
select class, avg(score) from testClass group by class order by avg(score)desc;
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

select * from testName;
select * from testlesson;
select * from testlesson,testName;

select * from testname N inner join testLesson L on N.id = L.id;
-- testname 을 N, testlesson L 이라는 별칭으로 사용하겠다.
-- L을 N.id로 합치겠다.
select N.*,L.lesson,l.score from testname N inner join testLesson L on N.id = L.id;

select n.*,l.lesson, l.score from testName N inner join testlesson
L on n.id = l.id where n.id ='홍길동';

select N.id, N.CLASS, sum(L.score), avg(L.score) from 
        testName N inner join testlesson L on N.id = L.id group by N.id,N.CLASS order by class asc;
        
        
-- foreign key : 무결성 제약 조건 성립 (외래키)

CREATE TABLE membership
(
    m_id      VARCHAR2(20)    NOT NULL, 
    m_pwd     VARCHAR2(20)    NOT NULL, 
    m_name    VARCHAR2(20)    NULL, 
    m_addr    VARCHAR2(20)    NULL, 
     PRIMARY KEY (m_id)
);

-- 테이블 생성 SQL - board
CREATE TABLE board
(
    b_num        NUMBER          NOT NULL, 
    b_id         VARCHAR2(20)    NULL, 
    b_title      VARCHAR2(20)    NULL, 
    b_content    VARCHAR2(20)    NULL, 
    b_date       DATE            NULL, 
     PRIMARY KEY (b_num)
);

select * from membership;
select * from board;

insert into board(b_num,b_id) values (1,'aaa');
delete from board;

ALTER TABLE board
    ADD CONSTRAINT fk_b_id_m_id2 FOREIGN KEY (b_id)
        REFERENCES membership (m_id) ;
        
CREATE SEQUENCE board_SEQ
START WITH 1
INCREMENT BY 1; -- board_SEQ++

--테이블 삭제할때 자식 삭제 후에 부모삭제
-- drop table membership;
drop table membership cascade constraints; -- 부모 테이블 강제삭제

insert into membership(m_id,m_pwd,m_name,m_addr) 
values ('aaa','aaa','홍길동','산골짜기');

insert into board(b_num,b_id,b_title,b_content,b_date)
values(board_SEQ.nextval,'aaa','제목','내용',sysdate);
-- 시퀀스 값은 자동으로 1씩 증가해준다.
-- 실패를 하더라도 시퀀스는 작동을 한다.(첫번째때 실패를 해서 이 값은 저장되지 않고 2부터 출력이 되었다.)
-- 시퀀스 쓰기 싫으면 서브쿼리를 이용해서
-- (select max(b_num) from board)+1 로 글번호를 저장할수 있다.

select * from all_sequences; -- 모든 계정에 대해서 보여줌
select * from all_sequences where sequence_owner = 'GENIEMM';
select * from user_sequences;

select * from all_constraints;
select * from all_constraints where owner = 'GENIEMM';
select * from user_constraints;

select * from membership;
select * from board;
delete from membership where m_id='aaa'; -- 제약조건때문에 삭제 불가능
alter table board drop constraint FK_B_ID_M_ID2;

ALTER TABLE board
    ADD CONSTRAINT fk_b_id_m_id2 FOREIGN KEY (b_id)
        REFERENCES membership (m_id)  on delete cascade;
    -- 부모에 있는 데이터가 삭제가되면 연결되어있는 자식 데이터도 같이 삭제해라

select * from membership;
select * from board;
delete from membership where m_id ='aaa';

select * from user_sequences;
drop SEQUENCE board_seq;


CREATE TABLE member
(
    m_id      VARCHAR2(20)    NOT NULL, 
    m_pwd     VARCHAR2(20)    NULL, 
    m_name    VARCHAR2(20)    NULL, 
    m_addr    VARCHAR2(20)    NULL, 
     PRIMARY KEY (m_id)
);

CREATE TABLE goods
(
    g_num          INT             NOT NULL, 
    g_id           VARCHAR2(20)    NULL, 
    g_name         VARCHAR2(20)    NULL, 
    g_price        INT             NULL, 
    g_count        INT             NULL, 
    g_price_sum    INT             NULL, 
    g_date         DATE            NULL, 
     PRIMARY KEY (g_num)
);

CREATE SEQUENCE goods_SEQ2
START WITH 1
INCREMENT BY 1;

ALTER TABLE goods
    ADD CONSTRAINT g_id_m_id2 FOREIGN KEY (g_id)
        REFERENCES member (m_id) ;
        
insert into member(m_id,m_pwd,m_name,m_addr) values ('aaa','aaa','홍길동','산골짜기');
insert into member(m_id,m_pwd,m_name,m_addr) values ('bbb','bbb','김개똥','개똥별');
insert into member(m_id,m_pwd,m_name,m_addr) values ('ccc','ccc','고길동','마포구');
insert into member(m_id,m_pwd,m_name,m_addr) values ('ddd','ddd','김말이','분식집');

select * from member;
select * from goods;

insert into goods values (goods_SEQ2.nextval,'aaa','운동화',75000,2,150000,sysdate);
insert into goods values (goods_SEQ2.nextval,'aaa','티셔츠',15000,5,75000,sysdate);
insert into goods values (goods_SEQ2.nextval,'bbb','가방',450000,1,450000,sysdate);
insert into goods values (goods_SEQ2.nextval,'bbb','책',35000,2,70000,sysdate);
delete from goods;
drop table goods;


select * from member N inner join goods L on N.m_id = L.g_id;

select N.m_id,N.m_name,L.g_name,L.g_price_sum from member N inner join goods L on N.m_id = L.g_id;

-- sum 함수를 이용하여 아이디별 총 금액을 구하시오
select N.m_id,N.m_name,N.m_addr,sum(L.g_price_sum) from member N inner join 
    goods L on N.m_id = L.g_id group by N.m_id,N.m_name,N.m_addr;

