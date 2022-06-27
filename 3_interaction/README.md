# Overflow & Underflow Attack

### Subject
- Smart Contract간 통신을 위해서는 Interface가 필요하다는 점.
- transfer 함수의 토큰전송 방식은 2300의 Gas Limit을 가진다는 점.
- receive function이 존재해야만 Ether 또는 기타 Layer2 Coin의 보유가 가능하다는 점. 

### Byte
- EIP-1884에 따르면 가스 비용이 변경되었다.

### OPCODE OF ETHEREUM

- MLOAD(p): 메모리의 특정 위치(p)에 있는 32바이트(1 워드)를 읽습니다. OPCODE는 이를 스택의 top에 저장, Assembly에서는 변수에 저장되거나 다른 연산의 피연산자로 사용될 수 있다. (expression)

- SOLAD : MLOAD와의 다른 점은 어카운트의 스토리지를 읽는다. 스토리지의 자료구조는 Trie 이며 (key, value) 쌍을 저장. 여기서 key는 해당 value를 찾기 위한 Trie의 path (p)로 사용.

- EXTCODESIZE(a): 어카운트 a 의 코드 사이즈를 반환. 

<img width="1228" alt="무제" src="https://user-images.githubusercontent.com/66409384/175953849-96198e49-3ec6-4ea0-8661-78179d40484e.png">


### HOW TO SOLVE ?
- transfer 함수 사용을 지양하고, call 방식의 전송방식을 채택.


### REF
- https://docs.soliditylang.org/en/v0.4.24/assembly.html#opcodes

- https://medium.com/onther-tech/solidity-assembly-abi-encoding-db8f79d1c1a1
