
import 'package:bunkalist/src/features/profile/domain/entities/oeuvre_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OuevreModel extends OuevreEntity{
       

  OuevreModel({           
    final DateTime addDate,          
    final int      status,           
    final int      seasons,          
    final int      episodes,         
    final String   comment,          
    final double   finalRate,        
    final double   historyRate,      
    final double   effectsRate,      
    final double   ostRate,          
    final double   characterRate,    
    final double   enjoymentRate,    
    final int      oeuvreId,         
    final String   oeuvreTitle,      
    final String   oeuvrePoster,     
    final String   oeuvreReleaseDate,
    final double   oeuvreRating,     
    final int      seasonTotal,      
    final int      episodeTotal,     
    final String   oeuvreType,
    bool     isFavorite,   
    int      positionListFav,
    final String   reviewExt,       
  }): super(           
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
    isFavorite         : isFavorite,
    positionListFav    : positionListFav,
    reviewExt          : reviewExt        
  );


  factory OuevreModel.fromSnapshot(DocumentSnapshot snap){

    Timestamp timestamp = snap.data['addDate'];
    
    DateTime datetime = timestamp.toDate();
    

    return OuevreModel(
      addDate            :   datetime,          
      status             :   snap.data['status'],           
      seasons            :   snap.data['seasons'],          
      episodes           :   snap.data['episodes'],         
      comment            :   snap.data['comment'],          
      finalRate          :   snap.data['finalRate'],        
      historyRate        :   snap.data['historyRate'],      
      effectsRate        :   snap.data['effectsRate'],      
      ostRate            :   snap.data['ostRate'],          
      characterRate      :   snap.data['characterRate'],    
      enjoymentRate      :   snap.data['enjoymentRate'],    
      oeuvreId           :   snap.data['oeuvreId'],         
      oeuvreTitle        :   snap.data['oeuvreTitle'],      
      oeuvrePoster       :   snap.data['oeuvrePoster'],     
      oeuvreReleaseDate  :   snap.data['oeuvreReleaseDate'],
      oeuvreRating       :   snap.data['oeuvreRating'],     
      seasonTotal        :   snap.data['seasonTotal'],      
      episodeTotal       :   snap.data['episodeTotal'],     
      oeuvreType         :   snap.data['oeuvreType'],
      isFavorite         :   snap.data['isFavorite'],
      positionListFav    :   snap.data['positionListFav'],
      reviewExt          :   snap.data['reviewExt']  
    );
  }

  Map<String, Object> toDocument(){
    return{
    "addDate"           : addDate,                    
    "status"            : status,                      
    "seasons"           : seasons,                    
    "episodes"          : episodes,                  
    "comment"           : comment,                    
    "finalRate"         : finalRate,                
    "historyRate"       : historyRate,            
    "effectsRate"       : effectsRate,            
    "ostRate"           : ostRate,                    
    "characterRate"     : characterRate,        
    "enjoymentRate"     : enjoymentRate,        
    "oeuvreId"          : oeuvreId,                  
    "oeuvreTitle"       : oeuvreTitle,            
    "oeuvrePoster"      : oeuvrePoster,          
    "oeuvreReleaseDate" : oeuvreReleaseDate,
    "oeuvreRating"      : oeuvreRating,          
    "seasonTotal"       : seasonTotal,            
    "episodeTotal"      : episodeTotal,          
    "oeuvreType"        : oeuvreType,
    "isFavorite"        : isFavorite,
    "positionListFav"   : positionListFav,
    "reviewExt"         : reviewExt          
    };
  }


}