use bt1_ss4;
-- 1
select * from student join bt1_ss4.class c on c.classid = student.classid where c.classid = 1;
-- 2
select * from student join bt1_ss4.mark m on student.studentid = m.studentid where m.subid = (select subid from subject where subname like 'subject 1' limit 1);
-- 3
select student.studentname, TBC from student join (select studentname,avg(mark) as TBC from student join bt1_ss4.mark m on student.studentid = m.studentid group by studentname) as avgmark on student.studentname = avgmark.studentname where TBC > 50;
-- 4
select subname,s.subid,avg(mark) as TBC from subject s join bt1_ss4.mark m on s.subid = m.subid group by s.subid;
select subject.subname,TBC from subject join (select subname,s.subid,avg(mark) as TBC from subject s join bt1_ss4.mark m on s.subid = m.subid group by s.subid) as avgmark on subject.subname = avgmark.subname where TBC < 50;
-- 5
select student.studentname from student left join bt1_ss4.mark m on student.studentid = m.studentid where m.studentid is null ;