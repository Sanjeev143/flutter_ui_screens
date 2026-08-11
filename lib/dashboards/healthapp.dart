import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class HealthApp extends StatelessWidget {
  const HealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Health Dashboard",
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xffF6F8FF),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin {

  late AnimationController blobController;
  late AnimationController floatController;
  late AnimationController graphController;
  late AnimationController progressController;

  @override
  void initState() {
    super.initState();

    blobController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    graphController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
  }

  @override
  void dispose() {
    blobController.dispose();
    floatController.dispose();
    graphController.dispose();
    progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: AnimatedBuilder(

        animation: Listenable.merge([
          blobController,
          floatController,
          graphController,
          progressController,
        ]),

        builder: (_, __) {

          return Stack(

            children: [

              CustomPaint(
                painter: BlobPainter(blobController.value),
                child: const SizedBox.expand(),
              ),

              CustomPaint(
                painter: BubblePainter(blobController.value),
                size: Size.infinite,
              ),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(

                    children: [

                      buildHeader(),

                      const SizedBox(height: 25),

                      Expanded(

                        child: Stack(

                          children: [

                            buildGlassCard(),

                            buildFloatingWatch(),

                          ],
                        ),
                      ),

                      buildBottomBar(),

                    ],
                  ),
                ),
              ),

            ],
          );
        },
      ),
    );
  }

  Widget buildHeader() {

    return Row(

      children: [

        const CircleAvatar(
          radius: 26,
          backgroundColor: Colors.white,
          child: Icon(Icons.person),
        ),

        const SizedBox(width: 14),

        const Expanded(

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              Text(
                "Good Morning",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),

              SizedBox(height: 2),

              Text(
                "Alex Morgan",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),

        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
            BorderRadius.circular(18),
          ),
          child: const Icon(Icons.notifications),
        )
      ],
    );
  }

  Widget buildGlassCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(35),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 20,
          sigmaY: 20,
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.05),
            borderRadius: BorderRadius.circular(35),
            border: Border.all(
              color: Colors.white70,
            ),
          ),
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "Today's Activity",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                height: 180,
                child: Center(
                  child: CustomPaint(
                    size: const Size(180,180),
                    painter: ProgressPainter(
                      animation: progressController,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                height: 110,
                child: CustomPaint(
                  painter: GraphPainter(
                     animation: graphController,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(
                height: 90,
                child: CustomPaint(
                  painter: WeeklyBarPainter(
                    graphController.value,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              HeartBeatCard(
                value: graphController.value,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statCard(
      IconData icon,
      String title,
      String value,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.45),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [

          Icon(
            icon,
            color: color,
            size: 34,
          ),

          const SizedBox(height: 10),

          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            style: const TextStyle(
              color: Colors.black54,
            ),
          )
        ],
      ),
    );
  }

  Widget buildBottomBar() {

    return Container(

      height: 80,

      decoration: BoxDecoration(

        color: Colors.white.withOpacity(.70),

        borderRadius: BorderRadius.circular(30),

      ),

      child: Row(

        mainAxisAlignment:
        MainAxisAlignment.spaceAround,

        children: [

          _navItem(Icons.home,true),

          _navItem(Icons.favorite,false),

          _navItem(Icons.bar_chart,false),

          _navItem(Icons.person,false),

        ],
      ),
    );
  }

  Widget _navItem(
      IconData icon,
      bool active,
      ){

    return AnimatedContainer(

      duration: const Duration(milliseconds:300),

      width: active?58:48,

      height: active?58:48,

      decoration: BoxDecoration(

        color: active
            ? Colors.deepPurple
            : Colors.transparent,

        shape: BoxShape.circle,

      ),

      child: Icon(
        icon,
        color: active
            ? Colors.white
            : Colors.black54,
      ),
    );
  }

  Widget buildFloatingWatch() {
    final dy = sin(floatController.value * 2 * pi) * 10;

    return Positioned(
      right: 20,
      top: 60 + dy,
      child: Transform.rotate(
        angle: -0.18,
        child: Container(
          width: 145,
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff2F3542),
                Color(0xff111111),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.30),
                blurRadius: 35,
                offset: const Offset(0, 20),
              )
            ],
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [

              Container(
                width: 70,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              const SizedBox(height: 18),
/// heart icon
              // Container(
              //   width: 90,
              //   height: 90,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     color: Colors.black,
              //     border: Border.all(
              //       color: Colors.grey.shade700,
              //       width: 3,
              //     ),
              //   ),
              //   child: const Icon(
              //     Icons.favorite,
              //     color: Colors.red,
              //     size: 40,
              //   ),
              // ),

              TweenAnimationBuilder<double>(
                tween: Tween(begin: 1.0, end: 1.15),
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeInOut,
                onEnd: () {},
                builder: (context, scale, child) {
                  return Transform.scale(
                    scale: 1 + sin(floatController.value * 2 * pi) * 0.08,
                    child: child,
                  );
                },
                child: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 40,
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                "82 BPM",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "Heart Rate",
                style: TextStyle(
                  color: Colors.grey.shade400,
                ),
              ),

              const Spacer(),

              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  // Widget buildBottomBar() {
  //
  //   return Container(
  //
  //     height: 80,
  //
  //     margin: const EdgeInsets.only(top: 20),
  //
  //     decoration: BoxDecoration(
  //
  //       color: Colors.white,
  //
  //       borderRadius:
  //       BorderRadius.circular(30),
  //
  //     ),
  //
  //     child: const Row(
  //
  //       mainAxisAlignment:
  //       MainAxisAlignment.spaceEvenly,
  //
  //       children: [
  //
  //         Icon(Icons.home),
  //
  //         Icon(Icons.favorite),
  //
  //         Icon(Icons.bar_chart),
  //
  //         Icon(Icons.person),
  //
  //       ],
  //     ),
  //   );
  // }
}

class BlobPainter extends CustomPainter {

  final double t;

  BlobPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {

    Paint paint = Paint();

    Rect rect = Offset.zero & size;

    paint.shader = const LinearGradient(

      begin: Alignment.topLeft,

      end: Alignment.bottomRight,

      colors: [

        Color(0xffD7F0FF),

        Color(0xffD9D6FF),

        Color(0xffFFF0D8),

      ],

    ).createShader(rect);

    canvas.drawRect(rect, paint);

    drawBlob(
      canvas,
      size,
      const Offset(-80, 120),
      180,
      const Color(0xffBFE6FF),
    );

    drawBlob(
      canvas,
      size,
      Offset(
        size.width - 60,
        250,
      ),
      160,
      const Color(0xffE2D6FF),
    );

    drawBlob(
      canvas,
      size,
      Offset(
        120,
        size.height - 120,
      ),
      140,
      const Color(0xffFFF2C7),
    );
  }

  void drawBlob(
      Canvas canvas,
      Size size,
      Offset c,
      double r,
      Color color) {

    Paint paint = Paint()
      ..color = color.withOpacity(.8);

    Path path = Path();

    for (int i = 0; i <= 360; i++) {

      double angle = i * pi / 180;

      double radius =
          r +
              sin(
                  angle * 3 +
                      t * pi * 2) *
                  18;

      double x =
          c.dx + cos(angle) * radius;

      double y =
          c.dy + sin(angle) * radius;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();

    canvas.drawPath(path, paint);
  }

  void drawParticles(
      Canvas canvas,
      Size size,
      ){

    final random=Random(1);

    for(int i=0;i<35;i++){

      Paint paint=Paint()
        ..color=Colors.white.withOpacity(.35);

      double x=random.nextDouble()*size.width;

      double y=random.nextDouble()*size.height;

      canvas.drawCircle(
        Offset(x,y),
        random.nextDouble()*6+2,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant BlobPainter oldDelegate) {
    return true;
  }
}

class BubblePainter extends CustomPainter {
  final double t;

  BubblePainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(1);

    for (int i = 0; i < 30; i++) {
      final radius = random.nextDouble() * 10 + 4;

      final x = random.nextDouble() * size.width;

      final y = (random.nextDouble() * size.height +
          sin(t * 2 * pi + i) * 20) %
          size.height;

      canvas.drawCircle(
        Offset(x, y),
        radius,
        Paint()
          ..color = Colors.white.withOpacity(.18),
      );
    }
  }

  @override
  bool shouldRepaint(covariant BubblePainter oldDelegate) => true;
}

class ProgressPainter extends CustomPainter {
  final Animation<double> animation;


  ProgressPainter({
    required this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);

    const radius = 75.0;

    final bgPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..color = Colors.white.withOpacity(.25);

    canvas.drawCircle(center, radius, bgPaint);

    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24
      ..color = const Color(0xff7C4DFF).withOpacity(.20)
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        15,
      );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      animation.value * 2.4 * pi,
      false,
      glowPaint,
    );

    final fgPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 16
      ..shader = const SweepGradient(
        startAngle: -pi / 2,
        endAngle: 3 * pi / 2,
        colors: [
          Color(0xff42A5F5),
          Color(0xff7E57C2),
          Color(0xffEC407A),
        ],
      ).createShader(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
      );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      animation.value * 2.4 * pi,
      false,
      fgPaint,
    );

    final tp = TextPainter(
      text: TextSpan(
        text: "${(animation.value * 100).toInt()}%",
        style: const TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    tp.layout();

    tp.paint(
      canvas,
      Offset(
        center.dx - tp.width / 2,
        center.dy - tp.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class GraphPainter extends CustomPainter {
  final Animation<double> animation;

  GraphPainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final glow = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..color = Colors.pink.withOpacity(.15)
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        12,
      );

    final line = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..shader = const LinearGradient(
        colors: [
          Colors.pink,
          Colors.deepPurple,
        ],
      ).createShader(
        Offset.zero & size,
      );

    final path = Path();

    for (int i = 0; i <= 100; i++) {
      final x = size.width * i / 100;

      final y = size.height / 2 +
          sin(i / 8 + animation.value * 8) * 20 +
          cos(i / 4) * 6;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, glow);
    canvas.drawPath(path, line);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class WeeklyBarPainter extends CustomPainter {

  final double t;

  WeeklyBarPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {

    List<double> values=[
      40,
      75,
      55,
      90,
      60,
      82,
      45,
    ];

    double width=size.width/10;

    for(int i=0;i<7;i++){

      double h=values[i]+
          sin(t*pi*2+i)*8;

      Rect rect=Rect.fromLTWH(
        i*width*1.3,
        size.height-h,
        width,
        h,
      );

      Paint paint=Paint()
        ..shader=LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors:[
            Colors.blue.shade300,
            Colors.purple.shade300,
          ],
        ).createShader(rect);

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          rect,
          const Radius.circular(12),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate)=>true;
}

class HeartBeatCard extends StatelessWidget {

  final double value;

  const HeartBeatCard({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {

    double bpm=72+sin(value*pi*2)*4;

    return Container(

      height:90,

      padding:const EdgeInsets.all(18),

      decoration:BoxDecoration(

        color:Colors.white.withOpacity(.55),

        borderRadius:BorderRadius.circular(22),

      ),

      child:Row(

        children:[

          TweenAnimationBuilder(

            tween:Tween<double>(
              begin:1,
              end:1.18,
            ),

            duration:const Duration(
              milliseconds:600,
            ),

            curve:Curves.easeInOut,

            builder:(context,scale,child){

              return Transform.scale(
                scale:1+
                    .08*
                        sin(value*pi*6),
                child:child,
              );

            },

            child:const Icon(
              Icons.favorite,
              color:Colors.red,
              size:34,
            ),
          ),

          const SizedBox(width:15),

          Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            mainAxisAlignment:
            MainAxisAlignment.center,

            children:[

              Text(
                "${bpm.toInt()} BPM",
                style:const TextStyle(
                  fontWeight:FontWeight.bold,
                  fontSize:20,
                ),
              ),

              const SizedBox(height:1),

              const Text(
                "Heart Rate",
              )

            ],
          )

        ],
      ),
    );
  }
}
