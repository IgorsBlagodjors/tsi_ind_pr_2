import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
sealed class LogInPageState with _$LogInPageState {
  const factory LogInPageState.initial() = Initial;
  const factory LogInPageState.loading() = Loading;
  const factory LogInPageState.empty() = EmptyState;
  const factory LogInPageState.loaded() = Loaded;
  const factory LogInPageState.error(String message) = ErrorState;
}
