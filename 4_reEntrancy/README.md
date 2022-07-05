# Re-Entrancy Attack (재진입공격)

### Subject
- 재진입공격으로 Treasury 또는 Staking 과 같은 CA에 보관한 ERC20 토큰에 대한 출금을 강제할 수 있다.
- Receive Function은 "이더리움을 수신하는 기능을 제공하며, 이더리움 수신 시 작동한다" 이 점을 활용해 이더리움을 수신하는 동시에 withdraw를 호출해 state값이 업데이트 되기 전에 재호출을 해서 재진입 공격을 진행한다.


### HOW TO SOLVE ?
1.
- 통상 재진입공격은 Re-Entrancy Guard를 통해 방지한다. (Openzeppelin 제공)
- 단, 재진입 공격을 방지하고자 Guard를 적용시키면 해당 스마트 컨트렉트 소스코드로 인해 추가적인 GasFee 상승을 야기한다.
- 아래는 Openzeppelin의 Re-Entrancy Guard 코드다.
- modifier에 state값으로 locking시키는 방식을 채택해 re-entrancy를 방지했다.
![cd](https://user-images.githubusercontent.com/66409384/177304732-2c8469ea-6a56-4087-b3d7-c19fa39f5aa1.png)


2. 
- 따라서 Smart Contract 개발 시 상태값 업데이트를 선 진행하는 방식과 
- call함수로 ERC-20 Token 전송 시 전송여부를 선 체크하는 방식으로 해결이 가능하다.


### Ref
https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/security/ReentrancyGuard.sol


