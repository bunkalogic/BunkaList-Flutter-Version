import 'package:bunkalist/src/core/constans/constants_top_id.dart';
import 'package:flutter/material.dart';

class GetTopIdFromKey {


  int getTopId(Key key){
    switch (key.toString()) {
      case '[<${Constants.topsMoviesPopularId}>]': return Constants.topsMoviesPopularId;
        break;
      case '[<${Constants.topsMoviesRatedId}>]': return Constants.topsMoviesRatedId;
        break;
      case '[<${Constants.topsMoviesUpcommingId}>]': return Constants.topsMoviesUpcommingId;
        break;
      case '[<${Constants.topsMoviesActionId}>]': return Constants.topsMoviesActionId;
        break;
      case '[<${Constants.topsMoviesAdventureId}>]': return Constants.topsMoviesAdventureId;
        break;
      case '[<${Constants.topsMoviesComedyId}>]': return Constants.topsMoviesComedyId;
        break;
      case '[<${Constants.topsMoviesWarId}>]': return Constants.topsMoviesWarId;
        break;
      case '[<${Constants.topsMoviesScienceFictionId}>]': return Constants.topsMoviesScienceFictionId;
        break;      
      case '[<${Constants.topsMoviesCrimeId}>]': return Constants.topsMoviesCrimeId;
        break;
      case '[<${Constants.topsMoviesDramaId}>]': return Constants.topsMoviesDramaId;
        break;    
      case '[<${Constants.topsMoviesFantasyId}>]': return Constants.topsMoviesPopularId;
        break;
      case '[<${Constants.topsMoviesHistoryId}>]': return Constants.topsMoviesPopularId;
        break;
      case '[<${Constants.topsMoviesMisteryId}>]': return Constants.topsMoviesMisteryId;
        break;
      case '[<${Constants.topsMoviesMusicalId}>]': return Constants.topsMoviesMusicalId;
        break;
      case '[<${Constants.topsMoviesRomanceId}>]': return Constants.topsMoviesRomanceId;
        break;
      case '[<${Constants.topsMoviesThillerId}>]': return Constants.topsMoviesThillerId;
        break;
      case '[<${Constants.topsMoviesTerrorId}>]': return Constants.topsMoviesTerrorId;
        break;
      case '[<${Constants.topsMoviesWesternId}>]': return Constants.topsMoviesWesternId;
        break;
      
      case '[<${Constants.topsSeriesPopularId}>]': return Constants.topsSeriesPopularId;
        break;
      case '[<${Constants.topsSeriesRatedId}>]': return Constants.topsSeriesRatedId;
        break;
      case '[<${Constants.topsSeriesUpcommingId}>]': return Constants.topsSeriesUpcommingId;
        break;
      case '[<${Constants.topsSeriesActAndAdvId}>]': return Constants.topsSeriesActAndAdvId;
        break;
      case '[<${Constants.topsSeriesComedyId}>]': return Constants.topsSeriesComedyId;
        break;
      case '[<${Constants.topsSeriesCrimenId}>]': return Constants.topsSeriesCrimenId;
        break;
      case '[<${Constants.topsSeriesDocumentalId}>]': return Constants.topsSeriesDocumentalId;
        break;
      case '[<${Constants.topsSeriesFamilyId}>]': return Constants.topsSeriesFamilyId;
        break;      
      case '[<${Constants.topsSeriesDramaId}>]': return Constants.topsSeriesDramaId;
        break;
      case '[<${Constants.topsSeriesMisteryId}>]': return Constants.topsSeriesMisteryId;
        break;    
      case '[<${Constants.topsSeriesFantasyAndSciFiId}>]': return Constants.topsSeriesFantasyAndSciFiId;
        break;
      case '[<${Constants.topsSeriesWarAndPoliticsId}>]': return Constants.topsSeriesWarAndPoliticsId;
        break;
      case '[<${Constants.topsSeriesWesternId}>]': return Constants.topsSeriesWesternId;
        break;
      case '[<${Constants.topsSeriesNetflixId}>]': return Constants.topsSeriesNetflixId;
        break;
      case '[<${Constants.topsSeriesHBOId}>]': return Constants.topsSeriesHBOId;
        break;
      case '[<${Constants.topsSeriesAmazonPrimeId}>]': return Constants.topsSeriesAmazonPrimeId;
        break;
      case '[<${Constants.topsSeriesBBCOneId}>]': return Constants.topsSeriesBBCOneId;
        break;
      case '[<${Constants.topsSeriesAMCId}>]': return Constants.topsSeriesAMCId;
        break;

      case '[<${Constants.topsAnimePopularId}>]': return Constants.topsAnimePopularId;
        break;
      case '[<${Constants.topsAnimeRatedId}>]': return Constants.topsAnimeRatedId;
        break;
      case '[<${Constants.topsAnimeSeasonId}>]': return Constants.topsAnimeSeasonId;
        break;
      case '[<${Constants.topsAnimeUpcomingNextSeasonId}>]': return Constants.topsAnimeUpcomingNextSeasonId;
        break;
      case '[<${Constants.topsAnimeActionAndAdventureId}>]': return Constants.topsAnimeActionAndAdventureId;
        break;
      case '[<${Constants.topsAnimeComedyId}>]': return Constants.topsAnimeComedyId;
        break;
      case '[<${Constants.topsAnimeCrimenId}>]': return Constants.topsAnimeCrimenId;
        break;
      case '[<${Constants.topsAnimeMisteryId}>]': return Constants.topsAnimeMisteryId;
        break;      
      case '[<${Constants.topsAnimeFantasyAndSciFiId}>]': return Constants.topsAnimeFantasyAndSciFiId;
        break;
      case '[<${Constants.topsAnimeDramaId}>]': return Constants.topsAnimeDramaId;
        break;    
      case '[<${Constants.topsAnimeWarAndPoliticsId}>]': return Constants.topsAnimeWarAndPoliticsId;
        break;
      case '[<${Constants.topsAnimeShonenId}>]': return Constants.topsAnimeShonenId;
        break;
      case '[<${Constants.topsAnimeSpokonId}>]': return Constants.topsAnimeSpokonId;
        break;
      case '[<${Constants.topsAnimeMechaId }>]': return Constants.topsAnimeMechaId;
        break;
      case '[<${Constants.topsAnimeSliceOfLifeId}>]': return Constants.topsAnimeSliceOfLifeId;
        break;
      case '[<${Constants.topsAnimeBasedOnMangaId}>]': return Constants.topsAnimeBasedOnMangaId;
        break;
      case '[<${Constants.topsAnimeRomanceId}>]': return Constants.topsAnimeRomanceId;
        break; 
      case '[<${Constants.topsAnimeSuperNaturalId}>]': return Constants.topsAnimeSuperNaturalId;
        break;         


      default: return 0;
    }
  }

}