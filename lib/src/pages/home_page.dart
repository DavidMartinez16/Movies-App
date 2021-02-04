import 'package:flutter/material.dart';


import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';


class HomePage extends StatelessWidget {

  final peliculasProvider = new PeliculasProvider();
  
  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopulares();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        centerTitle: false,
        title: Text('Movies App'),
        backgroundColor: Colors.cyan[900],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: () {

              showSearch(
                context: context,
                delegate: DataSearch()
                
              );

            }
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context)
          ],
        ) ,
      )
      
    );
  }

  Widget _swiperTarjetas() {

    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {

        if ( snapshot.hasData ){
          return CardSwiper( peliculas: snapshot.data );
        } else {
          return Container(
            height: 380.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }

        
      },
    );
    
  }


Widget _footer(BuildContext context){

  return Container(
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Text('Películas Populares', style: TextStyle(fontSize: 16.0, color: Colors.cyan[900], fontWeight: FontWeight.bold)),
          padding: EdgeInsets.only(left: 20.0, bottom:20.0),
        ),
        SizedBox(height: 5.0),

        StreamBuilder(

          stream: peliculasProvider.popularesStream,
          
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            
            if (snapshot.hasData){
              return MovieHorizontal( 
                peliculas: snapshot.data,
                siguientePagina: peliculasProvider.getPopulares,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
            
          },
        ),
      ],
    ),
  );


}
}