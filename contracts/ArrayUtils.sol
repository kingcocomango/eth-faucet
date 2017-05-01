pragma solidity ^0.4.8;

library ArrayUtils {

  struct ArrayList {
      mapping(address => uint) addressToIndexMapping;
      mapping(uint => address) indexToAddressMapping;
      uint numberOfValues;
  }

  function insert(ArrayList storage self, address value)
      returns (bool)
  {
      if (self.addressToIndexMapping[value]!=0)
          return false; // it already exists
      self.addressToIndexMapping[value] = self.numberOfValues+1; // place it at the end. We are a 1 indexed list
      self.indexToAddressMapping[self.numberOfValues+1] = value; // say that its at the end
      self.numberOfValues++; // the end is now 1 bigger
      return true;

  }

  function remove(ArrayList storage self, address value)
      returns (bool)
  {
      if (self.addressToIndexMapping[value]==0)
          return false; // cant remove what don't exist
      uint emptyspot = self.addressToIndexMapping[value]; // Index position with empty place
      address lastaddr = self.indexToAddressMapping[self.numberOfValues]; // Last value stored
      self.indexToAddressMapping[emptyspot]=lastaddr; // Move last value stored to empty place
      self.numberOfValues--; // drop duplicatd last value
      delete self.addressToIndexMapping[value]; // remove removed value actually
      // delete self.indexToAddressMapping[self.addressToIndexMapping[value]];
      return true;
  }

  function contains(ArrayList storage self, address value)
      returns (bool)
  {
      return self.addressToIndexMapping[value]!=0;
  }

  function indexOf(ArrayList storage self, address value)
      returns (uint)
  {
      if (self.addressToIndexMapping[value]==0)
          return uint(-1);
      return self.addressToIndexMapping[value];
  }
}
