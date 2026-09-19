enum OnboardingStatus {
  initial,
  loading,
  completed,
  failure,
}

class OnboardingState {
  final OnboardingStatus status;
  final int currentPage;
  final int totalPages;
  final String? errorMessage;

  const OnboardingState({
    this.status = OnboardingStatus.initial,
    this.currentPage = 0,
    this.totalPages = 3,
    this.errorMessage,
  });

  bool get isLoading => status == OnboardingStatus.loading;
  bool get isCompleted => status == OnboardingStatus.completed;
  bool get isLastPage => currentPage == totalPages - 1;
  bool get isFirstPage => currentPage == 0;

  OnboardingState copyWith({
    OnboardingStatus? status,
    int? currentPage,
    int? totalPages,
    String? errorMessage,
  }) {
    return OnboardingState(
      status: status ?? this.status,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      errorMessage: errorMessage,
    );
  }

  OnboardingState nextPage() {
    return copyWith(currentPage: currentPage + 1);
  }

  OnboardingState asLoading() {
    return copyWith(
      status: OnboardingStatus.loading,
      errorMessage: null,
    );
  }

  OnboardingState asCompleted() {
    return copyWith(
      status: OnboardingStatus.completed,
      errorMessage: null,
    );
  }

  OnboardingState asFailure(String message) {
    return copyWith(
      status: OnboardingStatus.failure,
      errorMessage: message,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OnboardingState &&
          other.status == status &&
          other.currentPage == currentPage &&
          other.totalPages == totalPages &&
          other.errorMessage == errorMessage;

  @override
  int get hashCode =>
      status.hashCode ^
      currentPage.hashCode ^
      totalPages.hashCode ^
      errorMessage.hashCode;
}
