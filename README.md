# Denial Of Service Attack ( UUPS Upgradeable )

One who donates higher amount of Ether, becomes the King! 

But, a malicious attacker comes with a logic to not accept Ether which completely breaks the GAME! ( DOS ATTACK! )

Let's see how it happens.

But...but... fun part is dev made this contract (UUPS) upgradeable due to which it solved the bug, upgraded the proxy and deployed another game contract without losing any Ether! 

## Test the game on Remix-IDE

Steps to deploy and test `KingOfEther` contract in Remix : 

```
- Open the `KingOfEther.sol` and `DOSAttack.sol` in Remix-IDE. 
- Select `KingOfEther.sol` in left sidebar, select `Deploy with proxy` and Deploy it. ( It may ask for 2 confirmations about deploying proxy, you may accept.)
- Now select `DOSAttack.sol` file and then in left sidebar, select `Deploy with proxy` and provide the `Address of KingOfEther Proxy` as the argument and select Deploy.
- You can deposit some test Eth to KingOfEther to set the king and topDeposit value.
- Now you may call Attack function of Attack.sol with some test Eth, higher than topDeposit amount.
- As you can check, `Attack contract Proxy` is now the king!
- Now... if anyone tries to deposit higher than topDeposit value, it will fail.
```

Since, KingOfEther proxy contract will try to send previously deposited ether to king which is in our case the Attack proxy but due to intentionally missed ( receive() or fallback() function) , Attack proxy can't receive Ether. This breaks the function before updating the new king which reverts the transaction.

```
- To fix this, open `KingOfEtherV2.sol` in Remix.
- Select `upgrade the proxy` and input previously deployed `KingOfEther proxy contract address` as argument.
- It will ask for two confirmations for upgrading previously deployed proxy, you may accept.
- Now you have `KingOfEtherV2 proxy address` which you may ponder, is same as `KingOfEther proxy address`.
- What it did? It deployed `KingOfEtherV2.sol` and upgraded the previous proxy contract `implementation address` to the newer version of game contract!
```
And the best part, `Without changing any of the state variable values!`

How amazing is this...!

You may check that in proxy, king is still attack proxy address and topDeposit is unchanged.

But now you have a way out since you solved the bug and seperated out the `withdraw()`. Now only person who will be having issues is the attack deployed as their Eth is gone forever! ( By adding a mapping, it just increases the uint for the respective address and allows new king assignment. )

## Test the game in public testnet ( Eg. Ropsten ) 

Quick glance of how it may appear once you successfully deploy it on testnet :

```
Deploying KingOfEther contract...
KingOfEther Proxy Contract deployed at :  0xF4c89f95b91234e690A6f04dF923f8866f7B15a2
KingOfEther Implementation address via (getImplementationAddress) :  0x73179055409eC8eF35195629024cc5Bfa6A79A71
Deploying DOS Attack contract...
DOS Attack Proxy Contract deployed at :  0x2809B1480912d26fB4e8DD6DA23794fB86488a57
DOS Attack Implementation address via (getImplementationAddress) :  0x5cE28cAE117aDABb1144FdFb7782Fe0a4bB2eEE1
```
And the upgrade...
```
Deploying KingOfEtherV2...
KingOfEtherV2 proxy contract deployed at :  0xF4c89f95b91234e690A6f04dF923f8866f7B15a2
KingOfEtherV2 contract deployed at :  0xAA994125F90eDDc3C74b7293149964c5f275F68A
```

Deploy scripts are already available with you as you cloned the repository. Just follow the `Pre-requisites` by following the [guide](https://github.com/ishinu/Re-Entrancy-Hack-Upgradeable-) and you are set to test on public testnet!