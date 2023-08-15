part of 'orders_cubit.dart';

@immutable
abstract class OrdersState {}

class OrdersInitial extends OrdersState {}
class FetchOrdersLoading extends OrdersState {}
class FetchOrdersLoaded extends OrdersState {}
class FetchOrdersEmpty extends OrdersState {}
class FetchOrdersFailed extends OrdersState {}

