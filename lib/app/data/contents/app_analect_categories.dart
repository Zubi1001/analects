// ignore_for_file: constant_identifier_names

enum AnalectCategories {
  design,
  development,
  marketing,
  entrepreneurship,
  business_strategy,
  finance,
  leadership,
  technology,
  data_science,
  artificial_intelligence,
  cybersecurity,
  project_management,
  career_growth,
  productivity,
  innovation,
  product_management,
  user_experience,
  graphic_design,
  web_development,
  mobile_development,
  content_marketing,
  social_media,
  SEO,
  branding,
  sales,
  communication_skills,
  networking,
  remote_work,
  freelancing,
  retail,
  manufacturing,
  agriculture,
  construction,
  transportation,
  hospitality,
  healthcare,
  energy,
  real_estate,
  automotive,
  food_and_beverage,
  fashion,
  beauty,
  sports_and_fitness,
  education,
  environment_and_sustainability,
  entertainment,
  legal,
  human_resources,
  logistics,
  architecture,
  tourism,
  non_profit,
  government_and_policy,
}

extension Titles on AnalectCategories{
  String get title {
    switch (this) {
      case AnalectCategories.design:return  "Design";
      case AnalectCategories.development:return  "Development";
      case AnalectCategories.marketing:return  "Marketing";
      case AnalectCategories.entrepreneurship:return  "Entrepreneurship";
      case AnalectCategories.business_strategy:return  "Business Strategy";
      case AnalectCategories.finance:return  "Finance";
      case AnalectCategories.leadership:return  "Leadership";
      case AnalectCategories.technology:return  "Technology";
      case AnalectCategories.data_science:return  "Data Science";
      case AnalectCategories.artificial_intelligence:return  "Artificial Intelligence";
      case AnalectCategories.cybersecurity:return  "Cybersecurity";
      case AnalectCategories.project_management:return  "Project Management";
      case AnalectCategories.career_growth:return  "Career Growth";
      case AnalectCategories.productivity:return  "Productivity";
      case AnalectCategories.innovation:return  "Innovation";
      case AnalectCategories.product_management:return  "Product Management";
      case AnalectCategories.user_experience:return  "User Experience";
      case AnalectCategories.graphic_design:return  "Graphic Design";
      case AnalectCategories.web_development:return  "Web Development";
      case AnalectCategories.mobile_development:return  "Mobile Development";
      case AnalectCategories.content_marketing:return  "Content Marketing";
      case AnalectCategories.social_media:return  "Social Media";
      case AnalectCategories.SEO:return  "SEO";
      case AnalectCategories.branding:return  "Branding";
      case AnalectCategories.sales:return  "Sales";
      case AnalectCategories.communication_skills:return  "Communication Skills";
      case AnalectCategories.networking:return  "Networking";
      case AnalectCategories.remote_work:return  "Remote Work";
      case AnalectCategories.freelancing:return  "Freelancing";
      case AnalectCategories.retail:return  "Retail";
      case AnalectCategories.manufacturing:return  "Manufacturing";
      case AnalectCategories.agriculture:return  "Agriculture";
      case AnalectCategories.construction:return  "Construction";
      case AnalectCategories.transportation:return  "Transportation";
      case AnalectCategories.hospitality:return  "Hospitality";
      case AnalectCategories.healthcare:return  "Healthcare";
      case AnalectCategories.energy:return  "Energy";
      case AnalectCategories.real_estate:return  "Real Estate";
      case AnalectCategories.automotive:return  "Automotive";
      case AnalectCategories.food_and_beverage:return  "Food and Beverage";
      case AnalectCategories.fashion:return  "Fashion";
      case AnalectCategories.beauty:return  "Beauty";
      case AnalectCategories.sports_and_fitness:return  "Sports and Fitness";
      case AnalectCategories.education:return  "Education";
      case AnalectCategories.environment_and_sustainability:return  "Environment and Sustainability";
      case AnalectCategories.entertainment:return  "Entertainment";
      case AnalectCategories.legal:return  "Legal";
      case AnalectCategories.human_resources:return  "Human Resources";
      case AnalectCategories.logistics:return  "Logistics";
      case AnalectCategories.architecture:return  "Architecture";
      case AnalectCategories.tourism:return  "Tourism";
      case AnalectCategories.non_profit:return  "Non Profit";
      case AnalectCategories.government_and_policy:return  "Government and Policy";
      
        
      
      default: return "";
    }
  }
}
