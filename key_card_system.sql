/*
 Keycardsystem database
 This project is where you show off your ability to 
 (1) translate a business requirement into a database design, 
 (2) design a database using one-to-many and many-to-many relationships, and 
 (3) know when to use LEFT and/or RIGHT JOINs to build result sets for reporting.
*/

DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Groupss;
DROP TABLE IF EXISTS Rooms;
DROP TABLE IF EXISTS UsersGroups;
DROP TABLE IF EXISTS GroupsRooms;
DROP TABLE IF EXISTS UsersGroupsRooms;

CREATE TABLE Users (
  UserId int PRIMARY KEY,
  UserName varchar(30) NOT NULL
);

INSERT INTO Users ( UserId, UserName ) VALUES ( 1, 'Modesto');
INSERT INTO Users ( UserId, UserName ) VALUES ( 2, 'Ayine');
INSERT INTO Users ( UserId, UserName ) VALUES ( 3, 'Christopher');
INSERT INTO Users ( UserId, UserName ) VALUES ( 4, 'Cheong');
INSERT INTO Users ( UserId, UserName ) VALUES ( 5, 'Saulat');
INSERT INTO Users ( UserId, UserName ) VALUES ( 6, 'Heidy');

SELECT * FROM Users;

CREATE TABLE Groupss (
  GroupId int PRIMARY KEY,
  GroupName varchar(30) NOT NULL
);

INSERT INTO Groupss ( GroupId, GroupName ) VALUES ( 21, 'I.T.');
INSERT INTO Groupss ( GroupId, GroupName ) VALUES ( 22, 'Sales');
INSERT INTO Groupss ( GroupId, GroupName ) VALUES ( 23, 'Administration');
INSERT INTO Groupss ( GroupId, GroupName ) VALUES ( 24, 'Operations');

SELECT * FROM Groupss;

CREATE TABLE Rooms (
  RoomId int PRIMARY KEY,
  RoomName varchar(30) NOT NULL
);

INSERT INTO Rooms ( RoomId, RoomName ) VALUES ( 101, '101');
INSERT INTO Rooms ( RoomId, RoomName ) VALUES ( 102, '102');
INSERT INTO Rooms ( RoomId, RoomName ) VALUES ( 103, 'Auditorium A');
INSERT INTO Rooms ( RoomId, RoomName ) VALUES ( 104, 'Auditorium B');

SELECT * FROM Rooms;

CREATE TABLE UsersGroups (
  UgId int PRIMARY KEY,
  UserId int NOT NULL,
  GroupId int NOT NULL
);

INSERT INTO UsersGroups ( UgId, UserId, GroupId ) VALUES ( 121, 1, 21);
INSERT INTO UsersGroups ( UgId, UserId, GroupId ) VALUES ( 122, 2, 21);
INSERT INTO UsersGroups ( UgId, UserId, GroupId ) VALUES ( 123, 3, 22);
INSERT INTO UsersGroups ( UgId, UserId, GroupId ) VALUES ( 124, 4, 22);

SELECT * FROM UsersGroups;

CREATE TABLE GroupsRooms (
  GrId int PRIMARY KEY,
  GroupId int NOT NULL,
  RoomId int NOT NULL
);

INSERT INTO GroupsRooms ( GrId, GroupId, RoomId ) VALUES ( 1101, 21, 101);
INSERT INTO GroupsRooms ( GrId, GroupId, RoomId ) VALUES ( 1102, 21, 102);
INSERT INTO GroupsRooms ( GrId, GroupId, RoomId ) VALUES ( 1103, 22, 102);
INSERT INTO GroupsRooms ( GrId, GroupId, RoomId ) VALUES ( 1104, 22, 103);

SELECT * FROM GroupsRooms;


CREATE TABLE UsersGroupsRooms (
  UgrId int PRIMARY KEY,
  UserId int NOT NULL,
  GroupId int NOT NULL,
  RoomId int NOT NULL
);

INSERT INTO UsersGroupsRooms ( UgrId, UserId, GroupId, RoomId ) VALUES ( 2101, 1, 21, 101);
INSERT INTO UsersGroupsRooms ( UgrId, UserId, GroupId, RoomId ) VALUES ( 2102, 2, 21, 102);
INSERT INTO UsersGroupsRooms ( UgrId, UserId, GroupId, RoomId ) VALUES ( 2103, 3, 22, 102);
INSERT INTO UsersGroupsRooms ( UgrId, UserId, GroupId, RoomId ) VALUES ( 2104, 4, 22, 103);

SELECT * FROM UsersGroupsRooms;

/*
 Next, write SELECT statements that provide the following information: 
 • All groups, and the users in each group.  
	A group should appear even if there are no users assigned to the group. 
 • All rooms, and the groups assigned to each room.  
	The rooms should appear even if no groups have been assigned to them. 
 • A list of users, the groups that they belong to, and the rooms to which they are assigned.  
	This should be sorted alphabetically by user, then by group, then by room. 
*/

SELECT g.GroupName, u.UserName FROM Users u INNER JOIN UsersGroups ug 
	ON u.UserId = ug.UserId RIGHT JOIN Groupss g 
	ON ug.GroupId = g.GroupId;

SELECT r.RoomName, g.GroupName FROM Groupss g INNER JOIN GroupsRooms gr 
	ON g.GroupId = gr.GroupId RIGHT JOIN Rooms r 
	ON gr.RoomId = r.RoomId;

SELECT u.UserName, g.GroupName, r.RoomName 
  FROM Users u INNER JOIN UsersGroupsRooms ugr 
		ON u.UserId = ugr.UserId INNER JOIN Groupss g
		ON ugr.GroupId = g.GroupId INNER JOIN Rooms r 
		ON ugr.RoomId = r.RoomId
  ORDER BY UserName, GroupName, RoomName;
    
