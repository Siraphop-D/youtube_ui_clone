
class HomeModel {
  String? videoUrl;
  String? duration;
  String? title;
  String? channelProfileUrl;
  String? channelName;
  String? view;
  String? dateTime;

  HomeModel(
      {this.videoUrl,
      this.duration,
      this.title,
      this.channelProfileUrl,
      this.channelName,
      this.view,
      this.dateTime});

  HomeModel.fromJson(Map<String, dynamic> json) {
    videoUrl = json['videoUrl'];
    duration = json['duration'];
    title = json['title'];
    channelProfileUrl = json['channelProfileUrl'];
    channelName = json['channelName'];
    view = json['view'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['videoUrl'] = this.videoUrl;
    data['duration'] = this.duration;
    data['title'] = this.title;
    data['channelProfileUrl'] = this.channelProfileUrl;
    data['channelName'] = this.channelName;
    data['view'] = this.view;
    data['dateTime'] = this.dateTime;
    return data;
  }
}