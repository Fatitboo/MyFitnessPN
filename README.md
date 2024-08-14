# MyFitnessPN

MyFitnessPN is a comprehensive fitness tracking and management application built using Flutter for the frontend and Spring Boot for the backend. This app helps users to set fitness goals, track their workouts, monitor their progress, and access personalized nutrition plans. It also features an AI-powered food recognition system to help users log their meals accurately.

## Table of Contents

1. [Features](#features)
2. [Technologies Used](#technologies-used)
3. [Getting Started](#getting-started)
   - [Prerequisites](#prerequisites)
   - [Installation](#installation)
4. [Project Structure](#project-structure)
5. [API Documentation](#api-documentation)
6. [AI Food Recognition](#ai-food-recognition)
7. [Contributing](#contributing)
8. [License](#license)

## Features

- User authentication (sign-up, login, and profile management)
- Fitness goal setting (weight loss, muscle gain, etc.)
- Workout tracking and progress monitoring
- Personalized nutrition plans based on user goals and preferences
- Integration with wearable devices (e.g., smartwatches) for activity tracking
- Social features (e.g., challenges, leaderboards, sharing progress)
- Offline support for workout plans and nutrition information
- AI-powered food recognition system to help users log their meals accurately

## Technologies Used

- **Frontend**: Flutter (Dart)
- **Backend**: Spring Boot (Java)
- **Database**: MySQL, MongoDB
- **Authentication**: Spring Security, JWT (JSON Web Tokens)
- **Notifications**: Firebase Cloud Messaging
- **AI Food Recognition**: TensorFlow Lite, OpenFoodFact

## Getting Started

### Prerequisites

- Flutter SDK (version 2.0.6 or higher)
- Java Development Kit (version 11 or higher)
- MySQL or MongoDB (local or cloud-hosted)
- Python (for the AI food recognition component)

### AI Food Recognition
  The MyFitnessPN app includes an AI-powered food recognition system that allows users to take a photo of their meal and have the app automatically identify the food items and log them in the user's daily calorie and nutrient intake. This feature is powered by a custom-trained TensorFlow Lite model, which is integrated into the backend API and accessed by the Flutter client.
