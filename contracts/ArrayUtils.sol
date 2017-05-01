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
      self.numberOfValues++; // the end is now 1 bigger. Doing this before the next two lines immitates doing a +1 to them
      self.addressToIndexMapping[value] = self.numberOfValues; // place it at the end. We are a 1 indexed list
      self.indexToAddressMapping[self.numberOfValues] = value; // say that its at the end
      return true;

  }

  function remove(ArrayList storage self, address value)
      returns (bool)
  {
      uint abouttoempty = self.addressToIndexMapping[value];// Index position with empty place
      if (abouttoempty==0)
          return false; // cant remove what don't exist
      self.indexToAddressMapping[abouttoempty]=self.indexToAddressMapping[self.numberOfValues]; // Move last value stored to empty place
      self.numberOfValues--; // drop duplicatd last value
      delete self.addressToIndexMapping[value]; // remove removed value actually
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
      uint index = self.addressToIndexMapping[value];
      if (index==0)
          return uint(-1);
      return index;
  }
}
