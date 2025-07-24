class ActionBottomState {
  final bool isLiked;
  final bool isSaved;

  ActionBottomState({
    required this.isLiked,
    required this.isSaved,
  });

  factory ActionBottomState.initial() {
    return ActionBottomState(isLiked: false, isSaved: false);
  }

  ActionBottomState copyWith({
    bool? isLiked,
    bool? isSaved,
  }) {
    return ActionBottomState(
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}
