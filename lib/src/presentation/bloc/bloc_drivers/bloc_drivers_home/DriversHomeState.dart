import 'package:equatable/equatable.dart';

class DriversHomeState extends Equatable {
  //cambia cada vez que se cambia de pagina
  final int pageIndex;

  DriversHomeState({this.pageIndex = 0});

  DriversHomeState copyWith({
    int? pageIndex
    }) {
    return DriversHomeState(
      pageIndex: pageIndex ?? this.pageIndex
      );
  }

  @override
  List<Object?> get props => [pageIndex];
}
