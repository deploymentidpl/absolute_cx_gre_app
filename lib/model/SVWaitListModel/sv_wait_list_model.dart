class SVWaitListBaseModel {
  late bool success;
  late String message;
  late List<SVWaitListModel> data;

  SVWaitListBaseModel() {
    success = false;
    message = "";
    data = [];
  }

  SVWaitListBaseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] ?? false;
    message = json['message'] ?? "";
    data = <SVWaitListModel>[];
    if (json['SVWaitlist'] != null) {
      json['SVWaitlist'].forEach((v) {
        data.add(SVWaitListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['SVWaitlist'] = this.data.map((v) => v.toJson()).toList();
    return data;
  }
}

class SVWaitListModel {
  late int order;
  late String token;
  late Owner owner;
  late Details details;
  late String status;
  late Project project;
  late Source source;
  late SourcingManager sourcingManager;
  late Date date;

  SVWaitListModel() {
    order = 0;
    token = "";
    owner = Owner();
    details = Details();
    status = "";
    project = Project();
    source = Source();
    sourcingManager = SourcingManager();
    date = Date();
  }

  SVWaitListModel.fromJson(Map<String, dynamic> json) {
    order = json['order'] ?? 0;
    token = json['token'] ?? "";
    owner = (json['owner'] != null ? Owner.fromJson(json['owner']) : Owner());
    details = (json['details'] != null ? Details.fromJson(json['details']) : Details());
    status = json['status'] ?? "";
    project = (json['project'] != null ? Project.fromJson(json['project']) : Project());
    source = (json['source'] != null ? Source.fromJson(json['source']) : Source());
    sourcingManager = (json['sourcing_manager'] != null ? SourcingManager.fromJson(json['sourcing_manager']) : SourcingManager());
    date = (json['date'] != null ? Date.fromJson(json['date']) : Date());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order'] = order;
    data['token'] = token;
    data['owner'] = owner.toJson();
    data['details'] = details.toJson();
    data['status'] = status;
    data['project'] = project.toJson();
    data['source'] = source.toJson();
    data['sourcing_manager'] = sourcingManager.toJson();
    data['date'] = date.toJson();
    return data;
  }
}

class Owner {
  late String name;
  late String image;
  late bool claim;

  Owner() {
    name = "";
    image = "";
    claim = false;
  }

  Owner.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    image = json['image'] ?? "";
    claim = json['claim'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['claim'] = claim;
    return data;
  }
}

class Details {
  late int priority;
  late String id;
  late bool cp;
  late bool missedCall;

  Details() {
    priority = 0;
    id = "";
    cp = false;
    missedCall = false;
  }

  Details.fromJson(Map<String, dynamic> json) {
    priority = json['priority'] ?? 0;
    id = json['id'] ?? "";
    cp = json['cp'] ?? false;
    missedCall = json['missed_call'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['priority'] = priority;
    data['id'] = id;
    data['cp'] = cp;
    data['missed_call'] = missedCall;
    return data;
  }
}

class Project {
  late String location;
  late String projectName;
  late String bhk;
  late String price;

  Project() {
    location = "";
    projectName = "";
    bhk = "";
    price = "";
  }

  Project.fromJson(Map<String, dynamic> json) {
    location = json['location'] ?? "";
    projectName = json['project_name'] ?? "";
    bhk = json['bhk'] ?? "";
    price = json['price'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location'] = location;
    data['project_name'] = projectName;
    data['bhk'] = bhk;
    data['price'] = price;
    return data;
  }
}

class Source {
  late String icon;
  late String name;

  Source() {
    icon = "";
    name = "";
  }

  Source.fromJson(Map<String, dynamic> json) {
    icon = json['icon'] ?? "";
    name = json['name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['icon'] = icon;
    data['name'] = name;
    return data;
  }
}

class SourcingManager {
  late String name;
  late String image;

  SourcingManager() {
    name = "";
    image = "";
  }

  SourcingManager.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    image = json['image'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}

class Date {
  late String startDate;
  late String endDate;

  Date() {
    startDate = "";
    endDate = "";
  }

  Date.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'] ?? "";
    endDate = json['end_date'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    return data;
  }
}
