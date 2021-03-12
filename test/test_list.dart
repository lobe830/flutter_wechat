/*
 * @Description: 测试List的属性和方法
 * @Author: liuaobo
 * @Date: 2021-03-11 14:07:46
 * @LastEditTime: 2021-03-11 14:12:11
 * @LastEditors: liuaobo
 * @Reference: 
 */

void main() {
  testMap([1, 5, 4, 3, 1]);
}

testMap<T>(List<T> dataSource) {
  print("dataSource = ${dataSource.toString()}");
  Iterable<List<T>> newResult = dataSource.map((e) => [e]);
  print("after list.map. result = ${newResult.toString()}");
}
