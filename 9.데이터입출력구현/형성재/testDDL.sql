create table Posts(
	pNo int not null AUTO_INCREMENT,
	pTitle varchar(50) not null,
	pContents varchar(1000) not null,
	pWriter varchar(20) not null,
	pPasswd varchar(20) not null,
	Lookup int not null default 0,
	regDate datetime not null default NOW(),
	modDate datetime not null default NOW(),
	delYn varchar(1) not null default 'N',
	primary key (pNo)
);
select * from Posts;

DELIMITER \\
CREATE PROCEDURE sp_Posts()
begin
	select * from Posts;
end
\\

DELIMITER \\
CREATE PROCEDURE sp_Posts_pNo(in _pNo int)
begin
	select * from Posts where pNo = _pNo;
end
\\

call sp_Posts_pNo (2);

DELIMITER \\
CREATE PROCEDURE sp_Posts_Select(in _search varchar(50))
begin
	select * from Posts where (pTitle like concat('%',_search,'%') OR pContents like concat('%',_search,'%') OR pWriter like concat('%',_search,'%') OR pNo = cast(_search as unsigned)) AND delYn='N';
end
\\

call sp_Posts_Select ('내용');
call sp_Posts_Select in _search ='내용';


DELIMITER \\
CREATE PROCEDURE sp_Posts_Insert(in _pTitle varchar(50),in _pContents varchar(1000),in _pWriter varchar(20),in _pPasswd varchar(20))
begin
	insert into Posts (pTitle,pContents,pWriter,pPasswd) values(_pTitle,_pContents,_pWriter,_pPasswd);
end
\\
call sp_Posts_Insert ('test제목1','test내용2','작성자샘플3','1231234');

DELIMITER \\
CREATE PROCEDURE sp_Posts_Look(in _pNo int)
begin
	update Posts set Lookup =Lookup+1 where pNo = _pNo;
end
\\
call sp_Posts_Look (1);

DELIMITER \\
CREATE PROCEDURE sp_Posts_Update(in _pNo int,in _pWriter varchar(20),in _pPasswd varchar(20),in _pContents varchar(1000))
begin
	update Posts set pContents = _pContents , modDate = NOW() where pNo = _pNo and pWriter = _pWriter and pPasswd =_pPasswd and delYn = 'N';
end
\\
call sp_Posts_Update (1,'작성자샘플','123123','수정했뜨111111');

DELIMITER \\
CREATE PROCEDURE sp_Posts_Delete(in _pNo int,in _pWriter varchar(20),in _pPasswd varchar(20))
begin
	update Posts set delYn = 'Y' , modDate = NOW() where pNo = _pNo and pWriter = _pWriter and pPasswd =_pPasswd;
end
\\

call sp_Posts_Delete(1,'작성자샘플','123123');
