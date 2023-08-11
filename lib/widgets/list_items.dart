import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:app_seguimiento_movil/models/models.dart';

class TableCustom extends StatelessWidget {
  final List<Option> opciones;

  TableCustom({
    super.key,
    required this.opciones,
  });

  TextStyle myTextStyleTitle = const TextStyle(
    color: Color(0xFF293641),
    fontFamily: 'GothamMedium',
    fontWeight: FontWeight.w600,
  );

  TextStyle myTextStyleDescription = const TextStyle(
    color: Color(0xFF293641),
    fontFamily: 'GothamBook',
    fontWeight: FontWeight.normal,
  );

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: opciones.map((opcion) {
        return TableRow(children: [
          Container(
            padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * .02),
            child: Ink(
              height: MediaQuery.of(context).size.height < 960 && MediaQuery.of(context).size.width <900  ?
                //para celulares
                ( MediaQuery.of(context).size.height * (MediaQuery.of(context).orientation == Orientation.landscape ? .3 : .15))
                :
                //para tablets 
                (MediaQuery.of(context).size.height * .2 ),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.282),
                    spreadRadius: 0.5,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: InkWell(
                onTap: opcion.navigator,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          opcion.img!,
                          width: MediaQuery.of(context).orientation == Orientation.landscape? 
                              MediaQuery.of(context).size.height * opcion.width:
                              MediaQuery.of(context).size.width * opcion.width,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 
                      MediaQuery.of(context).size.width *
                          (MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? 0.5
                              : 0.65),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            opcion.title,
                            softWrap: true,
                            style: myTextStyleTitle.copyWith(
                              fontSize: MediaQuery.of(context).size.width *
                                  (MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? .035
                                      : 0.015),
                            ),
                          ),
                          Text(
                            opcion.description,
                            softWrap: true,
                            style: myTextStyleDescription.copyWith(
                              fontSize: MediaQuery.of(context).size.width *
                                  (MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? .03
                                      : 0.015),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: SvgPicture.asset(
                        'assets/images/main/arrow_rh.svg',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]);
      }).toList(),
    );
  }
}