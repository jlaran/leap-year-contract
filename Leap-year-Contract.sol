// Licence
// SPDX-License-Identifier: LGPL-3.0-only

// Version
pragma solidity 0.8.24;

contract LeapYear {

    // Variables
    uint16 currentYear = 2026;
    uint16 yearToCheck = 2027;
    
    // Events
    event yearEntered(uint16 yearToCheck);

    // Modifiers
    modifier checkPastYears(uint16 inputYear) {
        if(inputYear < currentYear) revert();
        _;
    }

    // Functions
        // External
        function isLeapYear (uint16 year_) public checkPastYears(year_) returns (bool leapYear_){
            emit yearEntered(yearToCheck);
            return checkYear(year_);
        }

        // Internal
        function checkYear (uint16 yearToCheck_) internal pure returns (bool){
            if((yearToCheck_ % 4 == 0 && yearToCheck_ % 100 != 0) || (yearToCheck_ % 400 == 0)){
                return true;
            } else {
                return false;
            }
        }

}