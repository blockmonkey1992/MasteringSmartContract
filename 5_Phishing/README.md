# tx-Origin VS msg.sender

### Subject
- msg.sender 는 해당 컨트렉트를 호출한 호출 컨트렉트 또는 EOA를 가르킨다.
- 이에 반해 tx.sender의 경우에는 최초 호출자 EOA를 가르킨다.
- 아래 그림 참조.



### HOW TO SOLVE ?
- tx.origin을 통한 Auth 구현을 하면 안된다.


