class ApiResponse<T> {
  final int? code;
  final List<T> data;
  final String? message;

  ApiResponse({
    this.code,
    required this.data,
    this.message,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
        
    // Kiểm tra nếu 'data' không tồn tại hoặc không phải kiểu List, gán dữ liệu mặc định
    var dataList = (json['data'] as List?)
            ?.map<T>((item) => fromJsonT(item as Map<String, dynamic>))
            .toList() ??
        [];

    return ApiResponse(
      code: json['code'] as int?, // Giữ lại giá trị null nếu không có
      data: dataList,
      message: json['message'] as String?, // Giữ lại giá trị null nếu không có
    );
  }
}
