class LikeState {
  final bool isLiked;
  final bool isLoading;
  final String? errorMessage;

  LikeState({
    required this.isLiked,
    this.isLoading = false,
    this.errorMessage,
  });

  LikeState copyWith({
    bool? isLiked,
    bool? isLoading,
    String? errorMessage,
  }) {
    return LikeState(
      isLiked: isLiked ?? this.isLiked,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}
