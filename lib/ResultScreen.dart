import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final Map<String, dynamic> result;
  ResultScreen(this.result);
  @override
  _ResultScreenState createState() => _ResultScreenState(result);
}

class _ResultScreenState extends State<ResultScreen> {
  Map<String, dynamic> result;
  List artistName=[];
  Map<String,List<String>> tracks={};
  Map<String,String> artistId={};


  Map<String,List<String>> Tracks(){
    Map<String,List<String>> tracks={};
    for(int i=0;i<artistName.length;i++)
    {
      tracks[artistName[i]]=[artistName[i]];
    }
    for(int i=0;i<result['resultCount'];i++)
      {
        tracks[result['results'][i]['artistName']].add(result['results'][i]['trackName']);
        artistId[result['results'][i]['artistName']]=result['results'][i]['artistId'].toString();
      }


    return tracks;
  }

  @override
  Widget build(BuildContext context) {
    tracks=Tracks();

    return Scaffold(
      appBar:AppBar(title: Text('Results')),
        backgroundColor: Colors.white,
        body:Padding(padding:EdgeInsets.all(5),child:SingleChildScrollView(
            physics: ScrollPhysics(),
            child:Column(
          children: [

        for( int i=0;i<artistName.length;i++)
            new ListView.builder
              (physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,padding: EdgeInsets.all(10),

                itemCount: tracks[artistName[i]].length,
                itemBuilder: (BuildContext ctxt, int index) {
                if(index==0)
                  return new Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,  children: [Flexible(
                  child:Text("Artist: ${tracks[artistName[i]][index]}",style: TextStyle(fontWeight: FontWeight.bold),)),
                  Flexible(
                  child:Text("Artist Id: ${artistId[artistName[i]]}",style: TextStyle(fontWeight: FontWeight.bold),))],
                  );
                return Flexible(
                    child:new Text(tracks[artistName[i]][index]));

                })


            ]

     ))));
  }

  _ResultScreenState(Map<String, dynamic> res) {
    result=res;
    print(result);

    for (int i=0; i<result['resultCount'];i++)
      {
        artistName.add(result['results'][i]['artistName']);
      }
    Set set = new Set.from(artistName);
    artistName=set.toList();



  }
}
