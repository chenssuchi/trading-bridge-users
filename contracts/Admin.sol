// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "./Invitation.sol";

contract Admin {

    address public invitation_;
    address private _admin;
    address private _owner;

    modifier onlyOwner() {
        require(_owner == msg.sender, "Ownable: caller is not the owner");
        _;
    }

    modifier onlyAdmin() {
        require(_admin == msg.sender || _owner == msg.sender, "Ownable: caller is not the admin");
        _;
    }

    function setAdmin(address __admin) external onlyOwner
    {
        _admin = __admin;
    }

    constructor () {
        _owner = msg.sender;
    }

    function adminSetInvitation(address _invitation) external onlyOwner
    {
        invitation_ = _invitation;
    }

    function postBatch(address[] calldata _senders, address[] calldata _supers) external onlyAdmin
    {
        Invitation  invitation = Invitation(invitation_);
        for (uint256 i; i < _senders.length; i++) {
            invitation.post(_senders[i], _supers[i]);
        }
    }
}