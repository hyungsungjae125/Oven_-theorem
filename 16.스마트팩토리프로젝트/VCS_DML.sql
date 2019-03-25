use VCS_DB;

/*회원구분-------------------------------------------------------------------------------*/
insert into Division (dName) values ('일반회원');
insert into Division (dName) values ('봉사기관');
insert into Division (dName) values ('관리자');

select * from Division;
/*회원-------------------------------------------------------------------------------*/
insert into Member (dNo,mId,mPw,mName,mAddr,mNumber) values(3,'root','1234','관리자','가산동 대륭3차','010-1234-5678');
insert into Member (dNo,mId,mPw,mName,mAddr,mNumber) values(1,'hsj','0000','형성재','동탄6동 반도8차','010-4192-9741');
insert into Member (dNo,mId,mPw,mName,mAddr,mNumber,aName) values(2,'goodee','1111','구디','대륭3차','010-1111-2222','구디');

select * from Member;
select m.mNo,d.dName as '권한',m.mId as '아이디',m.mPw as '비번',m.mName,m.mAddr,mNumber from Member m inner join Division d on (m.dNo=d.dNo);
/*봉사목록-------------------------------------------------------------------------------*/

/*신청내역-------------------------------------------------------------------------------*/

/*공지-------------------------------------------------------------------------------*/
insert into Notice(mNo,nTitle,nContents,nUrl) values(1,'공지테스트','내용','테스트url');
insert into Notice(mNo,nTitle,nContents,nUrl) values(1,'공지테스트1','내용1','테스트url1');
/*답변-------------------------------------------------------------------------------*/

/*질문-------------------------------------------------------------------------------*/
insert into Question (mNo,qTitle,qContents,qUrl)values(2,'질문제목','질문내용','url1');
insert into Question (mNo,qTitle,qContents,qUrl)values(2,'질문제목2','질문내용2','url2');
/*외부봉사-------------------------------------------------------------------------------*/
insert into Outside(mNo,oUrl) values(2,'testurl');
insert into Outside(mNo,oUrl) values(2,'testurl1');
insert into Outside(mNo,oUrl) values(2,'testurl2');
/*-------------------------------------------------------------------------------*/

