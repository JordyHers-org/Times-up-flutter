part of 'child_side_bloc.dart';

@immutable
abstract class ChildSideEvent {}

class GetNotifications extends ChildSideEvent {}

class GetAppList extends ChildSideEvent {}
