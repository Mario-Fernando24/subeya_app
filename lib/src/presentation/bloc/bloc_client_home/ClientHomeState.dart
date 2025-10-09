import 'package:equatable/equatable.dart';

class ClientHomeState extends Equatable {
  //cambia cada vez que se cambia de pagina
  final int pageIndex;

  ClientHomeState({this.pageIndex = 0});

  ClientHomeState copyWith({
    int? pageIndex
    }) {
    return ClientHomeState(
      pageIndex: pageIndex ?? this.pageIndex
      );
  }

  @override
  List<Object?> get props => [pageIndex];
}
