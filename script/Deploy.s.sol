// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Script.sol";
import {IJBDelegatesRegistry} from "@jbx-protocol/juice-delegates-registry/src/interfaces/IJBDelegatesRegistry.sol";
import {IJBOperatorStore} from "@jbx-protocol/juice-contracts-v3/contracts/interfaces/IJBOperatorStore.sol";
import {MyDelegate} from "./../src/MyDelegate.sol";
import {MyDelegateDeployer} from "./../src/MyDelegateDeployer.sol";
import {MyDelegateProjectDeployer} from "./../src/MyDelegateProjectDeployer.sol";

abstract contract Deploy is Script {
    function _run(IJBOperatorStore _operatorStore, IJBDelegatesRegistry _registry) internal {
        vm.broadcast();
        MyDelegate _delegateImplementation = new MyDelegate();
        MyDelegateDeployer _delegateDeployer = new MyDelegateDeployer(_delegateImplementation, _registry);
        new MyDelegateProjectDeployer(
              _delegateDeployer,
              _operatorStore
            );
    }
}

contract DeployMainnet is Deploy {
    IJBOperatorStore _operatorStore = IJBOperatorStore(0x6F3C5afCa0c9eDf3926eF2dDF17c8ae6391afEfb);
    IJBDelegatesRegistry _registry = IJBDelegatesRegistry(0x7A53cAA1dC4d752CAD283d039501c0Ee45719FaC);

    function run() public {
        _run(_operatorStore, _registry);
    }
}

contract DeployGoerli is Deploy {
    IJBOperatorStore _operatorStore = IJBOperatorStore(0x99dB6b517683237dE9C494bbd17861f3608F3585);
    IJBDelegatesRegistry _registry = IJBDelegatesRegistry(0xCe3Ebe8A7339D1f7703bAF363d26cD2b15D23C23);

    function setUp() public {}

    function run() public {
        _run(_operatorStore, _registry);
    }
}
