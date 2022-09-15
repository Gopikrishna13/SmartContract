//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Warehouse{
    address owner;
    uint256 private warehousecounter=0;

    constructor()
    {
        owner=msg.sender;
    }

    enum WarehouseType{
        active,
        inactive,
        maintenancee
    }

    struct warehouse{
        uint256 warehouseId;
        WarehouseType Type;
        string warehouseLocation;
        
    }

    warehouse[]warehousedetails;
   
   //function to create warehouse

   function createWarehouse(
      warehouse memory warehouseinfo
   )external returns(bool)
   {
       warehousecounter++;
       warehouseinfo.warehouseId=warehousecounter;
       warehousedetails.push(warehouse(
          warehouseinfo.warehouseId,
          warehouseinfo.Type,
          warehouseinfo.warehouseLocation
       ));
       return true;
   }

   //function to delete warehouse

   function deleteWarehouse(uint256 warehouseId)external returns (bool)
   {
       for(uint i=0;i<warehousedetails.length;++i)
       {
           if(warehousedetails[i].warehouseId==warehouseId)
           {
               delete warehousedetails[i];
           }
       }
       return true;
   }

   //function to get single warehouse

   function getSingleWarehouse(uint256 warehouseId)external view returns(warehouse memory)
   {
      warehouse memory warehouseinfo;

      for(uint i=0;i<warehousedetails.length;++i)
      {
          if(warehousedetails[i].warehouseId==warehouseId)
          {
              warehouseinfo=warehousedetails[i];
          }
      }
      return warehouseinfo;
   }


   //function to get all warehouse

   function getAllWarehouse()external view returns(warehouse[]memory)
   {
       return warehousedetails;
   }

   //function to update warehouse

   function updateWarehouse(
       warehouse memory warehouseinfo
       )external  returns (bool)
   {
      
       for(uint i=0;i<warehousedetails.length;++i)
       {
           if(warehousedetails[i].warehouseId==warehouseinfo.warehouseId)
           {
               warehousedetails[i].Type=warehouseinfo.Type;
               warehousedetails[i].warehouseLocation=warehouseinfo.warehouseLocation;
           }
       }
       return true;
   }
}