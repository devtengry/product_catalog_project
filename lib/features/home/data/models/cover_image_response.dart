class CoverImageResponse {
  final String imageUrl;

  CoverImageResponse({required this.imageUrl});

  factory CoverImageResponse.fromJson(Map<String, dynamic> json) {
    return CoverImageResponse(
      imageUrl: json['action_product_image']['url'],
    );
  }
}
