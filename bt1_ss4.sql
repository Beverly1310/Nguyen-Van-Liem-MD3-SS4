use bt1_ss4;
create table class
(
    classid   int auto_increment,
    className varchar(55) null,
    stardate  date        null,
    status    bit         null,
    constraint class_pk
        primary key (classid)
);
create table student
(
    studentid   int auto_increment,
    studentname varchar(50)  not null,
    address     varchar(255) not null,
    phone       varchar(15)  not null,
    status      bit          not null,
    classid     int          null,
    constraint student_pk
        primary key (studentid),
    constraint student_fk
        foreign key (classid) references class(classid)
);
create table subject
(
    subid   int auto_increment,
    subname varchar(55) not null,
    credit  varchar(55) null,
    status  bit         not null,
    constraint subject_pk
        primary key (subid)
);
create table mark
(
    markid    int auto_increment,
    subid     int  not null,
    studentid int  not null,
    mark      int  not null,
    examTime  date null,
    constraint mark_pk
        primary key (markid),
    constraint mark_student_studentid_fk
        foreign key (studentid) references student (studentid),
    constraint mark_subject_subid_fk
        foreign key (subid) references subject (subid)
);
INSERT INTO class (classname, stardate, status) VALUES
                                                    ('class 1', '2023-01-15', 1),
                                                    ('class 2', '2023-02-20', 1),
                                                    ('class 3', '2023-03-25', 1),
                                                    ('class 4', '2023-04-30', 0),
                                                    ('class 5', '2023-05-05', 1);

-- Thêm 5 bản ghi cho bảng student
INSERT INTO student (studentname, address, phone, status, classid) VALUES
                                                                       ('student 1', 'address 1', '123456789', 1, 1),
                                                                       ('student 2', 'address 2', '987654321', 1, 1),
                                                                       ('student 3', 'address 3', '456789123', 1, 2),
                                                                       ('student 4', 'address 4', '789123456', 1, 3),
                                                                       ('student 5', 'address 5', '321654987', 0, 3);

-- Thêm 5 bản ghi cho bảng subject
INSERT INTO subject (subname, credit, status) VALUES
                                                  ('subject 1', '3', 1),
                                                  ('subject 2', '2', 1),
                                                  ('subject 3', '4', 0),
                                                  ('subject 4', '3', 1),
                                                  ('subject 5', '2', 1);

-- Thêm 5 bản ghi cho bảng mark
INSERT INTO mark (subid, studentid, mark, examtime) VALUES
                                                        (1, 1, 85, '2023-05-10'),
                                                        (2, 2, 90, '2023-05-12'),
                                                        (3, 3, 75, '2023-05-15'),
                                                        (4, 4, 80, '2023-05-18'),
                                                        (5, 5, 95, '2023-05-20');
-- 1
select address, count(*) `so luong` from student group by address;
-- 2
select s.subid, subname, credit, status from subject s join mark m on s.subid = m.subid where mark >= all (select mark from mark);
-- 3
select studentid, avg(mark) from mark group by studentid;
-- 4
select studentid, avg(mark) from mark group by studentid having avg(mark)>=70 ;
-- 5
select * from student s join (select studentid, avg(mark) as avg_mark from mark group by studentid having avg(mark)>=70) as avgmark on s.studentid = avgmark.studentid order by avg_mark desc limit 1;
-- 6
select * from student s join (select studentid, avg(mark) as avg_mark from mark group by studentid having avg(mark)>=70) as avgmark on s.studentid = avgmark.studentid order by avg_mark desc;
