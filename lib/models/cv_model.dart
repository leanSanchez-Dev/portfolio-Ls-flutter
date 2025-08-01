class CVModel {
  final String name;
  final String title;
  final String email;
  final String phone;
  final String location;
  final String? github;
  final String? portfolio;
  final String summary;
  final List<String> languages;
  final List<CVExperience> experience;
  final List<CVEducation> education;
  final List<CVSkill> skills;
  final List<CVProject> projects;

  const CVModel({
    required this.name,
    required this.title,
    required this.email,
    required this.phone,
    required this.location,
    this.github,
    this.portfolio,
    required this.summary,
    required this.languages,
    required this.experience,
    required this.education,
    required this.skills,
    required this.projects,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'title': title,
      'email': email,
      'phone': phone,
      'location': location,
      'github': github,
      'portfolio': portfolio,
      'summary': summary,
      'languages': languages,
      'experience': experience.map((e) => e.toJson()).toList(),
      'education': education.map((e) => e.toJson()).toList(),
      'skills': skills.map((e) => e.toJson()).toList(),
      'projects': projects.map((e) => e.toJson()).toList(),
    };
  }

  factory CVModel.fromJson(Map<String, dynamic> json) {
    return CVModel(
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      location: json['location'] ?? '',
      github: json['github'],
      portfolio: json['portfolio'],
      summary: json['summary'] ?? '',
      languages: List<String>.from(json['languages'] ?? []),
      experience: (json['experience'] as List<dynamic>?)
              ?.map((e) => CVExperience.fromJson(e))
              .toList() ??
          [],
      education: (json['education'] as List<dynamic>?)
              ?.map((e) => CVEducation.fromJson(e))
              .toList() ??
          [],
      skills: (json['skills'] as List<dynamic>?)
              ?.map((e) => CVSkill.fromJson(e))
              .toList() ??
          [],
      projects: (json['projects'] as List<dynamic>?)
              ?.map((e) => CVProject.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class CVExperience {
  final String company;
  final String position;
  final String startDate;
  final String endDate;
  final String description;
  final List<String> achievements;

  const CVExperience({
    required this.company,
    required this.position,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.achievements,
  });

  Map<String, dynamic> toJson() {
    return {
      'company': company,
      'position': position,
      'startDate': startDate,
      'endDate': endDate,
      'description': description,
      'achievements': achievements,
    };
  }

  factory CVExperience.fromJson(Map<String, dynamic> json) {
    return CVExperience(
      company: json['company'] ?? '',
      position: json['position'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      description: json['description'] ?? '',
      achievements: List<String>.from(json['achievements'] ?? []),
    );
  }
}

class CVEducation {
  final String institution;
  final String degree;
  final String startDate;
  final String endDate;
  final String description;

  const CVEducation({
    required this.institution,
    required this.degree,
    required this.startDate,
    required this.endDate,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'institution': institution,
      'degree': degree,
      'startDate': startDate,
      'endDate': endDate,
      'description': description,
    };
  }

  factory CVEducation.fromJson(Map<String, dynamic> json) {
    return CVEducation(
      institution: json['institution'] ?? '',
      degree: json['degree'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class CVSkill {
  final String name;
  final String category;
  final double proficiency; // 0.0 to 1.0

  const CVSkill({
    required this.name,
    required this.category,
    required this.proficiency,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'proficiency': proficiency,
    };
  }

  factory CVSkill.fromJson(Map<String, dynamic> json) {
    return CVSkill(
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      proficiency: (json['proficiency'] ?? 0.0).toDouble(),
    );
  }
}

class CVProject {
  final String name;
  final String description;
  final List<String> technologies;
  final String? link;
  final String? github;

  const CVProject({
    required this.name,
    required this.description,
    required this.technologies,
    this.link,
    this.github,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'technologies': technologies,
      'link': link,
      'github': github,
    };
  }

  factory CVProject.fromJson(Map<String, dynamic> json) {
    return CVProject(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      technologies: List<String>.from(json['technologies'] ?? []),
      link: json['link'],
      github: json['github'],
    );
  }
}
