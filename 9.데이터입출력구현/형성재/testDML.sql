insert into Posts (pTitle,pContents,pWriter,pPasswd) values('test제목','test내용','작성자샘플','123123');
update Posts set Lookup =Lookup+1 where pNo = 1;
update Posts set pContents = '수정내용' , modDate = NOW() where pNo = 1 and pWriter = '작성자샘플' and pPasswd ='123123';