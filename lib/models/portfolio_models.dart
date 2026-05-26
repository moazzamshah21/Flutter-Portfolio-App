class Skill {
  const Skill({required this.name, required this.proficiency});

  final String name;
  final int proficiency;
}

class Project {
  const Project({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.tags,
    required this.tech,
    required this.platform,
  });

  final String title;
  final String description;
  final String imageUrl;
  final List<String> tags;
  final String tech;
  final String platform;
}

class Experience {
  const Experience({
    required this.role,
    required this.company,
    required this.duration,
    required this.description,
    required this.isActive,
  });

  final String role;
  final String company;
  final String duration;
  final String description;
  final bool isActive;
}

class PortfolioData {
  const PortfolioData({
    required this.name,
    required this.role,
    required this.bio,
    required this.about,
    required this.profileImageUrl,
    required this.yearsExp,
    required this.projectCount,
    required this.coreTech,
    required this.skills,
    required this.featuredProjects,
    required this.relatedProjects,
    required this.experiences,
    required this.email,
    required this.phone,
    required this.linkedInUrl,
    required this.githubUrl,
    required this.cvAssetPath,
  });

  final String name;
  final String role;
  final String bio;
  final String about;
  final String profileImageUrl;
  final String yearsExp;
  final int projectCount;
  final List<String> coreTech;
  final List<Skill> skills;
  final List<Project> featuredProjects;
  final List<Project> relatedProjects;

  List<Project> get allProjects => [...featuredProjects, ...relatedProjects];
  final List<Experience> experiences;
  final String email;
  final String phone;
  final String linkedInUrl;
  final String githubUrl;
  final String cvAssetPath;
}
