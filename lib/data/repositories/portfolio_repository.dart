import '../../core/widgets/project_image.dart';
import '../../models/portfolio_models.dart';
import '../services/cv_service.dart';

const _featuredProjects = [
  Project(
    title: 'Anchor Prayer',
    description:
        'Cross-platform React Native app with modular screen architecture, REST-backed prayer CRUD (title, rich text, media attachments), community prayer circles with shared request feeds, FCM/local notification scheduling for reminders, and dynamic “verse of the day” content delivery. Implemented reusable navigation primitives, optimistic UI updates, and scalable state management for iOS and Android store releases.',
    imageUrl: 'assets/projects/anchor_prayer.png',
    tags: ['React Native', 'FCM', 'REST API'],
    tech: 'React Native',
    platform: 'App Store & Google Play',
  ),
  Project(
    title: 'Yalla Go Express — Driver App',
    description:
        'Production driver client for a multi-service logistics platform: real-time online/offline presence synced to backend, active-shift session lifecycle, ride history retrieval via REST APIs, and map-ready UI for dispatch workflows. Built with performance-focused component structure, driver onboarding flows, and store-ready branding for iOS and Android distribution.',
    imageUrl: 'assets/projects/yalla_go_driver.png',
    tags: ['React Native', 'GPS', 'Real-time'],
    tech: 'React Native · Node.js',
    platform: 'App Store & Google Play',
  ),
  Project(
    title: 'Remembery',
    description:
        'React Native productivity app combining lost-item tracking, task/reminder orchestration, and configurable push notifications. Features drawer-based navigation, persisted user preferences, feed modules for activity streams, and native notification channel integration. Structured for offline-first local state with API sync and responsive layouts across phone form factors.',
    imageUrl: 'assets/projects/remembery.png',
    tags: ['React Native', 'Notifications', 'Local DB'],
    tech: 'React Native',
    platform: 'App Store & Google Play',
  ),
  Project(
    title: 'My Sales Reviews',
    description:
        'Full-stack Trustpilot-style marketplace connecting buyers with verified sales professionals. Implements authenticated seller profiles, review submission with moderation hooks, industry/location faceted search, aggregated rating algorithms, and responsive web dashboards. REST API layer with role-based access, relational data modeling for professionals ↔ reviews, and deployment-ready SEO landing flows.',
    imageUrl: 'assets/projects/my_sales_reviews.png',
    tags: ['Full Stack', 'REST API', 'Web'],
    tech: 'React.js · Node.js',
    platform: 'Web',
  ),
];

const _relatedProjects = [
  Project(
    title: 'Flutter Audio Cropper',
    description:
        'Open-source Flutter plugin exposing native audio decode/trim pipelines via platform channels. Published to pub.dev with Dart API surface, waveform-friendly seek boundaries, and example apps for mobile/web consumers integrating media workflows.',
    imageUrl: ProjectImage.flutterLogoKey,
    tags: ['Flutter', 'Open Source', 'pub.dev'],
    tech: 'Flutter · Dart',
    platform: 'Mobile & Web',
  ),
];

const _mockPortfolioData = PortfolioData(
  name: 'Moazzam Shah Khan',
  role: 'Software Engineer (Mobile & Web)',
  bio:
      'Flutter, React Native & full-stack systems — cross-platform apps, real-time delivery platforms, and production-ready web dashboards.',
  about:
      'Software Engineer at Mattrics Pvt. Ltd. building cross-platform mobile and web products with Flutter, React Native, React.js, and Node.js. BSc Computer Science from Bahria University of Karachi (2019–2024). Focused on real-time systems, scalable backends, payments, and GPS tracking.',
  profileImageUrl: 'assets/images/profile.png',
  yearsExp: '4+',
  projectCount: 5,
  coreTech: [
    'Flutter',
    'Dart',
    'React Native',
    'React.js',
    'Node.js',
    'Firebase',
    'JavaScript',
  ],
  skills: [
    Skill(name: 'Dart', proficiency: 92),
    Skill(name: 'Kotlin', proficiency: 78),
    Skill(name: 'JavaScript', proficiency: 80),
    Skill(name: 'Flutter', proficiency: 94),
    Skill(name: 'React Native', proficiency: 85),
    Skill(name: 'Jetpack Compose', proficiency: 74),
    Skill(name: 'React.js', proficiency: 84),
    Skill(name: 'Node.js', proficiency: 82),
    Skill(name: 'Firebase', proficiency: 88),
    Skill(name: 'Supabase', proficiency: 76),
    Skill(name: 'REST APIs', proficiency: 83),
    Skill(name: 'Stripe', proficiency: 75),
    Skill(name: 'Google Maps', proficiency: 78),
    Skill(name: 'Git', proficiency: 81),
    Skill(name: 'Figma', proficiency: 72),
  ],
  featuredProjects: _featuredProjects,
  relatedProjects: _relatedProjects,
  experiences: [
    Experience(
      role: 'Software Engineer',
      company: 'Mattrics Pvt. Ltd. · Pakistan',
      duration: 'Aug 2023 – Present',
      description:
          '• Engineered cross-platform mobile and web apps with Flutter, React Native, React.js, and Node.js.\n'
          '• Built a multi-role real-time delivery platform (Customer, Rider, Vendor) with synchronized mobile and web systems.\n'
          '• Developed real-time order lifecycle with Firestore streams for live updates across clients.\n'
          '• Integrated Stripe with webhook verification and REST APIs for mobile–web communication.\n'
          '• Designed scalable backend architecture and GPS live tracking with background location updates.\n'
          '• Implemented FCM push notifications and delivered production dashboards, marketplaces, and subscription systems.',
      isActive: true,
    ),
    Experience(
      role: 'BSc Computer Science',
      company: 'Bahria University of Karachi · Pakistan',
      duration: '2019 – 2024',
      description:
          'Computer Science degree with focus on software engineering, mobile development, and full-stack systems.',
      isActive: false,
    ),
  ],
  email: 'moazzamshahkhan08@gmail.com',
  phone: '+92 304-8210351',
  linkedInUrl: 'https://linkedin.com/in/moazzamshahk',
  githubUrl: 'https://github.com/moazzamshah21',
  cvAssetPath: CvService.assetPath,
);

class PortfolioRepository {
  const PortfolioRepository();

  Future<PortfolioData> fetchPortfolio() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return _mockPortfolioData;
  }
}
