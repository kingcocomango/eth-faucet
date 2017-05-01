pragma solidity ^0.4.8;

library ArrayUtils {

  struct ArrayList {
      mapping(address => bool) addressToExistsMapping;
      mapping(address => uint) addressToIndexMapping;
      mapping(uint => address) indexToAddressMapping;
      uint numberOfValues;
  }

  function insert(ArrayList storage self, address value)
      returns (bool)
  {
      if (self.addressToExistsMapping[value])
          return false; // it already exists
      self.addressToExistsMapping[value] = true; // it will exist
      self.addressToIndexMapping[value] = self.numberOfValues; // place it at the end
      self.indexToAddressMapping[self.numberOfValues] = value; // say that its at the end
      self.numberOfValues++ // the end is now 1 bigger
      return true;

  }

  function remove(ArrayList storage self, address value)
      returns (bool)
  {
      if (!self.addressToExistsMapping[value])
          return false; // cant remove what don't exist
      self.addressToExistsMapping[value] = false; // it wont exist
      emptyspot = self.addressToIndexMapping[value]; // Index position with empty place
      lastaddr = self.indexToAddressMapping[self.numberOfValues-1]; // Last value stored
      self.indexToAddressMapping[emptyspot]=lastaddr // Move last value stored to empty place
      self.numberOfValues--; // drop duplicatd last value
      delete self.addressToIndexMapping[value]; // remove removed value actually
      // delete self.indexToAddressMapping[self.addressToIndexMapping[value]];
      return true;
  }

  function contains(ArrayList storage self, address value)
      returns (bool)
  {
      return self.addressToExistsMapping[value];
  }

  function indexOf(ArrayList storage self, address value)
      returns (uint)
  {
      if (!self.addressToExistsMapping[value])
          return uint(-1);
      return self.addressToIndexMapping[value];
  }
}
