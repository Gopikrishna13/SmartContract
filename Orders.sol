 //SPDX-License-Identifier: MIT
 pragma solidity ^0.8.7;

contract Shipment{
    address public owner;
    uint256 private shipmentcounter=0;
    uint256 private shippingimportcounter=0;
    uint256 private  shippingexportcounter=0;

    mapping(uint256=>address)shippingauthorOf;


    constructor()
    {
        owner=msg.sender;
    }

  enum shipmenttypes{
      Lcl,
      Fcl
  }

  enum status{
      shipped,
      pending,
      cancelled
  }

 
  enum shippingType{
      shipping_import,
      shipping_export
  }

    struct shippingorder{
        uint256 shippingId;
        string invoiceNo;
       string deliveryAddress;
        string portOfLanding;
        string portOfLoading;
        shipmenttypes Type;
        uint256 grossamount;
       bool paidstatus;
        uint256 netAmount;
        status delivery;
        shippingType shipment;
        uint256 orderDate;
       

        address owner;
        uint256 created;
        uint256 updated;
    }

    struct shippingimport{
        uint256 supplierId;
        uint256 shippingId;
        uint256 shippingimportId;
     
    }

    struct shippingexport{
        uint256 clientId;
        uint256 shippingId;
        uint256 shippingexportId;

    }



shippingorder[]shippingorderdetails;
shippingimport[]shippingimportdetails;
shippingexport[]shippingexportdetails;

event addshippingorder(
    uint256 shippingId,
    shippingType Type,
    bool paidstatus,
    address indexed executer,
    uint256 created
);

//function to create shipping  order
 function createShippingOrder(

 shippingorder memory shipinfo


)external returns(bool)
{
    shipmentcounter++;
    shippingauthorOf[shipmentcounter]=msg.sender;
    shipinfo.shippingId=shipmentcounter;
    shippingorderdetails.push(shippingorder(
       shipinfo.shippingId,
       shipinfo.invoiceNo,
       shipinfo.deliveryAddress,
       shipinfo.portOfLanding,
       shipinfo.portOfLoading,
       shipinfo.Type,
       shipinfo.grossamount,
       shipinfo.paidstatus,
       shipinfo.netAmount,
       shipinfo.delivery,
       shipinfo.shipment,
       shipinfo.orderDate,

       msg.sender,
       block.timestamp,
       block.timestamp
     
    ));
emit addshippingorder(
    shipmentcounter,
    shipinfo.shipment,
    shipinfo.paidstatus,
    msg.sender,
    block.timestamp
);

    return true;
}

//function to create shipping import

function createshippingImport(uint256 userId)external returns(bool)
{
    shippingimportcounter++;
    shippingimportdetails.push(shippingimport(
        userId,
        shipmentcounter,
        shippingimportcounter

    ));
    return true;

}

//function to create shipping export

function createshippingExport(uint256 userId)external returns (bool)
{
    shippingexportcounter++;
    shippingexportdetails.push(shippingexport(
        userId,
        shipmentcounter,
        shippingexportcounter
       
    ));
    return true;
}

//function to get single shipment
function getSingleShipment(uint256 shippingId)external view returns(shippingorder memory)
{
  shippingorder memory shippingOrder;
   for(uint i=0;i<shippingorderdetails.length;++i)
   {
       if(shippingorderdetails[i].shippingId==shippingId)
       {
           shippingOrder=shippingorderdetails[i];
       }
   }
   return shippingOrder;
}

//function to delete single shipment
function deleteShipment(uint256 shippingId)external returns(bool)
{
   for(uint i=0;i<shippingorderdetails.length;++i)
   {
       if(shippingorderdetails[i].shippingId==shippingId)
       {
           delete shippingorderdetails[i];    
       }
   }
    return true;
}

//function to delete shipping Import
function deleteShippingImport(uint256 shippingId)external returns(bool)
{
     for(uint i=0;i<shippingimportdetails.length;++i)
               {
                   if(shippingimportdetails[i].shippingId==shippingId)
                   {
                             delete shippingimportdetails[i];
                   }
               }
    return true;
}

//function to delete shipping export
function deleteShippingExport(uint256 shippingId)external returns (bool)
{
      for(uint i=0;i<shippingexportdetails.length;++i)
               {
                   if(shippingexportdetails[i].shippingId==shippingId)
                   {
                            delete shippingexportdetails[i];
                   }
               }
    return true;
}

//funtion to get all shipment

function getAllShipment()external view returns(shippingorder[]memory)
{
    return shippingorderdetails;
}

//function to get all shipping import

function getAllShippingimport()external view returns(shippingimport[]memory)
{
    return shippingimportdetails;
}

//function to get all shipping export

function getAllShippingexport() external view returns(shippingexport[]memory)
{
    return shippingexportdetails;
}

//function to update shipment
function updateShipment(
shippingorder memory shipinfo

)external returns (bool)
{
    for(uint i=0;i<shippingorderdetails.length;++i)
    {
        if(shippingorderdetails[i].shippingId==shipinfo.shippingId)
        {
            shippingorderdetails[i].invoiceNo=shipinfo.invoiceNo;
            shippingorderdetails[i].deliveryAddress=shipinfo.deliveryAddress;
            shippingorderdetails[i].portOfLanding=shipinfo.portOfLanding;
            shippingorderdetails[i].portOfLoading=shipinfo.portOfLoading;
            shippingorderdetails[i].Type=shipinfo.Type;
            shippingorderdetails[i].grossamount=shipinfo.grossamount;
            shippingorderdetails[i].netAmount=shipinfo.netAmount;
            shippingorderdetails[i].delivery=shipinfo.delivery;
            shippingorderdetails[i].shipment=shipinfo.shipment;
            shippingorderdetails[i].paidstatus=shipinfo.paidstatus;
            shippingorderdetails[i].orderDate=shipinfo.orderDate;


        }
    }
    return true;
}

}

