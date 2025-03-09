import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NotificationStatus {all, personalized, none} //กำหนดสถานะแจ้งเตือน

abstract class NotificationEvent extends Equatable{
  const NotificationEvent();
} //Event

class UpdateNotification extends NotificationEvent{
   final String channelID;
   final NotificationStatus status;
  const UpdateNotification(this.channelID,this.status);
  
  @override
  List<Object?> get props => [channelID,status];
}

class NotificationState extends Equatable{
  final Map<String, NotificationStatus> NotificationSetting;

  const NotificationState({required this.NotificationSetting});

  NotificationState copyWith({
    Map<String, NotificationStatus>?NotificationSetting,
  }){
    return NotificationState(NotificationSetting: NotificationSetting??this.NotificationSetting);
  }
  
  @override
  List<Object?> get props => [NotificationSetting];
}//State

class NotificationBloc extends Bloc<NotificationEvent,NotificationState>{
  NotificationBloc():super(const NotificationState(NotificationSetting: {})){
    on<UpdateNotification>((event,emit){
      final Updatesitting = Map<String , NotificationStatus>.from(state.NotificationSetting);
      Updatesitting[event.channelID] = event.status;
      emit(NotificationState(NotificationSetting: Updatesitting));
    });
  }
} //Bloc