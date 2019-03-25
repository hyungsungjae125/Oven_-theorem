/*
	전체프로시저 조회 : select * from INFORMATION_SCHEMA.ROUTINES;
	프로시저 1개 조회 : sp_helptext [프로시저명]
	실행법 : exec [프로시져명] [변수]
*/
create procedure sp_SearchMember
(
	@id varchar(max),
	@pw varchar(max)
)
as
		SET NOCOUNT ON;

DECLARE @LogonResult BIT
SET @LogonResult = (SELECT pwdcompare(@pw,pwdencrypt(mPw)) FROM Member WHERE mId = @id)

IF(@LogonResult = 1) -- #성공이면
begin
	select mNo,dNo from Member where mId = @id and mPw = @pw
	return
end
ELSE
begin
	select 0 as mNo ,0 as dNo
	RETURN 
end

SET NOCOUNT OFF;


exec sp_SearchMember 'root','123'

/*=========================================================*/
create procedure sp_InsertVolunteerList
(
	@name varchar(max),
	@contents varchar(max),
	@city varchar(max),
	@gu varchar(max),
	@field varchar(max),
	@place varchar(max),
	@startcollect date,
	@endcollect date,
	@startvol date,
	@endvol date,
	@collectnum int,
	@time int,
	@week varchar(max),
	@object varchar(max),
	@count int
)
as
		SET NOCOUNT ON;

		insert into VolunteerList (vName,vContents,vCity,vGu,vField,vPlace,vStartcollect,vEndcollect,vStartvol,vEndvol,vCollectnum,vTime,vWeek,vObject,vCount)
							   values (@name,@contents,@city,@gu,@field,@place,@startcollect,@endcollect,@startvol,@endvol,@collectnum,@time,@week,@object,@count);

SET NOCOUNT OFF;



create procedure sp_SelectVolunteerList
as
		SET NOCOUNT ON;

		select v.vNo,v.vName,v.regdate,m.mName from VolunteerList as v inner join Member as m on(v.mNo=m.mNo) where v.delYn='N';
SET NOCOUNT OFF;

create procedure sp_SelectCertificationList
as
		SET NOCOUNT ON;

		select o.oNo,m.mName,o.applydate from Outside as o inner join Member as m on(o.mNo=m.mNo) where o.okYn='N';
SET NOCOUNT OFF;

exec sp_SelectCertificationList;

create procedure sp_SelectNoticeList
as
		SET NOCOUNT ON;

		select n.nNo,n.nTitle,m.mName,n.regdate,n.viewcount from Notice as n inner join Member as m on(n.mNo=m.mNo) where n.delYn='N'; 
SET NOCOUNT OFF;

exec sp_SelectNoticeList;

create procedure sp_SelectQuestionList
as
		SET NOCOUNT ON;

		select q.qNo,q.qTitle,m.mName,q.regdate,q.viewcount from Question as q inner join Member as m on(q.mNo=m.mNo) where q.delYn='N';
SET NOCOUNT OFF;

exec sp_SelectQuestionList;

create procedure sp_DeleteVolunteer
(
	@vNo int,
	@mNo int
)
as
SET NOCOUNT ON;
	update VolunteerList set delYn='Y' where vNo = @vNo and mNo=@mNo and delYn='N';
SET NOCOUNT OFF;

create procedure sp_UpdateVolunteerList
(
	@vNo int,
	@mNo int,
	@name varchar(max),
	@contents varchar(max),
	@city varchar(max),
	@gu varchar(max),
	@field varchar(max),
	@place varchar(max),
	@startcollect date,
	@endcollect date,
	@startvol date,
	@endvol date,
	@collectnum int,
	@time int,
	@week varchar(max),
	@object varchar(max),
	@count int
)
as
		SET NOCOUNT ON;

		update VolunteerList set vName = @name , vContents = @contents , vCity = @city , vGu = @gu , vField = @field , vPlace = @place ,
										 vStartcollect = @startcollect , vEndcollect = @endcollect , vStartvol = @startvol , vEndvol = @endvol , vCollectnum = @collectnum , 
										vTime = @time , vWeek = @week , vObject = @object , vCount = @count
							   where vNo = @vNo and mNo = @mNo and delYn='N';
		return
SET NOCOUNT OFF;

create procedure sp_SelectVolunteerListDetail
(
	@vNo int
)
as
		SET NOCOUNT ON;

		select v.vName,v.vContents,v.vCity,v.vGu,v.vField,v.vPlace,v.vStartcollect,v.vEndcollect,v.vStartvol,v.vEndvol,v.vCollectnum,v.vNownum,v.vTime,v.vWeek,v.vObject from VolunteerList as v inner join Member as m on(v.mNo=m.mNo) where v.vNo = @vNo and v.delYn='N';
SET NOCOUNT OFF;

exec sp_SelectVolunteerListDetail 3;


create procedure sp_SelectCertificationDetail
(
	@oNo int
)
as
		SET NOCOUNT ON;

		select m.mName,m.mAddr,m.mNumber,o.oUrl from Outside as o inner join Member as m on(o.mNo=m.mNo) where o.oNo = @oNo and o.okYn='N';
SET NOCOUNT OFF;

create procedure sp_SelectCertificationOk
(
	@oNo int,
	@mNo int,
	@time int
)
as
		SET NOCOUNT ON;
		declare @dNo int;
		set @dNo = 0;
		set @dNo = (select dNo from Member where mNo=@mNo);
		if(@dNo = 3)
		begin
			update Outside set okYn='Y', okdate=GETDATE(),applytime=@time where oNo = @oNo and okYn='N';
			return
		end
		else
		begin
			return
		end
SET NOCOUNT OFF;

create procedure sp_SelectNoticeDetail
(
	@nNo int
)
as
begin
	select nTitle,nContents,nUrl,mNo from Notice where nNo=@nNo and delYn='N';
end

create procedure sp_DeleteNotice
(
	@nNo int,
	@mNo int
)
as
begin
	
	update Notice set delYn='Y' where delYn='N' and nNo=@nNo and mNo=@mNo;
	select nUrl from Notice where nNo=@nNo and mNo = @mNo;
	return
end

create procedure sp_InsertNotice
(
	@mNo int,
	@nTitle varchar(max),
	@nContents varchar(max),
	@nUrl varchar(max)
)
as
begin
	insert into Notice (mNo,nTitle,nContents,nUrl) values (@mNo,@nTitle,@nContents,@nUrl);
	return
end

create procedure sp_UpdateNotice
(
	@nNo int,
	@nTitle varchar(max),
	@nContents varchar(max),
	@nUrl varchar(max),
	@mNo int
)
as
begin
	declare @urlbegin varchar(max);
	declare @urlafter varchar(max);
	set @urlbegin = (select nUrl from Notice where nNo=@nNo and delYn='N');
	if(@nUrl='')
	begin
		update Notice set nTitle=@nTitle,nContents=@nContents where delYn='N' and nNo=@nNo and mNo=@mno;
	end
	else
	begin
		update Notice set nTitle=@nTitle,nContents=@nContents,nUrl=@nUrl where delYn='N' and nNo=@nNo and mNo=@mno;
	end
	
	set @urlafter = (select nUrl from Notice where nNo=@nNo and delYn='N');
	if(@urlbegin=@urlafter)
	begin
		select '' as 'nUrl'
		return
	end
	else
	begin
		select @urlbegin as 'nUrl'
		return
	end
	return
end

exec sp_UpdateNotice 1,'수정','임의수정','test유알엘',1;


create procedure sp_SelectQuestionDetail
(
	@qNo int
)
as
begin
	Select q.qTitle,m.mName,q.regdate as 'regdate',q.qUrl,q.qContents from Question as q inner join Member as m on(q.mNo=m.mNo) where qNo = @qNo and q.delYn='N';
end

exec sp_SelectQuestionDetail 3;


create procedure sp_InsertAnswer
(
	@dNo int,
	@qNo int,
	@aTitle varchar(max),
	@aContents varchar(max),
	@aUrl varchar(max)
)
as
begin
	if(@dNo=3)
	begin
	insert into Answer(qNo,aTitle,aContents,aUrl) values (@qNo,@aTitle,@aContents,@aUrl);
	end
	return
end

create procedure sp_InsertMember
(
	@mId varchar(max),
	@mPw varchar(max),
	@mName varchar(max),
	@mAddr varchar(max),
	@mNumber varchar(max)
)
as
begin
	insert into Member (dNo,mId,mPw,mName,mAddr,mNumber) values(1,@mId,@mPw,@mName,@mAddr,@mNumber);
end
select * from Member;

select * from VolunteerList;



create procedure sp_SelectVolunteerList2
as
		SET NOCOUNT ON;

		select v.vNo,v.vName,m.aName,v.vWeek,v.vTime from VolunteerList as v inner join Member as m on(v.mNo=m.mNo) where v.delYn='N' and v.vCollectnum>v.vNownum;
SET NOCOUNT OFF;

exec sp_SelectVolunteerList2;

alter procedure sp_SelectVolunteerDetail
(
	@vNo int
)
as
begin
		select v.vNo,v.vName,v.vContents,m.aName,v.vCity,v.vGu,v.vPlace,v.vField,v.vObject,CONVERT(char(19),v.vStartcollect,120) as vStartcollect,CONVERT(varchar,v.vEndcollect,120) as vEndcollect,CONVERT(varchar,v.vStartvol,120) as vStartvol,CONVERT(varchar,v.vEndvol,120) as vEndvol,v.vNownum,v.vCollectnum,v.vWeek,v.vTime,m.mNumber,m.mAddr,m.mName from VolunteerList as v inner join Member as m on(v.mNo=m.mNo) where v.vNo=@vNo and v.delYn='N' and v.vCollectnum>v.vNownum;
end

exec sp_SelectVolunteerDetail 3;



alter procedure sp_InsertApply
(
	@mNo int,
	@vNo int
)
as
begin
	DECLARE @now int
	DECLARE @col int
	set @now  = (select vNownum from VolunteerList where vNo = @vNo)
	set @col  = (select vCollectnum from VolunteerList where vNo = @vNo)
	if(@now >= @col)
	begin
		return 0
	end
	DECLARE @ApplyResult BIT
	SET @ApplyResult = (SELECT pwdcompare(@vNo,pwdencrypt(vNo)) FROM Apply WHERE mNo = @mNo)
	
	IF(@ApplyResult = 1) -- #존재한다면
	begin
		return 0
	end
	ELSE
	begin
		insert into Apply (mNo,vNo) values (@mNo,@vNo);
		update VolunteerList set vNownum = vNownum+1 where vNo=@vNo;
	end
end

exec sp_InsertApply 2,3;

truncate table Apply;

update Apply set 

select * from Apply,VolunteerList;

create procedure sp_EventVolunteer
as
begin
	update Apply set comYn='Y',applydate=GETDATE() where vNo In (select vNo from VolunteerList where vEndvol<GETDATE()) and comYn='N';
end

exec sp_EventVolunteer

create procedure sp_Certification
(
	@mNo int
)
as
begin
	select v.vName,CONVERT(char(19),a.applydate,120) as applydate,v.vTime from Apply as a inner join VolunteerList as v on(a.vNo=v.vNo) where a.mNo=@mNo;
end

exec sp_Certification 2;
