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


  int getTopIdFromMovie(int index){
    switch(index){
      case 0: return Constants.topsMoviesPopularId;
        break;
      case 1: return Constants.topsMoviesRatedId;
        break;
      case 2: return Constants.topsMoviesUpcommingId;
        break;
      case 3: return Constants.topsMoviesActionId;
        break;
      case 4: return Constants.topsMoviesAdventureId;
        break;
      case 5: return Constants.topsMoviesComedyId;
        break;
      case 6: return Constants.topsMoviesWarId;
        break;
      case 7: return Constants.topsMoviesScienceFictionId;
        break;      
      case 8: return Constants.topsMoviesCrimeId;
        break;
      case 9: return Constants.topsMoviesDramaId;
        break;    
      case 10: return Constants.topsMoviesPopularId;
        break;
      case 11: return Constants.topsMoviesPopularId;
        break;
      case 12: return Constants.topsMoviesMisteryId;
        break;
      case 13: return Constants.topsMoviesMusicalId;
        break;
      case 14: return Constants.topsMoviesRomanceId;
        break;
      case 15: return Constants.topsMoviesThillerId;
        break;
      case 16: return Constants.topsMoviesTerrorId;
        break;
      case 17: return Constants.topsMoviesWesternId;
        break;
      
      default: return Constants.topsMoviesPopularId;

    }
  }

  int getTopIdFromSeries(int index){
    switch(index){
      case 0: return Constants.topsSeriesPopularId;
        break;
      case 1: return Constants.topsSeriesRatedId;
        break;
      case 2: return Constants.topsSeriesUpcommingId;
        break;
      case 3: return Constants.topsSeriesActAndAdvId;
        break;
      case 4: return Constants.topsSeriesComedyId;
        break;
      case 5: return Constants.topsSeriesCrimenId;
        break;
      case 6: return Constants.topsSeriesDocumentalId;
        break;
      case 7: return Constants.topsSeriesFamilyId;
        break;      
      case 8: return Constants.topsSeriesDramaId;
        break;
      case 9: return Constants.topsSeriesMisteryId;
        break;    
      case 10: return Constants.topsSeriesFantasyAndSciFiId;
        break;
      case 11: return Constants.topsSeriesWarAndPoliticsId;
        break;
      case 12: return Constants.topsSeriesWesternId;
        break;
      case 13: return Constants.topsSeriesNetflixId;
        break;
      case 14: return Constants.topsSeriesHBOId;
        break;
      case 15: return Constants.topsSeriesAmazonPrimeId;
        break;
      case 16: return Constants.topsSeriesBBCOneId;
        break;
      case 17: return Constants.topsSeriesAMCId;
        break;

      default: return  Constants.topsSeriesPopularId;
    }
  }

  int getTopIdFromAnimes(int index){
    switch(index){
      case 0: return Constants.topsAnimePopularId;
        break;
      case 1: return Constants.topsAnimeRatedId;
        break;
      case 2: return Constants.topsAnimeSeasonId;
        break;
      case 3: return Constants.topsAnimeUpcomingNextSeasonId;
        break;
      case 4: return Constants.topsAnimeActionAndAdventureId;
        break;
      case 5: return Constants.topsAnimeComedyId;
        break;
      case 6: return Constants.topsAnimeCrimenId;
        break;
      case 7: return Constants.topsAnimeMisteryId;
        break;      
      case 8: return Constants.topsAnimeFantasyAndSciFiId;
        break;
      case 9: return Constants.topsAnimeDramaId;
        break;    
      case 10: return Constants.topsAnimeWarAndPoliticsId;
        break;
      case 11: return Constants.topsAnimeShonenId;
        break;
      case 12: return Constants.topsAnimeSpokonId;
        break;
      case 13: return Constants.topsAnimeMechaId;
        break;
      case 14: return Constants.topsAnimeSliceOfLifeId;
        break;
      case 15: return Constants.topsAnimeBasedOnMangaId;
        break;
      case 16: return Constants.topsAnimeRomanceId;
        break; 
      case 17: return Constants.topsAnimeSuperNaturalId;
        break; 

      default: return  Constants.topsAnimePopularId;
    }
  }

}