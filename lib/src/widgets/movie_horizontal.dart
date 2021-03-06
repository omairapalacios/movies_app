import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movies_app/src/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie> movies;
  final Function goToTheNextPage;

  MovieHorizontal({@required this.movies, @required this.goToTheNextPage});

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        goToTheNextPage();
      }
    });

    return Container(
        height: _screenSize.height * 0.25,
        child: PageView.builder(
            pageSnapping: false,
            controller: _pageController,
            itemCount: movies.length,
            itemBuilder: (context, i) => _card(context, movies[i])));
  }

  Widget _card(context, Movie movie) {

    movie.uniqueId= '${movie.id}-poster';

    final cardMovie = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: FadeInImage(
              image: NetworkImage(
                movie.getPosterImage(),
              ),
              placeholder: AssetImage('assets/images/no-image.jpg'),
              fit: BoxFit.cover,
              height: 150.0,
            ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector(
      child: cardMovie,
      onTap: () {
        Navigator.pushNamed(context, 'detail', arguments: movie);
      },
    );
  }

// other way of get data

/*  List<Widget> _cardsPopulars(context) {
    return movies.map((movie) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: FadeInImage(
                image: NetworkImage(
                  movie.getPosterImage(),
                ),
                placeholder: AssetImage('assets/images/no-image.jpg'),
                fit: BoxFit.cover,
                height: 150.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  } */
}
