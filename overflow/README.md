# Storage Attack

### Subject
- Smart Contract OverFlow & UnderFlow 문제 (0.8.0 버전 이후로는 버전 내 체크로 revert ERR를 방출하므로 0.6.0 version으로 진행)

### Byte
- bit 당 내포할 수 있는 수는 아래 표와 같다. 이 값이 넘어가거나 또는 줄어든다면 예상치 못한 결과를 야기하게 된다.
<img width="1168" alt="Bytes" src="https://user-images.githubusercontent.com/66409384/175329762-a174a2dd-cadd-457e-b651-e117593f2e71.png">


### HOW TO SOLVE ?
- 0.8.0 이상의 솔리디티 버전을 사용.
- 연산에 대한 부분은 Openzepplin의 Safe Math Library를 사용해 Overflow와 Underflow를 방지.

### Info about uint256
- 일반적으로 사용하는 uint256 타입이 내포할 수 있는 값은 2^256 값으로 아래 그림과 같은 숫자를 가질 수 있다.
- 이를 테스트하기 위해서는 ethers.constant.MaxUint256을 이용해 테스트를 진행하자.

<img width="735" alt="Uint256" src="https://user-images.githubusercontent.com/66409384/175329793-a635a17a-ef06-4a1f-8f48-fe695a79ebb9.png">


