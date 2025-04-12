Future <void> fetchData() async {
  await Future.delayed(Duration(seconds: 2));
  print('Data fetched!');
}
void  main ()async {
  print("1. Bắt đầu");
  print("2. Đang xử lý");
  print("3. Kết thúc");

  print("1. Bắt đầu tải");
  await fetchData();
  print("2. Hoàn thành");
  
}
