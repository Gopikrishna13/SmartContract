//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Goods{
    address public owner;
    uint256 goodscounter=0;
    uint256 rawmaterialscounter=0;
    uint256 assetscounter=0;
    uint256 manufacturedcounter=0;

     constructor()
    {
        owner=msg.sender;

    }

enum productType{
    Assets,
    Manufactured,
    Rawmaterials
}

 struct Category{
    string category;
 }

    struct goods{
        uint256 goodsId;
        productType product;
        Category category;
        string productname;
        uint256 manufacturedate;
        uint256 expirydate;
        uint256 price;
        uint256 quantity;
        string productlocation;
        string warehouseId;
        string warehouselocation;

        address owner;
        uint256 created;
        uint256 updated;

        }


        struct rawmaterials{
            uint256 goodsId;
            uint256 rawmaterialId;
        }

        struct assets{
            uint256 goodsId;
            uint256 assetId;
        }

        struct manufactured{
            uint256 goodsId;
            uint256 manufactureId;
        }
        
        struct monthlygoods{
            uint256 rawmaterialId;
            uint256 assetId;
            uint256 manufactureId;
            string month;
            string year;
        }

        goods[]goodsdetails;
        rawmaterials[]rawmaterialdetails;
        assets[]assetdetails;
        manufactured[]manufacturedetails;


        //function to create goods

        function creategoods(
           goods memory goodsinfo
        )external returns(bool)
        {
            goodscounter++;
            goodsinfo.goodsId;
            goodsdetails.push(goods(
                goodsinfo.goodsId,
                goodsinfo.product,
                goodsinfo.category,
                goodsinfo.productname,
                goodsinfo.manufacturedate,
                goodsinfo.expirydate,
                goodsinfo.price,
                goodsinfo.quantity,
                goodsinfo.productlocation,
                goodsinfo.warehouseId,
                goodsinfo.warehouselocation,
                msg.sender,
                block.timestamp,
                block.timestamp

            ));
      if(goodsinfo.product==productType.Assets)
      {
          assetscounter++;
           assetdetails.push(assets(
               goodscounter,
               assetscounter
           ));
      }

      else if(goodsinfo.product==productType.Rawmaterials)
      {
          rawmaterialscounter++;
          rawmaterialdetails.push(rawmaterials(
              goodscounter,
              rawmaterialscounter
          ));
      }else 
      {
          manufacturedcounter++;
          manufacturedetails.push(manufactured(
             goodscounter,
             manufacturedcounter
          ));
      }
            return true;
        }

        //function to get single goods
        function showGoods(uint256 goodsId)external view returns(goods memory)
        {
            goods memory Goodsdetails;

            for(uint i=0;i<goodsdetails.length;++i)
            {
                if(goodsdetails[i].goodsId==goodsId)
                {
                    Goodsdetails=goodsdetails[i];
                }
            }

            return Goodsdetails;
        }

        //funtion to show all goods
        function getAllGoods()external view returns(goods[]memory)
        {
            return goodsdetails;
        }

        //function to delete goods

        function deleteGoods(uint256 goodsId)external  returns (bool)
        {
            for(uint i=0;i<goodsdetails.length;++i)
            {
                if(goodsdetails[i].goodsId==goodsId)
                {
                    delete goodsdetails[i];
                   
                }
            }
            return true;
        }

        //function to delete assets
        function deleteAssets(uint256 goodsId)external returns(bool)
        {
             for(uint i=0;i<assetdetails.length;++i)
                        {
                            if(assetdetails[i].goodsId==goodsId)
                            {
                                 delete assetdetails[i];
                            }
                        }
            return true;
        }

        //function to delet rawmaterials
        function deleteRawmaterials(uint256 goodsId)external returns(bool)
        {
             for(uint i=0;i<rawmaterialdetails.length;++i)
                        {
                            if(rawmaterialdetails[i].goodsId==goodsId)
                            {
                                    delete rawmaterialdetails[i];
                            }
                        }
            return true;
        }

        //function to delete manufactured
        function deleteManufactured(uint256 goodsId)external returns(bool)
        {
             for(uint i=0;i<manufacturedetails.length;++i)
                        {
                            if(manufacturedetails[i].goodsId==goodsId)
                            {
                                delete manufacturedetails[i];
                            }
                        }
            return true;
        }

        //function to update goods
        function updateGoods(
           goods memory goodsinfo
        )external returns(bool)
        {
            for(uint i=0;i<goodsdetails.length;++i)
            {
                if(goodsdetails[i].goodsId==goodsinfo.goodsId)
                {
                    goodsdetails[i].product=goodsinfo.product;
                    goodsdetails[i].category=goodsinfo.category;
                    goodsdetails[i].productname=goodsinfo.productname;
                    goodsdetails[i].manufacturedate=goodsinfo.manufacturedate;
                    goodsdetails[i].expirydate=goodsinfo.expirydate;
                    goodsdetails[i].price=goodsinfo.price;
                    goodsdetails[i].quantity=goodsinfo.quantity;
                    goodsdetails[i].productlocation=goodsinfo.productlocation;
                    goodsdetails[i].warehouseId=goodsinfo.warehouseId;
                    goodsdetails[i].warehouselocation=goodsinfo.warehouselocation;

                }
            }
            return true;
        }

    //function to get all assets
    function getAllAssets()external view returns(assets[]memory)
    {
        return assetdetails;
    }

    //function to get all raw materials

    function getAllRawmaterials()external view returns(rawmaterials[]memory)
    {
        return rawmaterialdetails;
    }

    //function to get all manufactured

    function getAllManufactured()external view returns(manufactured[]memory)
    {
        return manufacturedetails;
    }

}