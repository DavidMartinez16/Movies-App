
import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class PeliculaDetalle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;


    return Scaffold(
      body: CustomScrollView(
        
        slivers: <Widget>[
          _crearAppbar( pelicula ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
              SizedBox(height: 10.0),
              _posterTitulo(context, pelicula),
              _descripcion(pelicula),
              _descripcion(pelicula),
              _descripcion(pelicula),
              _descripcion(pelicula),
              _descripcion(pelicula),
              _descripcion(pelicula),
              _descripcion(pelicula),
              _crearCasting(pelicula)
              
              ]
            ),
          )
        ],

      )
      
    );
  }

  Widget _crearAppbar(Pelicula pelicula) {

    return SliverAppBar(
      elevation: 3.0,
      backgroundColor: Colors.cyan[900],
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true, 
        title: Text(
          pelicula.title, 
          style: TextStyle(
            color: Colors.white, 
            fontSize: 16.0
          )
        ), 
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
        
      ),
      primary: true,
      shadowColor: Colors.cyan[700],
    

    );

  }

  Widget _posterTitulo( BuildContext context,Pelicula pelicula){

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          Hero(
            tag: pelicula.uniqueID,
            child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(image: NetworkImage(pelicula.getPoster()), height: 150.0,)
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pelicula.title, style: Theme.of(context).textTheme.headline5, overflow: TextOverflow.ellipsis),
                Text(pelicula.originalTitle, style: Theme.of(context).textTheme.subtitle2, overflow: TextOverflow.ellipsis),
                Row(
                  children: [
                    Icon(Icons.star_border),
                    Text( pelicula.voteAverage.toString(), style: Theme.of(context).textTheme.subtitle2, overflow: TextOverflow.ellipsis )
                  ],
                )
              ],
            )
          )
        ],
      ),
    );
  }


  Widget _descripcion( Pelicula pelicula) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),

    );
  
  }

  Widget _crearCasting( Pelicula pelicula){

    final peliProvider = new PeliculasProvider();

    FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        
        if (snapshot.hasData) {
          return _crearActoresPage(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }


      },
    );

  }


  Widget _crearActoresPage( List<Actor> actores) {

    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3
        ),
        itemCount: actores.length,
        itemBuilder: (context, i) => _actorTarjeta( actores[i] ),

      ),
    );

  }

  Widget _actorTarjeta(Actor actor) {

    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'), 
              image: NetworkImage( actor.getFoto()),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            actor.character,
            overflow: TextOverflow.ellipsis,

          )
        ],
      )
    );

  }

}