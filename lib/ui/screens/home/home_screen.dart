import 'package:flutter/material.dart';
import 'package:reevie_web/extensions/context_extension.dart';
import 'package:reevie_web/ui/components/hover_notifer.dart';
import 'package:reevie_web/ui/components/movie_carosoul.dart';
import '../../components/statistic_view.dart';
import 'components/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  double _extra = 0;

  void _listenScroll() {
    if (_scrollController.position.extentAfter -
            _scrollController.position.maxScrollExtent >
        0) {
      setState(() {
        _extra =
            _scrollController.position.extentAfter -
            _scrollController.position.maxScrollExtent;
      });
    }
  }

  @override
  void initState() {
    _scrollController.addListener(_listenScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        controller: _scrollController,
        children: [
          SizedBox(
            width: double.infinity,
            height: _extra,
            child: Text(
              "Dude, Nothing Above 👀",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white54,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/top_background.png"),
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 40,
                vertical: context.mW * 0.15,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withValues(alpha: 0.5),
                    Colors.black.withValues(alpha: 0.9),
                    Colors.black.withValues(alpha: 0.9),
                    Colors.transparent,
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "Explore. Watch. Reevie.",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Tired of switching between apps? Reevie lets you explore top-rated and trending movies & shows in one beautifully designed platform.",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      fixedSize: Size.fromHeight(50),
                      backgroundColor: Colors.green,
                      shape: RoundedSuperellipseBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.download, color: Colors.white, size: 22),
                        const SizedBox(width: 4),
                        Text(
                          "Download",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple.withValues(alpha: 0.05),
                  Colors.white.withValues(alpha: 0.05),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: StatisticView(
                      icon: Icon(
                        Icons.download_outlined,
                        color: Colors.white,
                        size: 32,
                      ),
                      count: "100k+",
                      description: "Total Downloads",
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: StatisticView(
                      icon: Icon(
                        Icons.workspace_premium_outlined,
                        color: Colors.white,
                        size: 32,
                      ),
                      count: "1K+",
                      description: "Total Premium Users",
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: StatisticView(
                      icon: Icon(
                        Icons.movie_creation_outlined,
                        color: Colors.white,
                        size: 32,
                      ),
                      count: "10K+",
                      description: "Movies & Series",
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: StatisticView(
                      icon: Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.white,
                        size: 32,
                      ),
                      count: "50K+",
                      description: "Views Every Day",
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Watch What Matters",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  "Not sure what to watch next? Let Reevie guide you. Our content section highlights trending shows, hidden gems, and timeless classics—all tailored to you.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: context.mW < 800
                      ? context.mW * 0.8
                      : context.mW * 0.4,
                  child: HorizontalMovieCarousel(
                    visibleCount: context.mW < 800 ? 3 : 5,
                    spacing: 16,
                    centerCardScale: 1.2,
                    autoChangeDuration: const Duration(seconds: 2),
                    cards: [
                      MovieCard(
                        title: "HOLLYWOOD SCIENCE FICTION",
                        image:
                            "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSQF0TjmtfnNHBJ_S2JMzOhF45NgJAjRKpRZipRZex1tw-KLZQ8R9aIp_TGGDNWBx4iSy3a",
                        color: Colors.purple,
                      ),
                      MovieCard(
                        title: "BOLLYWOOD LOVE STORY",
                        image:
                            "https://m.media-amazon.com/images/M/MV5BNTEyYjI2NjEtMjU1Ni00Yzc1LWFmZTQtNmQzM2FhYzE2MjNlXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg",
                        color: Colors.blue,
                      ),
                      MovieCard(
                        title: "SOUTH INDIAN ACTION",
                        image:
                            "https://m.media-amazon.com/images/M/MV5BNzkxNmQ5NGItZDFiZi00MTFiLWFmZTktODAxODliZDkzZTY4XkEyXkFqcGc@._V1_.jpg",
                        color: Colors.orange,
                      ),
                      MovieCard(
                        title: "THRILLER SERIES",
                        image:
                            "https://m.media-amazon.com/images/M/MV5BZjkxZWJiNTUtYjQwYS00MTBlLTgwODQtM2FkNWMyMjMwOGZiXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg",
                        color: Colors.red,
                      ),
                      MovieCard(
                        title: "ROMANTIC KOREAN DRAMA",
                        image:
                            "https://img.mensxp.com/media/content/2024/Aug/2-Netflix_66bb2383205fa.jpeg?w=720&h=1280&cc=1",
                        color: Colors.lightBlueAccent,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 80,
              horizontal: context.mW < 800 ? 24 : 40,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.green.withValues(alpha: 0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            width: double.infinity,
            child: context.mW > 600
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Reevie",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Download Reevie and watch your favorite movies and TV shows offline.",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white54,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(height: 16),
                            FilledButton(
                              style: FilledButton.styleFrom(
                                fixedSize: Size.fromHeight(35),
                                backgroundColor: Colors.green,
                                shape: RoundedSuperellipseBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              onPressed: () {},
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.download, color: Colors.white, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    "Download Now",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Useful Links",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              HoverBuilder(
                                onHover: (hovered) => Text(
                                  "Privacy Policy",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: hovered ? Colors.green : Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 8),
                              HoverBuilder(
                                onHover: (hovered) => Text(
                                  "Terms and Conditions",
                                  style: TextStyle(
                                    fontSize: 14,

                                    color: hovered ? Colors.green : Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Reevie",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Download Reevie and watch your favorite movies and TV shows offline.",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white54,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          FilledButton(
                            style: FilledButton.styleFrom(
                              fixedSize: Size.fromHeight(50),
                              backgroundColor: Colors.green,
                              shape: RoundedSuperellipseBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.download, color: Colors.white, size: 22),
                                const SizedBox(width: 4),
                                Text(
                                  "Download",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "Privacy Policy",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white54,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Term and Conditions",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white54,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
          const Divider(
            color: Colors.white12,
            height: 1,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Made with ❤️ in India | Copyright © 2025 Reevie.",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white54,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
