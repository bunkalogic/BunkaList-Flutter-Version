import 'package:bunkalist/src/features/profile/data/models/oeuvre_model.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';



@immutable
class OuevreEntity extends Equatable{

  final String   id;             
  final DateTime addDate;          
  final String   status;           
  final int      seasons;           
  final int      episodes;          
  final String   comment;           
  final double   finalRate;         
  final double   historyRate;       
  final double   effectsRate;       
  final double   ostRate;           
  final double   characterRate;     
  final double   enjoymentRate;     
  final int      oeuvreId;          
  final String   oeuvreTitle;       
  final String   oeuvrePoster;      
  final String   oeuvreReleaseDate; 
  final double   oeuvreRating;      
  final int      seasonTotal;       
  final int      episodeTotal;      
  final String   oeuvreType;        



   OuevreEntity({
    this.id,           
    this.addDate,          
    this.status,           
    this.seasons,          
    this.episodes,         
    this.comment,          
    this.finalRate,        
    this.historyRate,      
    this.effectsRate,      
    this.ostRate,          
    this.characterRate,    
    this.enjoymentRate,    
    this.oeuvreId,         
    this.oeuvreTitle,      
    this.oeuvrePoster,     
    this.oeuvreReleaseDate,
    this.oeuvreRating,     
    this.seasonTotal,      
    this.episodeTotal,     
    this.oeuvreType,       
   }) : super([
    id,           
    addDate,          
    status,           
    seasons,          
    episodes,         
    comment,          
    finalRate,        
    historyRate,      
    effectsRate,      
    ostRate,          
    characterRate,    
    enjoymentRate,    
    oeuvreId,         
    oeuvreTitle,      
    oeuvrePoster,     
    oeuvreReleaseDate,
    oeuvreRating,     
    seasonTotal,      
    episodeTotal,     
    oeuvreType,       
  ]);

  OuevreModel toModel(){
    return  OuevreModel(
      id                 : id,           
      addDate            : addDate,          
      status             : status,           
      seasons            : seasons,          
      episodes           : episodes,         
      comment            : comment,          
      finalRate          : finalRate,        
      historyRate        : historyRate,      
      effectsRate        : effectsRate,      
      ostRate            : ostRate,          
      characterRate      : characterRate,    
      enjoymentRate      : enjoymentRate,    
      oeuvreId           : oeuvreId,         
      oeuvreTitle        : oeuvreTitle,      
      oeuvrePoster       : oeuvrePoster,     
      oeuvreReleaseDate  : oeuvreReleaseDate,
      oeuvreRating       : oeuvreRating,     
      seasonTotal        : seasonTotal,      
      episodeTotal       : episodeTotal,     
      oeuvreType         : oeuvreType, 
    );
  }

  static OuevreEntity fromModel(OuevreModel model){
    return OuevreEntity(
      id                 : model.id,           
      addDate            : model.addDate,          
      status             : model.status,           
      seasons            : model.seasons ?? 0,          
      episodes           : model.episodes ?? 0,         
      comment            : model.comment ?? '',          
      finalRate          : model.finalRate ?? -1,        
      historyRate        : model.historyRate ?? -1,      
      effectsRate        : model.effectsRate ?? -1,      
      ostRate            : model.ostRate ?? -1,          
      characterRate      : model.characterRate ?? -1,    
      enjoymentRate      : model.enjoymentRate ?? -1,    
      oeuvreId           : model.oeuvreId,         
      oeuvreTitle        : model.oeuvreTitle,      
      oeuvrePoster       : model.oeuvrePoster,     
      oeuvreReleaseDate  : model.oeuvreReleaseDate,
      oeuvreRating       : model.oeuvreRating,     
      seasonTotal        : model.seasonTotal ?? 0,      
      episodeTotal       : model.episodeTotal ?? 0,     
      oeuvreType         : model.oeuvreType,
    );
  }

}