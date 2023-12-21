// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.22;

import "forge-std/Test.sol";
import {GreetingsRegistry} from "@src/GreetingsRegistry/GreetingsRegistry.sol";

contract GreetingsRegistryTest is Test {
	event MessageChanged(address indexed user, string message);

	GreetingsRegistry registry;
	string prefix;

	function setUp() public {
		prefix = "hh_";
		registry = new GreetingsRegistry(prefix);
	}

	function testSetMessage() public {
		string memory message = "Hello";
		registry.setMessage(message);
		assertEq(registry.messages(address(this)), string(abi.encodePacked(prefix, message)));
	}

	function testSetMessageEvent() public {
		string memory message = "Hello";

		vm.expectEmit(true, true, false, false, address(registry));
		emit MessageChanged(address(this), string(abi.encodePacked(prefix, message)));
		registry.setMessage(message);
	}
}
