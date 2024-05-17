import 'package:flutter/material.dart';

class DescriptionPage extends StatelessWidget {
  final String title;

  const DescriptionPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title == 'Beach') _buildBeachDescription(),
              if (title == 'Cuisine') _buildCuisineDescription(),
              if (title == 'Hiking') _buildHikingDescription(),
              if (title == 'Ice') _buildIceDescription(),
              if (title == 'Desert') _buildDesertDescription(),
              if (title == 'Old Cities') _buildOldCitiesDescription(),
              if (title == 'Historical Places')
                _buildHistoricalPlacesDescription(),
              if (title == 'River') _buildRiverDescription(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBeachDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Explore Pristine Beaches',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Image.asset(
          'assets/images/catalog/beach.jpg',
          height: 200,
          width: 500,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 16),
        const Text(
          'Our country is blessed with some of the most breathtaking beaches in the world. From golden sandy shores to secluded coves, our beaches offer something for everyone.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text(
          'Tunisia boasts a stunning coastline, with its beautiful beaches stretching from the Mediterranean Sea to the Atlantic Ocean. Each beach offers a unique experience, from the tranquil waters of the Gulf of Gabes to the vibrant nightlife of the beachfronts in Sousse and Monastir.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text(
          "Whether you're looking for a quiet spot to relax or a lively place to party, Tunisia's beaches have something to offer. From the ancient ruins of Carthage to the modern resorts of Hammamet, there's a beach for every mood and preference.",
          style: TextStyle(fontSize: 16),
        ),
       ],
    );
  }

  Widget _buildCuisineDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Savor the Flavors of Our Diverse Cuisine',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Image.asset(
          'assets/images/catalog/cuisine.jpeg',
          height: 200,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 16),
        const Text(
          'Our culinary scene is a melting pot of flavors and influences from various cultures. From traditional dishes to modern fusion creations, our restaurants offer a delightful dining experience for every palate.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text(
          "Tunisian cuisine is a blend of Mediterranean, North African, and French influences. From the spicy and aromatic tagines to the fresh seafood dishes, Tunisia's culinary heritage is rich and varied.",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text(
          'Explore the vibrant markets of Tunis, where you can find everything from fresh produce to exotic spices. Or, dine in one of the many renowned restaurants that have earned Tunisia a reputation for its culinary excellence.',
          style: TextStyle(fontSize: 16),
        ),
       ],
    );
  }

 
  Widget _buildHikingDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Explore Tunisia's Breathtaking Hiking Trails",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Image.asset(
          'assets/images/catalog/hiking.jpg',
          height: 200,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 16),
        const Text(
          'Tunisia offers a diverse range of hiking trails, from the rugged mountains of the Atlasic Range to the lush oases of the Sahara Desert. Whether you are an experienced hiker or a beginner, you will find trails that suit your skill level and interests.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text(
          'Explore the breathtaking Jebel Chambi National Park, where you can hike through dense forests, past stunning waterfalls, and even spot rare wildlife like the Barbary deer. For a more challenging hike, tackle the El Haouaria Trail in the Kroumirie Mountains, known for its steep ascents and breathtaking panoramic views.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text(
          'No matter which trail you choose, you will be rewarded with stunning vistas, fresh mountain air, and a deep connection with nature. So, lace up your hiking boots and get ready to explore the natural wonders of Tunisia.',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildIceDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Experience the Thrill of Ice Climbing',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Image.asset(
          'assets/images/catalog/ice_climbing.jpg',
          height: 200,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 16),
        const Text(
          'For the adventurous souls, Tunisia offers an exhilarating experience – ice climbing. In the rugged mountains of the Atlasic Range, you can find frozen waterfalls and icy cliffs that challenge even the most experienced climbers.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text(
          'With expert guides and top-notch equipment, you can safely navigate these icy terrains, scaling frozen walls and conquering vertical challenges. The thrill of conquering these frozen obstacles is unmatched, and the views from the top are simply breathtaking.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text(
          'Ice climbing in Tunisia is not just a physical challenge but also a test of mental fortitude. It requires focus, determination, and a sense of adventure. Whether you are an experienced climber or a beginner, this unique experience will push your limits and create memories that will last a lifetime.',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildDesertDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'chenenni',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Image.asset(
          'assets/images/catalog/Chenini.jpg',
          height: 200,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 16),
        const Text(
          'Journey back in time at Chenini, a ruined Berber village perched on a Tunisian hilltop. ',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text(
          "Explore a maze of troglodyte dwellings, where ancient granaries and a striking white mosque stand watch over the desert landscape.",
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text(
          ' Chenini is a unique stop on Tunisia s ksar trail, offering a glimpse into a bygone era and the traditional Berber way of life.  Don t miss this chance to wander through history!',
          style: TextStyle(fontSize: 16),
        ),
       ],
    );

    return Column();
  }

  Widget _buildOldCitiesDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Explore the Ancient Cities of Tunisia',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Image.asset(
          'assets/images/catalog/old_cities.jpg',
          height: 200,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 16),
        const Text(
          'Tunisia is a land steeped in history, with ancient cities that have stood the test of time. From the iconic city of Carthage to the well-preserved medinas of Tunis and Sousse, these cities offer a glimpse into the rich cultural heritage of the region.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text(
          'Wander through the narrow alleyways of the medina in Tunis, where you can experience the sights, sounds, and smells of a traditional North African marketplace. Visit the archaeological site of Carthage, once a powerful ancient city and a rival to Rome, and marvel at the impressive ruins that still stand today.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text(
          'In the city of Kairouan, explore the Great Mosque, one of the most important mosques in the Islamic world, and learn about the rich history and architecture of this UNESCO World Heritage Site. No matter which ancient city you visit, you will be transported back in time, immersed in the richness of Tunisia\'s past.',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildHistoricalPlacesDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Discover the Rich Historical Places of Tunisia',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Image.asset(
          'assets/images/catalog/historical_places.jpg',
          height: 200,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 16),
        const Text(
          'Tunisia is a treasure trove of historical places, each with its own unique story to tell. From ancient Roman ruins to medieval fortresses, this country offers a fascinating journey through time.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text(
          'Visit the legendary El Jem Amphitheater, a stunning example of Roman architecture that once hosted gladiatorial battles and public events. Explore the fortified city of Kerkouane, a UNESCO World Heritage Site that dates back to the 6th century BC and offers insights into the ancient Punic civilization.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text(
          'In the city of Dougga, discover the ruins of a well-preserved Roman city, including temples, theaters, and public baths that offer a glimpse into the daily life of ancient civilizations. For a truly unique experience, visit the Troglodyte dwellings of Matmata, where entire communities have carved homes into the rock formations, creating a fascinating underground world.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text(
          'Whether you are a history buff or simply appreciate the beauty of ancient architecture, Tunisia\'s historical places will leave you in awe, transporting you back in time and allowing you to walk in the footsteps of those who came before us.',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildRiverDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Explore the Majestic Rivers of Tunisia',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Image.asset(
          'assets/images/catalog/river.jpg',
          height: 200,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 16),
        const Text(
          'Tunisia is home to several majestic rivers that wind their way through the country, offering a unique and serene experience for nature lovers and adventure seekers alike.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text(
          'The Medjerda River, one of the longest rivers in Tunisia, flows through lush valleys and picturesque landscapes, providing opportunities for kayaking, fishing, and leisurely strolls along its banks. Along the way, you can explore charming villages and take in the breathtaking scenery.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text(
          'For those seeking a more adventurous experience, the Seldja River offers thrilling whitewater rafting opportunities as it rushes through the rugged canyons of the Khroumirie Mountains. With experienced guides and top-notch equipment, you can navigate the rapids and enjoy the adrenaline rush of this exhilarating activity.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8),
        const Text(
          'Whether you seek tranquility or adventure, Tunisia\'s rivers offer a unique and unforgettable experience, allowing you to connect with nature and create lasting memories.',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
