import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_mvp_app/Events/user_model.dart';
import 'package:event_mvp_app/Utils/const.dart';
import 'package:uuid/uuid.dart';

List<String> randomNames = [
  "Rahul Sharma",
  "Priya Patel",
  "Amit Singh",
  "Divya Gupta",
  "Vikram Kumar",
  "Anjali Mishra",
  "Rajesh Tiwari",
  "Pooja Reddy",
  "Suresh Verma",
  "Anita Choudhary",
  "Kiran Mehta",
  "Sanjay Patel",
  "Neha Kapoor",
  "Ravi Sharma",
  "Ananya Singh",
  "Aditya Gupta",
  "Shivani Kumar",
  "Arjun Mishra",
  "Nisha Tiwari",
  "Vivek Reddy",
  "Mala Verma",
  "Deepak Choudhary",
  "Swati Saxena",
  "Rajiv Malhotra",
  "Kavita Sharma",
  "Rohit Mehta",
  "Preeti Patel",
  "Aryan Kapoor",
  "Smita Gupta",
  "Manoj Kumar"
];

List<String> randomTypes = [
  "Entrepreneur",
  "Mentor",
  "Entrepreneur",
  "Mentor",
  "Entrepreneur",
  "Mentor",
  "Entrepreneur",
  "Mentor",
  "Entrepreneur",
  "Mentor",
];

List<String> randomOccupations = [
  "Graphic Designer",
  "Architect",
  "Medical Doctor",
  "Event Planner",
  "Human Resources",
  "Photographer",
  "Public Relations",
  "Data Scientist",
  "Fitness Trainer",
  "Journalist",
  "Interior Designer",
  "Lawyer",
  "Social Influencer",
  "Musician",
  "Real Estate Agent",
  "Teacher",
  "Web Developer",
  "Travel Blogger",
  "Film Director"
];

List<String> randomBusinessIdeas = [
  "Virtual Reality Experience Center: Create a space where customers can immerse themselves in virtual reality simulations for entertainment, education, or training purposes.",
  "Renewable Energy Solutions Provider: Offer services and products related to renewable energy, such as solar panel installation, wind turbine maintenance, and energy-efficient solutions for homes and businesses.",
  "Healthcare Technology Platform: Develop a software platform that connects patients with healthcare providers, offers telemedicine services, manages medical records, and provides health monitoring tools.",
  "Sustainable Fashion Brand: Launch a fashion brand that focuses on sustainable and ethical practices, using eco-friendly materials, fair labor practices, and transparent supply chains.",
  "Co-Working Space for Creatives: Create a shared workspace tailored specifically for creative professionals, offering amenities such as art studios, photography equipment, and collaboration spaces.",
  " Personalized Nutrition and Meal Planning Service: Develop an online platform or app that analyzes users' dietary needs and preferences to provide personalized meal plans, grocery lists, and nutritional guidance.",
  "Urban Farming and Community Gardens: Start an initiative that promotes urban farming and community gardens, offering resources, education, and support for individuals and neighborhoods interested in growing their own food.",
  "Mobile App for Mental Health and Wellness: Develop a mobile app that provides resources, tools, and support for mental health and wellness, including meditation guides, mood tracking, therapy matching, and community forums.",
  "Green Cleaning Products Brand: Create a line of environmentally friendly and non-toxic cleaning products for homes and businesses, emphasizing sustainability, safety, and effectiveness.",
  "Customized Home Renovation Services: Offer personalized home renovation and remodeling services that cater to the specific needs and preferences of homeowners, focusing on quality craftsmanship, innovative design solutions, and eco-friendly materials."
];

List<UserModel> generateDummyUsers(int count) {
  List<UserModel> dummyUsers = [];

  for (int i = 0; i < count; i++) {
    String userId = const Uuid().v4();
    String phone = _generateRandomPhoneNumber();
    String name = _getRandomItem(randomNames);
    int age = Random().nextInt(80) + 18; // Random age between 18 and 97
    String type = _getRandomItem(randomTypes);
    bool isAvailable = Random().nextBool();
    bool isMale = Random().nextBool();
    List<String> skills = _generateRandomSkills();
    String occupation = _getRandomItem(randomOccupations);
    String businessIdea = _getRandomItem(randomBusinessIdeas);
    Timestamp timestamp = Timestamp.now();

    UserModel dummyUser = UserModel(
      userId: userId,
      phone: phone,
      name: name,
      age: age,
      type: type,
      isAvailable: isAvailable,
      isMale: isMale,
      skillsSelected: skills,
      occupation: occupation,
      businessIdea: businessIdea,
      timestamp: timestamp,
    );

    dummyUsers.add(dummyUser);
  }

  return dummyUsers;
}

String _generateRandomPhoneNumber() {
  // Random phone number generation with format XXX-XXX-XXXX
  Random random = Random();
  String areaCode = (100 + random.nextInt(900)).toString();
  String firstThreeDigits = (100 + random.nextInt(900)).toString();
  String lastFourDigits = (1000 + random.nextInt(9000)).toString();
  return "$areaCode-$firstThreeDigits-$lastFourDigits";
}

String _getRandomItem(List<String> list) {
  return list[Random().nextInt(list.length)];
}

List<String> _generateRandomSkills() {
  int numberOfSkills =
      Random().nextInt(5) + 1; // Randomly choose between 1 and 5 skills
  List<String> skills = [];
  for (int i = 0; i < numberOfSkills; i++) {
    skills.add(_getRandomItem(SkillsConst.allItems));
  }
  return skills;
}
