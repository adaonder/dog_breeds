class ApiResponse<T> {
  late T? message;
  late String? status;

  ApiResponse({this.message, this.status});

  Map<String, dynamic> toMap() {
    return {
      'message': this.message,
      'status': this.status,
    };
  }

  factory ApiResponse.fromMap(Map<String, dynamic> map) {
    return ApiResponse(
      message: map['message'] as T,
      status: map['status'] as String,
    );
  }
}