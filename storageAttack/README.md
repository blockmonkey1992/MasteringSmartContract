# Storage Attack

### Subject
- 블록체인의 private 데이터에 대한 Storage를 통한 접근이 가능하다.

### Storage Layout
- 아래 그림처럼 각 변수 또는 Sturct값은 좌측의 인덱스값에 순서대로 차곡차곡 담기게된다. 따라서 여기에 대한 접근. (아래그림참조)

![storage](https://user-images.githubusercontent.com/66409384/175043674-eff3645d-12ca-4c85-bb3e-de12a02a0479.png)


### HOW TO SOLVE ?
- Secret Data는 'Keccak' 또는 다른 암호화 등을 활용해 해싱 값을 비교하는 절차를 통해 해결할 수 있다.
