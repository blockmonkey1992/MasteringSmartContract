# Smart Contract Decimals


## Conclusion
- 기본적으로 솔리디티에서는 소수 처리가 불가함.
- 따라서 Tric으로 정수 값으로 곱셈한 뒤, 나누어 근접한 결과를 도출해 낼 수 있음.
- 계산 식이 복잡해지면 정확한 수치를 얻어내는데 어려움이 있음.


## Other Case
- Uniswap 사례 (112 bit 정수저장 , 112 bit 소수저장, 32bit timestamp저장) 하여 고정 소수점과 유사한 자료형을 만드는 방식 채택 


![Solidity](https://user-images.githubusercontent.com/66409384/177500680-6872a8be-85b6-4aa6-824c-c36701048c82.png)
