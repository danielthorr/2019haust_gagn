/*
	name: getPath
	role: gets the path value of the node supplied
	author: Sigurður R Ragnarsson
*/
delimiter $$

create function getPath(node_id int)
returns varchar(255)
begin
	declare node_path varchar(255);
	select path into node_path from Node where nodeID = node_id;

	return node_path;
end $$


/*
	name: getParentPath
	role: gets the path value of the parent node
	author: Sigurður R Ragnarsson
*/
delimiter $$

create function getParentPath(node_id int)
returns varchar(255)
begin
	declare node_path varchar(255);
	-- select path into node_path from Tree where nodeID = node_id;
	set node_path = getPath(node_id);

	return concat(substring(node_path,1,length(node_path)-2));
end $$


/*
	name: getParentID
	role: gets the id of the parent node
	author: Sigurður R Ragnarsson
    todo:  everything
*/
delimiter $$

create function getParentID(node_id int)
returns int
begin
	declare parent_path varchar(255);
    return 0;	-- hardcoding
end $$


/*
	name: getParentID
	role: gets the id of the parent node
	author: Sigurður R Ragnarsson
*/
delimiter $$

create function isRoot(node_id int)
returns boolean
begin
	if(select path from Node where nodeID = node_id) = '1' then
		return true;
	else
		return false;
	end if;
end $$


/*
	name: getNumberOfDescendants
	role: count the number of descendants a node has
	author: Sigurður R Ragnarsson
*/
delimiter $$
drop function if exists getNumberOfDescendants $$

create function getNumberOfDescendants(node_id int)
returns int
begin
	declare number_of_descendants int;
   
    if isRoot(node_id) then
		select count(nodeID) into number_of_descendants from Node where path like concat('1','/%');
	else
		select count(nodeID) into number_of_descendants from Node where path like concat(getPath(node_id),'/%');
	end if;
    
	return number_of_descendants;
end $$
delimiter ;

/*
	name: getNumberOfChildren
	role: count the number of children a node has
	author: Sigurður R Ragnarsson
*/
delimiter $$
drop function if exists getNumberOfChildren $$

create function getNumberOfChildren(node_id int)
returns int
begin
	declare number_of_children int;
    
    if isRoot(node_id) then
		select count(nodeID) into number_of_children from Node where path like concat('1','/_');
	else
		select count(nodeID) into number_of_children from Node where path like concat(getPath(node_id),'/_');
	end if;
    
	return number_of_children;
end $$
delimiter ;


