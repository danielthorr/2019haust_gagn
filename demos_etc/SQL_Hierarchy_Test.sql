drop database if exists Trees;
create database Trees;
use Trees;

create table Node
(
	nodeID int auto_increment,
    path varchar(500) not null,
    caption varchar(55),
    nodeDepth int null,
    constraint node_PK primary key(nodeID),
    constraint path_NQ unique(path)
);

insert into Node(path,caption,nodeDepth)values('1','Music',1);  

insert into Node(path,caption,nodeDepth)values('1/1','Medieval',2);
insert into Node(path,caption,nodeDepth)values('1/2','Renaissance',2);
insert into Node(path,caption,nodeDepth)values('1/3','Baroque',2);
insert into Node(path,caption,nodeDepth)values('1/4','Classical',2);
insert into Node(path,caption,nodeDepth)values('1/5','Romantic',2);
insert into Node(path,caption,nodeDepth)values('1/6','Impressionist',2);
-- renaissance periods
insert into Node(path,caption,nodeDepth)values('1/2/1','Early Period',3);
insert into Node(path,caption,nodeDepth)values('1/2/2','Middle Period',3);
insert into Node(path,caption,nodeDepth)values('1/2/3','Late Period',3);
-- baroque periods
insert into Node(path,caption,nodeDepth)values('1/3/1','Early Baroque Period',3);
insert into Node(path,caption,nodeDepth)values('1/3/2','Middle Baroque Period',3);
insert into Node(path,caption,nodeDepth)values('1/3/3','Late Baroque Period',3);
-- composers of late baroque perid
insert into Node(path,caption,nodeDepth)values('1/3/3/1','Johann Sebastian Bach',4);
insert into Node(path,caption,nodeDepth)values('1/3/3/2','Georg Friedrich Händel',4);

