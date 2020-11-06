import 'package:bunkalist/src/core/constans/query_list_const.dart';
import 'package:bunkalist/src/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';


class BuildBottomFilterCompleted extends StatefulWidget {
  BuildBottomFilterCompleted({Key key}) : super(key: key);

  @override
  _BuildBottomFilterCompletedState createState() => _BuildBottomFilterCompletedState();
}

class _BuildBottomFilterCompletedState extends State<BuildBottomFilterCompleted> {
  
  @override
  Widget build(BuildContext context) {

    String ratingGeneral    = AppLocalizations.of(context).translate('order_by_your_rating_total');
    String ratingPlot       = AppLocalizations.of(context).translate('order_by_your_rating_plot');
    String ratingCharacter  = AppLocalizations.of(context).translate('order_by_your_rating_character');
    String ratingOST        = AppLocalizations.of(context).translate('order_by_your_rating_ost');
    String ratingEffects    = AppLocalizations.of(context).translate('order_by_your_rating_effects');
    String ratingEnjoyment  = AppLocalizations.of(context).translate('order_by_your_rating_enjoyment');
    String addDate          = AppLocalizations.of(context).translate('order_by_your_added');
    String ouevreRating     = AppLocalizations.of(context).translate('order_by_your_com_rating');
    String ouevreYear       = AppLocalizations.of(context).translate('order_by_your_realese_date');


    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        tileFilterOption(ratingGeneral  , Icons.stars_rounded, () => Navigator.pop(context, ListProfileQuery.Completed)),
        tileFilterOption(ratingPlot     , Icons.book, () => Navigator.pop(context, ListProfileQuery.CompleteHistoryRate)),
        tileFilterOption(ratingCharacter, Icons.people, () => Navigator.pop(context, ListProfileQuery.CompleteCharacterRate)),
        tileFilterOption(ratingOST      , Icons.music_video, () => Navigator.pop(context, ListProfileQuery.CompleteOSTRate)),
        tileFilterOption(ratingEffects  , Icons.movie_filter, () => Navigator.pop(context, ListProfileQuery.CompleteEffectsRate)),
        tileFilterOption(ratingEnjoyment, Icons.tag_faces, () => Navigator.pop(context, ListProfileQuery.CompleteEnjoymentRate)),
        tileFilterOption(addDate        , Icons.today_rounded, () => Navigator.pop(context, ListProfileQuery.CompleteAddDate)),
        tileFilterOption(ouevreRating   , Icons.star_half_rounded, () => Navigator.pop(context, ListProfileQuery.CompleteOeuvreRating)),
        tileFilterOption(ouevreYear     , Icons.calendar_today_rounded, () => Navigator.pop(context, ListProfileQuery.CompleteOeuvreReleaseDate)),
      ],
    );
  }

  Widget tileFilterOption(String title, IconData icon, Function() onTap ){
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.0, 
          fontStyle: 
          FontStyle.italic, 
          fontWeight: FontWeight.w500
        ),
      ),
      leading: Icon(icon, color: Colors.deepPurpleAccent, size: 28.0,),
    );
  }
}