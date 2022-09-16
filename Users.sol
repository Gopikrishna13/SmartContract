//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract User{
    address public owner;
    uint256 private usercounter=0;
    uint256 private  clientcounter=0;
    uint256 private suppliercounter=0;

    constructor()
    {
        owner=msg.sender;
    }
enum personType{
   Client,
   Supplier
}
struct user{
    uint256 userId;
    personType person;
    string firstName;
    string lastName;
    string eMail;
    string Address;
    uint256 phone;

    address owner;
    uint256 created;
    uint256 updated;

}

struct client{
    uint256 userId;
    uint256 cilentId;
}

struct supplier{
    uint256 userId;
    uint256 clientId;
}

user[]userdetails;
client[]clientdetails;
supplier[]supplierdetails;

//function to create user

function createUser(
  user memory userinfo
)external returns(bool)
{
    usercounter++;
    userinfo.userId=usercounter;
    userdetails.push(user(
    userinfo.userId,
    userinfo.person,
    userinfo.firstName,
    userinfo.lastName,
    userinfo.eMail,
    userinfo.Address,
    userinfo.phone,

    msg.sender,
    block.timestamp,
    block.timestamp

    ));

    return true;
}

//function to create client
function createClient(uint256 userId)external returns(bool)
{
    clientcounter++;
    clientdetails.push(client(
    userId,
    clientcounter));
    return true;
}

//function to create supplier
function createSupplier(uint256 userId)external returns(bool)
{
    suppliercounter++;
    supplierdetails.push(supplier(
        userId,
        suppliercounter
    ));
    return true;
}

//function to delete user
function deleteUser(uint256 userId)external  returns(bool)
{
   for(uint i=0;i<userdetails.length;++i)
   {
       if(userdetails[i].userId==userId)
       {
           delete userdetails[i];
          
       }
   }
   return true;
}
//function to delete client
function deleteClient(uint256 userId)external returns(bool)
{
     for(uint i=0;i<clientdetails.length;++i)
               {
                   if(clientdetails[i].userId==userId)
                   {
                            delete clientdetails[i];
                   }
               }
    return true;
}
//function to delete supplier
function deleteSupplier(uint256 userId)external returns(bool)
{
     for(uint i=0;i<supplierdetails.length;++i)
               {
                   if(supplierdetails[i].userId==userId)
                   {
                           delete supplierdetails[i];
                   }
               }
    return true;
}
//function to get single user
function getSingleUser(uint256 userId)external view returns(user memory)
{
    user memory userinfo;
   for(uint i=0;i<userdetails.length;++i)
   {
       if(userdetails[i].userId==userId)
       {
             userinfo=userdetails[i];
       }
   }
   return userinfo;
}

//function to  get all users

function getAllusers()external view returns(user[]memory)
{
    return userdetails;
}

//function to update user

function upadateUser(
   user memory userinfo
    )external returns (bool)
{
    for(uint i=0;i<userdetails.length;++i)
    {
        if(userdetails[i].userId==userinfo.userId)
        {
            userdetails[i].person=userinfo.person;
            userdetails[i].firstName=userinfo.firstName;
            userdetails[i].lastName=userinfo.lastName;
            userdetails[i].eMail=userinfo.eMail;
            userdetails[i].Address=userinfo.Address;
            userdetails[i].phone=userinfo.phone;
        }
    }
    return true;
}

//find user by mail
function getUser(string memory eMail)external view returns(user memory)
{
  user memory userinfo;
  for(uint i=0;i<userdetails.length;++i)
  {
      if(keccak256(bytes(userdetails[i].eMail))==keccak256(bytes(eMail)))
      {
          userinfo=userdetails[i];
      }
  }
return userinfo;
}

}
