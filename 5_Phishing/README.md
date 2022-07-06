# tx-Origin VS msg.sender

### Subject
- msg.sender 는 해당 컨트렉트를 호출한 호출 컨트렉트 또는 EOA를 가르킨다.
- 이에 반해 tx.sender의 경우에는 최초 호출자 EOA를 가르킨다.
- 아래 그림 참조.

![txorigin](https://user-images.githubusercontent.com/66409384/177474353-60c4f252-b620-49f7-8fed-c59e77e339ad.png)


### HOW TO SOLVE ?
- tx.origin을 통한 Auth 구현을 하면 안된다.


### Ref
- https://medium.com/coinmonks/solidity-tx-origin-attacks-58211ad95514
