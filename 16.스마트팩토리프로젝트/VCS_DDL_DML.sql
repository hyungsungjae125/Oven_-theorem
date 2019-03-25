use VCS_DB;

/*회원구분-------------------------------------------------------------------------------*/
create table Division(
	dNo int not null IDENTITY(1,1),
	dName varchar(20) not null,
	primary key (dNo)
);
/*회원-------------------------------------------------------------------------------*/
create table Member(
	mNo int not null IDENTITY(1,1),
	dNo int not null  foreign key references Division(dNo),
	mId varchar(30) not null,
	mPw varchar(30) not null,
	aName varchar(50) null,
	mName varchar(30) not null,
	mAddr varchar(200) not null,
	mNumber varchar(30) not null,
	delYn varchar(1) not null default ('N'),
	primary key (mNo)
);
/*봉사목록-------------------------------------------------------------------------------*/
create table VolunteerList(
	vNo int not null identity(1,1),
	mNo int not null foreign key references Member(mNo),
	vName varchar(50) not null,
	vContents varchar(200) not null,
	vCity varchar(50) not null,
	vGu varchar(50) not null,
	vField varchar(50) not null,
	vPlace varchar(50) not null,
	vStartcollect date not null,
	vEndcollect date not null,
	vStartvol date not null,
	vEndvol date not null,
	vCollectnum int not null,
	vNownum int not null default 0,
	vTime int not null,
	vWeek varchar(30) not null,
	vObject varchar(30) not null,
	vCount int not null,
	regdate date not null default getdate(),
	delYn varchar(1) not null default 'N',
	primary key (vNo)
);
/*신청내역-------------------------------------------------------------------------------*/
create table Apply(
	aNo int not null identity(1,1),
	mNo int not null foreign key references Member(mNo),
	vNo int not null foreign key references VolunteerList(vNo),
	applydate date not null default getdate(),
	comYn varchar(1) not null default 'N',
	cancelYn varchar(1) not null default 'N'
);
/*공지-------------------------------------------------------------------------------*/
create table Notice(
	nNo int not null identity(1,1) primary key,
	mNo int not null foreign key references Member(mNo),
	nTitle varchar(50) not null,
	nUrl varchar(200) not null,
	regdate date not null default getdate(),
	viewcount int not null default 0,
	delYn varchar(1) not null default 'N'
);
/*질문-------------------------------------------------------------------------------*/
create table Question(
	qNo int not null identity(1,1) primary key,
	mNo int not null foreign key references Member(mNo),
	qTitle varchar(50) not null,
	qContents varchar(200) not null,
	qUrl varchar(200) not null,
	regdate date not null default getdate(),
	viewcount int not null default 0,
	delYn varchar(1) not null default 'N'
);
/*답변-------------------------------------------------------------------------------*/
create table Answer(
	aNo int not null identity(1,1) primary key,
	qNo int not null foreign key references Question(qNo),
	aTitle varchar(50) not null,
	aContents varchar(200) not null,
	aUrl varchar(200) not null,
	regdate date not null default getdate(),
	delYn varchar(10) not null default 'N'
);

/*외부봉사-------------------------------------------------------------------------------*/
create table Outside(
	oNo int not null identity(1,1) primary key,
	mNo int not null foreign key references Member(mNo),
	oUrl varchar(200) not null,
	applydate date not null default getdate(),
	okdate date null,
	okYn varchar(1) not null default 'N',
	applytime int default 0
);
/*-------------------------------------------------------------------------------*/
