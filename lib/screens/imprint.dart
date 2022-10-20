import 'package:Aroma/utils/commons.dart';
import 'package:Aroma/widgets/appBar.dart';
import 'package:Aroma/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Imprint extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AromaAppBar(
            sFkey: _scaffoldKey,
            hasHeader: false,
          ),
        ),
        endDrawer: Menu(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/aroma-logo.png",
                      width: 250,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Impressum",
                      style: GoogleFonts.raleway(
                        fontSize: 25,
                        color: purple_light,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Angaben gemäß § 5 TMG:",
                      style: GoogleFonts.raleway(
                        fontSize: 20,
                        color: green_light,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Samir Azzaoui",
                      style: GoogleFonts.raleway(
                        fontSize: 12,
                        color: purple_light,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Pizzeria Aroma",
                      style: GoogleFonts.raleway(
                        fontSize: 12,
                        color: purple_light,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Achenbacher Straße 117",
                      style: GoogleFonts.raleway(
                        fontSize: 12,
                        color: purple_light,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "57072 Siegen",
                      style: GoogleFonts.raleway(
                        fontSize: 12,
                        color: purple_light,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Kontakt",
                      style: GoogleFonts.raleway(
                        fontSize: 20,
                        color: green_light,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Telefon: 0271 38 75 06 13",
                      style: GoogleFonts.raleway(
                        fontSize: 12,
                        color: purple_light,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Mobil: 0176 84 22 50 07",
                      style: GoogleFonts.raleway(
                        fontSize: 12,
                        color: purple_light,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "E-Mail: kontakt@aroma-siegen.de",
                      style: GoogleFonts.raleway(
                        fontSize: 12,
                        color: purple_light,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Aufsichtsbehörde",
                      style: GoogleFonts.raleway(
                        fontSize: 20,
                        color: green_light,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Stadt Siegen",
                      style: GoogleFonts.raleway(
                        fontSize: 12,
                        color: purple_light,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Markt 2",
                      style: GoogleFonts.raleway(
                        fontSize: 12,
                        color: purple_light,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "57072 Siegen",
                      style: GoogleFonts.raleway(
                        fontSize: 12,
                        color: purple_light,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "https://www.siegen.de/",
                      style: GoogleFonts.raleway(
                        fontSize: 12,
                        color: green_light,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Umsatzsteuer-ID",
                      style: GoogleFonts.raleway(
                        fontSize: 20,
                        color: green_light,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Umsatzsteuer-Identifikationsnummer",
                      style: GoogleFonts.raleway(
                        fontSize: 12,
                        color: purple_light,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "gemäß §27 a Umsatzsteuergesetz:",
                      style: GoogleFonts.raleway(
                        fontSize: 12,
                        color: purple_light,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Folgt.",
                      style: GoogleFonts.raleway(
                        fontSize: 12,
                        color: purple_light,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Streitschlichtung",
                      style: GoogleFonts.raleway(
                        fontSize: 20,
                        color: green_light,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: SizedBox(
                            width: 250,
                            child: Text(
                                "Die Europäische Kommission stellt eine Plattform zur Online-Streitbeilegung" +
                                    "(OS) bereit: https://ec.europa.eu/consumers/odr." +
                                    "Unsere E-Mail-Adresse finden Sie oben im Impressum." +
                                    "Wir sind nicht bereit oder verpflichtet, an Streitbeilegungsverfahren" +
                                    "vor einer Verbraucherschlichtungsstelle teilzunehmen.",
                                style: GoogleFonts.raleway(
                                  fontSize: 12,
                                  color: purple_light,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Haftung für Inhalte",
                      style: GoogleFonts.raleway(
                        fontSize: 15,
                        color: green_light,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: SizedBox(
                            width: 250,
                            child: Text(
                                "Als Diensteanbieter sind wir gemäß § 7 Abs.1 TMG für eigene" +
                                    "Inhalte auf diesen Seiten nach den allgemeinen Gesetzen verantwortlich." +
                                    "Nach §§ 8 bis 10 TMG sind wir als Diensteanbieter jedoch nicht verpflichtet," +
                                    "übermittelte oder gespeicherte fremde Informationen zu überwachen oder nach" +
                                    "Umständen zu forschen, die auf eine rechtswidrige Tätigkeit hinweisen." +
                                    "Verpflichtungen zur Entfernung oder Sperrung der Nutzung von Informationen" +
                                    "nach den allgemeinen Gesetzen bleiben hiervon unberührt. Eine diesbezügliche" +
                                    "Haftung ist jedoch erst ab dem Zeitpunkt der Kenntnis einer konkreten" +
                                    "Rechtsverletzung möglich. Bei Bekanntwerden von entsprechenden" +
                                    "Rechtsverletzungen werden wir diese Inhalte umgehend entfernen.",
                                style: GoogleFonts.raleway(
                                  fontSize: 12,
                                  color: purple_light,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Haftung für Links",
                      style: GoogleFonts.raleway(
                        fontSize: 15,
                        color: green_light,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: SizedBox(
                            width: 250,
                            child: Text(
                                "Unser Angebot enthält Links zu externen Websites Dritter," +
                                    "auf deren Inhalte wir keinen Einfluss haben. Deshalb können" +
                                    "wir für diese fremden Inhalte auch keine Gewähr übernehmen." +
                                    "Für die Inhalte der verlinkten Seiten ist stets der jeweilige" +
                                    "Anbieter oder Betreiber der Seiten verantwortlich. Die verlinkten" +
                                    "Seiten wurden zum Zeitpunkt der Verlinkung auf mögliche Rechtsverstöße" +
                                    "überprüft. Rechtswidrige Inhalte waren zum Zeitpunkt der Verlinkung nicht" +
                                    "erkennbar. Eine permanente inhaltliche Kontrolle der verlinkten Seiten ist" +
                                    "jedoch ohne konkrete Anhaltspunkte einer Rechtsverletzung nicht zumutbar." +
                                    "Bei Bekanntwerden von Rechtsverletzungen werden wir derartige Links umgehend entfernen.",
                                style: GoogleFonts.raleway(
                                  fontSize: 12,
                                  color: purple_light,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Urheberrecht",
                      style: GoogleFonts.raleway(
                        fontSize: 15,
                        color: green_light,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: SizedBox(
                            width: 250,
                            child: Text(
                                "Die durch die Seitenbetreiber erstellten Inhalte und" +
                                    "Werke auf diesen Seiten unterliegen dem deutschen Urheberrecht." +
                                    "Die Vervielfältigung, Bearbeitung, Verbreitung und jede Art der" +
                                    "Verwertung außerhalb der Grenzen des Urheberrechtes bedürfen der" +
                                    "schriftlichen Zustimmung des jeweiligen Autors bzw. Erstellers." +
                                    "Downloads und Kopien dieser Seite sind nur für den privaten," +
                                    "nicht kommerziellen Gebrauch gestattet. Soweit die Inhalte auf" +
                                    "dieser Seite nicht vom Betreiber erstellt wurden, werden die" +
                                    "Urheberrechte Dritter beachtet. Insbesondere werden Inhalte" +
                                    "Dritter als solche gekennzeichnet. Sollten Sie trotzdem auf" +
                                    "eine Urheberrechtsverletzung aufmerksam werden, bitten wir um" +
                                    "einen entsprechenden Hinweis. Bei Bekanntwerden von Rechtsverletzungen" +
                                    "werden wir derartige Inhalte umgehend entfernen.",
                                style: GoogleFonts.raleway(
                                  fontSize: 12,
                                  color: purple_light,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
