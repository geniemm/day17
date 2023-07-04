create table test_func(id number, num varchar2(20));
insert into test_func values(1, '34.5678');
select * From test_func where id = 1;
-- round  : �Ҽ��� ���� �ڸ��� �ݿø� �Ѵ�.
select round (num,2) from test_func where id =1;
-- num�� �� �Ҽ��� 2��° �ڸ����� �ݿø��ض�
select round (num/2 ,2) from test_func where id =1;

-- trunc : �Ҽ��� �� ����
select trunc (num,2) from test_func where id =1;
insert into test_func values(2, '55');

-- mod : �������� �����ش�.
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
-- �빮�� ��ȯ
select upper(num) from test_func where id =11;
-- �ҹ��� ��ȯ
select lower(num) from test_func where id =11;
-- ���� ���� ù ���ڴ� �빮�� ��ȯ
select initcap(num) from test_func where id =11;



create table testCompany(
  name varchar2(20),
  ���� varchar2(20),
  class varchar2(20)
);
insert into testCompany values('hong gil dong_M','3600','Manager');
insert into testCompany values('kim gea ddong_M','2555','ManaGer');
insert into testCompany values('Go gil dong_M','2800','ManaGER');
insert into testCompany values('hong gil dong_E','3111','EmpLoyee');
insert into testCompany values('kim gea ddong_E','2600','EmpLoYee');
insert into testCompany values('Go gil dong_E','2950','employee');

select name from testcompany where upper(class) = 'MANAGER';
select * from testcompany where upper(class) = 'EMPLOYEE' and "����">=2800;
select initcap(name),trunc("����"/12)from testcompany;



create table testClass(class varchar2(10), score number);
insert into testClass values('A��',11);
insert into testClass values('A��',12);
insert into testClass values('A��',13);
insert into testClass values('B��',21);
insert into testClass values('B��',22);
insert into testClass values('B��',23);
insert into testClass values('1',31);
insert into testClass values('1',32);
insert into testClass values('1',33);
insert into testClass values('',40);

select * from testclass;
select sum(score) from testclass; -- sum : ���� �����ִ� �Լ�
select avg(score) from testclass;
select max(score),min(score) from testclass;
select count(class) from testClass ; -- null ���� ������ ���Ե��� ����
select count(*) from testClass ;

-- Ȯ�εǴ� �÷��� group�� �÷��� ������ �÷��� ���;� �Ѵ�.
select class, sum(score) from testClass group by class
-- group���� ������ where�� ����� �� ����, having�� �̿��Ѵ�.
                    having sum(score) > 20;
                    
select class, count(*) from testClass group by class;
select class, avg(score) from testClass group by class order by avg(score)desc;
select class, max(score), min(score) from testClass group by class;



create table testName(id varchar2(20), class varchar2(20));
insert into testName values('ȫ�浿','A��');
insert into testName values('�谳��','B��');
insert into testName values('��浿','C��');

create table testLesson(id varchar2(20), lesson varchar2(20), score number);
insert into testLesson values('ȫ�浿','python',80);
insert into testLesson values('ȫ�浿','java',90);
insert into testLesson values('ȫ�浿','c���',70);
insert into testLesson values('�谳��','server2012',70);
insert into testLesson values('�谳��','linux',90);
insert into testLesson values('��浿','jsp',100);

select * from testName;
select * from testlesson;
select * from testlesson,testName;

select * from testname N inner join testLesson L on N.id = L.id;
-- testname �� N, testlesson L �̶�� ��Ī���� ����ϰڴ�.
-- L�� N.id�� ��ġ�ڴ�.
select N.*,L.lesson,l.score from testname N inner join testLesson L on N.id = L.id;

select n.*,l.lesson, l.score from testName N inner join testlesson
L on n.id = l.id where n.id ='ȫ�浿';

select N.id, N.CLASS, sum(L.score), avg(L.score) from 
        testName N inner join testlesson L on N.id = L.id group by N.id,N.CLASS order by class asc;
        
        
-- foreign key : ���Ἲ ���� ���� ���� (�ܷ�Ű)

CREATE TABLE membership
(
    m_id      VARCHAR2(20)    NOT NULL, 
    m_pwd     VARCHAR2(20)    NOT NULL, 
    m_name    VARCHAR2(20)    NULL, 
    m_addr    VARCHAR2(20)    NULL, 
     PRIMARY KEY (m_id)
);

-- ���̺� ���� SQL - board
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

--���̺� �����Ҷ� �ڽ� ���� �Ŀ� �θ����
-- drop table membership;
drop table membership cascade constraints; -- �θ� ���̺� ��������

insert into membership(m_id,m_pwd,m_name,m_addr) 
values ('aaa','aaa','ȫ�浿','���¥��');

insert into board(b_num,b_id,b_title,b_content,b_date)
values(board_SEQ.nextval,'aaa','����','����',sysdate);
-- ������ ���� �ڵ����� 1�� �������ش�.
-- ���и� �ϴ��� �������� �۵��� �Ѵ�.(ù��°�� ���и� �ؼ� �� ���� ������� �ʰ� 2���� ����� �Ǿ���.)
-- ������ ���� ������ ���������� �̿��ؼ�
-- (select max(b_num) from board)+1 �� �۹�ȣ�� �����Ҽ� �ִ�.

select * from all_sequences; -- ��� ������ ���ؼ� ������
select * from all_sequences where sequence_owner = 'GENIEMM';
select * from user_sequences;

select * from all_constraints;
select * from all_constraints where owner = 'GENIEMM';
select * from user_constraints;

select * from membership;
select * from board;
delete from membership where m_id='aaa'; -- �������Ƕ����� ���� �Ұ���
alter table board drop constraint FK_B_ID_M_ID2;

ALTER TABLE board
    ADD CONSTRAINT fk_b_id_m_id2 FOREIGN KEY (b_id)
        REFERENCES membership (m_id)  on delete cascade;
    -- �θ� �ִ� �����Ͱ� �������Ǹ� ����Ǿ��ִ� �ڽ� �����͵� ���� �����ض�

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
        
insert into member(m_id,m_pwd,m_name,m_addr) values ('aaa','aaa','ȫ�浿','���¥��');
insert into member(m_id,m_pwd,m_name,m_addr) values ('bbb','bbb','�谳��','���˺�');
insert into member(m_id,m_pwd,m_name,m_addr) values ('ccc','ccc','��浿','������');
insert into member(m_id,m_pwd,m_name,m_addr) values ('ddd','ddd','�踻��','�н���');

select * from member;
select * from goods;

insert into goods values (goods_SEQ2.nextval,'aaa','�ȭ',75000,2,150000,sysdate);
insert into goods values (goods_SEQ2.nextval,'aaa','Ƽ����',15000,5,75000,sysdate);
insert into goods values (goods_SEQ2.nextval,'bbb','����',450000,1,450000,sysdate);
insert into goods values (goods_SEQ2.nextval,'bbb','å',35000,2,70000,sysdate);
delete from goods;
drop table goods;


select * from member N inner join goods L on N.m_id = L.g_id;

select N.m_id,N.m_name,L.g_name,L.g_price_sum from member N inner join goods L on N.m_id = L.g_id;

-- sum �Լ��� �̿��Ͽ� ���̵� �� �ݾ��� ���Ͻÿ�
select N.m_id,N.m_name,N.m_addr,sum(L.g_price_sum) from member N inner join 
    goods L on N.m_id = L.g_id group by N.m_id,N.m_name,N.m_addr;

