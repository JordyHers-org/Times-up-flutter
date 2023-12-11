part of 'child_side_bloc.dart';

@immutable
abstract class ChildSideState {}

class ChildSideInitial extends ChildSideState {}

class ChildSideFetching extends ChildSideState {}

class ChildSideAppList extends ChildSideState {}

class ChildSideNotification extends ChildSideState {}
