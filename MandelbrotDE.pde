/*
 *
 *   Mandelbrot Distance Estimator sketch for Processing
 *
 * 
 * generate mandelbrot fractals with a nice coloring algorithm
 * thanks to the modulus of the derivative of the distance to the
 * mandelbrot for the brightness and the distance to the set
 * mapped to a basic linear interpoled color gradient
 *
 * somes images at http://www.fractalforums.com/images-showcase-%28rate-my-fractal%29/classic-mandelbrot-with-distance-and-gradient-for-coloring
 *
 * generate multiple images for tweaking with your
 * favorite image processing software
 * the angle si not very precise, someone should
 * try to remove aliasing
 * 
 *
 * version : 12 -- april 2015
 * created by sodorny in 2014
 *
 *
 */

/*
 * OUTPUT
 */

int Width  = 1920;
int Height = 1080;

int n = 341;

// generate 5 images
String Output = "mandelbrotDE_"+n+"_derivativemodulus.png";
String Output2 = "mandelbrotDE_"+n+"_angle.png";
String Output3 = "mandelbrotDE_"+n+"_distance.png";
String Output4 = "mandelbrotDE_"+n+"_spirals.png";
String Output5 = "mandelbrotDE_"+n+"_distanceNB.png";

float  darkCoeff = 6.0; // bigger brighter
float  distanceNBpow = 0.5;

float  angleCoeff = 1.0; // has to be integer !
float  angleShift = 0.0;

// beware no more than 4
int    AntiAlias = 2;

// We have to compute more iterations in order to
// have a good approximation of the distace to the set
// 5 for float and mandelbrot of degree 2
int    NbMoreIterations = 5;

double EscapeNorm = 2;



/*
 * FRACTAL LOCATION
 */
 
// true to enable generation of the mandelbrot set
// with a mercator map
// doesn't work because we would have to tweak the distance
// to the set
boolean LogarithmicPolar = false;
 
int    NbIterations = 3000;
double CenterX = -1.94096003752344787;
double CenterY = 0.00101539057976339525;
double MinRadius = 1.0 / 1.2254019E8;
float  distanceCoeff = 3.0;
float  distanceShift = 0.0;
/*
int    NbIterations = 5000;
double CenterX = -1.253523143920355;
double CenterY = 0.3845745130633868;
double MinRadius = 1.0 / 1710203.9;
float  distanceCoeff = 6.0;
float  distanceShift = 0.8;

*/
/*
int    NbIterations = 5000;
double CenterX = -1.260267513796455;
double CenterY = 0.3797213893496971;
double MinRadius = 1.0 / 21848704;
float  distanceCoeff = 5.0;
float  distanceShift = 0.0;

*/
/*
int    NbIterations = 200;
double CenterX = -0.609995225892;
double CenterY = 0.61641281359985;
double MinRadius = 1.0 / 3201.3771;
float  distanceCoeff = 8.0;
float  distanceShift = 0.0;

*/
/*
int    NbIterations = 250;
double CenterX = -1.9424390625002;
double CenterY = -2.604166666635e-7;
double MinRadius = 1.0 / 117551.02;
float  distanceCoeff = 12.0;
float  distanceShift = 0.1;
*/
/*
int    NbIterations = 400;
double CenterX = -1.4807298156721555;
double CenterY = -0.0013863419596330815;
double MinRadius = 1.0 / 7585185.3;
float  distanceCoeff = 6.0;
float  distanceShift = 0.1;
*/

/*
int    NbIterations = 200;
double CenterX = -1.476011284719;
double CenterY = 0.004166666666667;
double MinRadius = 1.0 / 15026.087;
float  distanceCoeff = 16.0;
float  distanceShift = 0.1;
*/

/*
int    NbIterations = 1000;
double CenterX = -1.628181464723825;
double CenterY = 0.0135707000737669;
double MinRadius = 1.0 / 214950.44;
float  distanceCoeff = 16.0;
float  distanceShift = 0.1;
*/

/*
int    NbIterations = 1000;
double CenterX = -0.578631369143480066;
double CenterY = 0.6315183877483664205;
double MinRadius = 0.00015;
float  distanceCoeff = 12.0;
float  distanceShift = 0.1;
*/

/*
int    NbIterations = 1000;
double CenterX = -0.578631369143480066;
double CenterY = 0.6315183877483664205;
double MinRadius = 0.00001;
float  distanceCoeff = 12.0;
float  distanceShift = 0.1;
*/
/*
double EscapeNorm = 2;
double CenterX = -0.8;
double CenterY = 0.0;
double MinRadius = 1.3;
*/
/*
double EscapeNorm = 512;
int    NbIterations = 1000;
double CenterX = -0.578631369143480066;
double CenterY = 0.6315183877483664205;
double MinRadius = 0.9;*/
/*
double EscapeNorm = 1024;
int    NbIterations = 150;
double CenterX = -1.51;
double CenterY = 0.0;
double MinRadius = 0.00004;*/
/*
double EscapeNorm = 10000;
int    NbIterations = 100;
double CenterX = -0.5;
double CenterY = 0.0;
double MinRadius = 1.1;
*/


/*
 * COLORS
 */
boolean interiorWhite = false;

// RYGCBM
int[][] colors = new int[][]{
    new int[]{ 255 , 0  , 0 }
  , new int[]{ 255 , 255 , 0 }
  , new int[]{ 0 , 255 , 0 }
  , new int[]{ 0 , 255 , 255 }
  , new int[]{ 0 , 0 , 255 }
  , new int[]{ 255 , 0 , 255 }
};


/*
int[][] colors = new int[][]{
    new int[]{ 255 , 0  , 0 }
  , new int[]{ 0 , 0 , 0 }
  , new int[]{ 0 , 255 , 0 }
  , new int[]{ 0 , 0 , 0 }
  , new int[]{ 0 , 0 , 255 }
  , new int[]{ 0 , 0 , 0 }
};
*/
/*
int[][] colors = new int[][]{
    new int[]{ 255 , 0  , 0 }
  , new int[]{ 0 , 255 , 0 }
  , new int[]{ 0 , 0 , 255 }
};*/
/*
int[][] colors = new int[][]{
    new int[]{ 255 , 0  , 0 }
  , new int[]{ 255 , 255 , 255 }
  , new int[]{ 0 , 255 , 0 }
  , new int[]{ 255 , 255 , 255 }
  , new int[]{ 0 , 0 , 255 }
  , new int[]{ 255 , 255 , 255 }
};
*/
/*
int[][] colors = new int[][]{
    new int[]{ 255 , 0  , 0 }
  , new int[]{ 255 , 255 , 0 }
  , new int[]{ 0 , 255 , 0 }
  , new int[]{ 0 , 255 , 255 }
  , new int[]{ 0 , 0 , 255 }
  , new int[]{ 255 , 0 , 255 }
};
*/
/*
int[][] colors = new int[][]{
    new int[]{ 255 , 0  , 0 }
  , new int[]{ 0 , 0 , 255 }
};*/
/*
int[][] colors = new int[][]{
    new int[]{ 255 , 0  , 0 }
  , new int[]{ 0 , 0 , 0 }
  , new int[]{ 0 , 0 , 0 }
  , new int[]{ 0 , 0 , 255 }
  , new int[]{ 0 , 0 , 0 }
  , new int[]{ 0 , 0 , 0 }
};*/
/*
int[][] colors = new int[][]{
    new int[]{ 128 , 32 , 128 }
  , new int[]{ 144 , 48 , 64 }
};*/
/*
int[][] colors = new int[][]{
    new int[]{ 144 , 32 , 128 }
  , new int[]{ 32 , 0 , 144 }
};
*/
/*
int[][] colors = new int[][]{
    new int[]{ 255 , 255  , 255 }
  , new int[]{ 255 , 0 , 0 }
  , new int[]{ 255 , 128 , 0 }
  , new int[]{ 0 , 255 , 0 }
  , new int[]{ 64 , 255 , 64 }
  , new int[]{ 0 , 128 , 255 }
};*/
/*
int[][] colors = new int[][]{
    new int[]{ 255 , 255  , 255 }
  , new int[]{ 32 , 32 , 128 }
  , new int[]{ 210 , 144 , 0 }
};*/


// IMAGE MODE OPTIONS
/*
// SOBEL
float[][] sobelX = new float[][]{
    new float[]{ 1 , 2 , 1 }
  , new float[]{ 0 , 0 , 0 }
  , new float[]{ -1 , -2 , -1 }
};

float[][] sobelY = new float[][]{
    new float[]{ -1 , 0 , 1 }
  , new float[]{ -2 , 0 , 2 }
  , new float[]{ -1 , 0 , 1 }
};
*/
// DERIVATIVE
float[][] sobelX = new float[][]{
    new float[]{ 0 , 1 , 0 }
  , new float[]{ 0 , 0 , 0 }
  , new float[]{ 0 , -1 , 0 }
};

float[][] sobelY = new float[][]{
    new float[]{ 0 , 0 , 0 }
  , new float[]{ -1 , 0 , 1 }
  , new float[]{ 0 , 0 , 0 }
};

int widthSobel = 3;
int centerSobel = 1;

Complex iteration( Complex z , Complex c , int i ){
  // z^2 + c
  return z.squared().add( c );
  
  // others formulas can be tried
  //return z.squared().add( c );
  //return z.copy().squared().times( z ).add( c );
  //return z.squared().squared().add( c );
  //return z.copy().times( c ).add( 1 ).squared().add( -1 ).squared().add( -1 );
  //return z.copy().times( c ).add( -1 ).squared().add( -1 ).squared().add( -1 );
  
  /*if( i % 3 == 0 ){
    return z.times( c ).sub( 1 );
  } else {
    return z.squared().sub( 1 );
  }*/
}

Complex iterationDiff( Complex z , Complex dz , Complex c , int i ){
  // z * dz + 1 derivative on the variable c of z^2 + c
  return z.copy().times( dz ).times( 2 ).add( 1 );
  
  //return z.copy().times( dz ).times( 2 ).add( 1 );
  //return z.copy().squared().times( dz ).times( 3 ).add( 1 );
  //return z.copy().squared().times( z ).times( dz ).times( 4 ).add( 1 );
  
  //Complex zc1 = z.copy().times( c ).add( -1 );
  //return zc1.copy().squared().add( -1 ).times( zc1 ).times( 4 ).times( z.copy().add( dz.copy().times( c ) ) );
  
  /*Complex A = dz.copy().times( c ).add( z ).times( 2 ).times( z.copy().times( c ).add( -1 ) ).times( dz.copy().times( c ).add( z ).add( -1 ) );
  A = A.squared();
  return z.copy().times( c ).add( -1 ).squared().add( -1 ).times( A ).times( 2 );*/
  //return dz;
  
  /*
  if( i % 3 == 0 ){
    return z.copy().add( dz.copy().times( c ) );
  } else {
    return z.copy().times( dz ).times( 2 );
  }*/
}

Complex mapping( Complex c ){
  if( LogarithmicPolar ){
    // mercator map :
    return Complex.Exp( c ).add( CenterX , CenterY );
  } else {
    // basic mandelbrot
    return c;
    // inversion
    //return c.invert().sub( 1 , 0.5 );
  }
}
 
/*
 * PROGRAM
 */

double Ratio = (double)Width/Height;
double RatioInv = 1.0/Ratio;
boolean Wide = Width > Height ? true : false;

double xMin;
double xMax;
double yMin;
double yMax;

double deltaX;
double deltaY;

double getX( double xScreen ){
  return xScreen*deltaX/Width + xMin;
}

double getY( double yScreen ){
  return yScreen*deltaY/Height - yMax;
}

double zoomxMin;
double zoomxMax;
double zoomyMin;
double zoomyMax;

float[][] mandelbrotDistance;
float[][] mandelbrotDistance2;
float[][] mandelbrotSobelX;
float[][] mandelbrotSobelY;
float[][] mandelbrotSobel;
float[][] mandelbrotAngle;

float darkCoeff2 = 1.0/(1.0 - exp(-darkCoeff));
int nbColors = colors.length;
color interiorColor;

double EscapeNormSquared;

PImage background;
PImage img;

void setup(){
        
  EscapeNormSquared = EscapeNorm * EscapeNorm;
  
  if( LogarithmicPolar == false ){
    if( Wide ){
      xMin = CenterX - MinRadius*Ratio;
      xMax = CenterX + MinRadius*Ratio;
      yMin = CenterY - MinRadius;
      yMax = CenterY + MinRadius;
    
      deltaX = 2*MinRadius*Ratio;
      deltaY = 2*MinRadius;
    } else {
      yMin = CenterY - MinRadius*RatioInv;
      yMax = CenterY + MinRadius*RatioInv;
      xMin = CenterX - MinRadius;
      xMax = CenterX + MinRadius;
    
      deltaY = 2*MinRadius*RatioInv;
      deltaX = 2*MinRadius;
    }
  } else {
      yMin = 0;
      yMax = TWO_PI;
      deltaY = TWO_PI;
      
      deltaX = ( deltaY*Ratio );
      xMax = MinRadius;
      
      xMin = xMax - deltaX;
    
  }
  
  size( Width , Height );
  colorMode( HSB , 1 , 1 , 1 );
  
  compute();
  
  
  mandelbrotSobelX = sobel( mandelbrotDistance , sobelX );
  mandelbrotSobelY = sobel( mandelbrotDistance , sobelY );
  
  mandelbrotSobel  = new float[ Height ][ Width ];
  float minMandelbrotDistance = -1;
  float maxMandelbrotSobel = 0;
  float a;
  
  mandelbrotAngle = new float[ Height ][ Width ];
  
  for( int i = 1 ; i < Width-1 ; i++ )
  {
    for( int j = 1 ; j < Height-1 ; j++ )
    {
      a = sqrt( ( mandelbrotSobelX[ j ][ i ]*mandelbrotSobelX[ j ][ i ] + mandelbrotSobelY[ j ][ i ]*mandelbrotSobelY[ j ][ i ] ) );
      if( i==1 && j==1 )
      {
        maxMandelbrotSobel = a;
        minMandelbrotDistance = mandelbrotDistance[ j ][ i ];
      }
      else 
      {
        if( a > maxMandelbrotSobel )
        {
          maxMandelbrotSobel = a;
        }
        if( mandelbrotDistance[ j ][ i ] < minMandelbrotDistance )
        {
          minMandelbrotDistance = mandelbrotDistance[ j ][ i ];
        }
      }
      mandelbrotSobel[ j ][ i ] = a;
      mandelbrotAngle[ j ][ i ] = atan2( mandelbrotSobelY[ j ][ i ] , mandelbrotSobelX[ j ][ i ] );
    }
  }
  
  mandelbrotSobelX = null;
  mandelbrotSobelY = null;
  
  
  mandelbrotDistance2 = new float[ Height ][ Width ];
  
  float M = 0;
  for( int i = 0 ; i < Width ; i++ )
  {
    for( int j = 0 ; j < Height ; j++ )
    {
      if( M == 0 || mandelbrotDistance[ j ][ i ] > M )
      {
        M = mandelbrotDistance[ j ][ i ];
      }
    }
  }
  
  // Derivative modulus
  
  for( int i = 0 ; i < Width ; i++ )
  {
    for( int j = 0 ; j < Height ; j++ )
    {
      mandelbrotDistance2[ j ][ i ] = ( mandelbrotDistance[ j ][ i ] / M ) * distanceCoeff + distanceShift;
      
      mandelbrotSobel[ j ][ i ] = ( 1.0 - exp( - darkCoeff * mandelbrotSobel[ j ][ i ] / maxMandelbrotSobel ) ) * darkCoeff2;
      
      if( interiorWhite )
      {
        mandelbrotSobel[ j ][ i ] = 1.0 - mandelbrotSobel[ j ][ i ];
      }
      
      //set( i , j , color( 0 , 0.0 , mandelbrotDistance[ j ][ i ]/M ) );
      
      //mandelbrotSobel[ j ][ i ] = ( 1.0 - exp( - darkCoeff * mandelbrotDistance[ j ][ i ] / M ) ) * darkCoeff2;
      set( i , j , color( 0 , 0.0 , mandelbrotSobel[ j ][ i ] ) );
      //set( i , j , color( 0 , 0.0 , mandelbrotDistance2[ j ][ i ] ) );
    }
  }
  
  save( Output );
  
  
  // Distance NB without exponential
  
  for( int i = 0 ; i < Width ; i++ )
  {
    for( int j = 0 ; j < Height ; j++ )
    { 
      set( i , j , color( 0.0 , 0.0 , pow( mandelbrotDistance[ j ][ i ] / M , distanceNBpow ) ) );
    }
  }
  
  save( Output5 );
  
  
  colorMode( RGB , 255 , 255 , 255 );
  
  // Angle
  
  for( int i = 0 ; i < Width ; i++ )
  {
    for( int j = 0 ; j < Height ; j++ )
    {
      
      if( mandelbrotAngle[ j ][ i ] >= 0 )
      {
        mandelbrotAngle[ j ][ i ] = mandelbrotAngle[ j ][ i ]/TWO_PI;
      }
      else
      {
        mandelbrotAngle[ j ][ i ] = mandelbrotAngle[ j ][ i ]/TWO_PI + 1;
      }
      
      set( i , j , getColor( mandelbrotAngle[ j ][ i ] * angleCoeff + angleShift , mandelbrotSobel[ j ][ i ] , mandelbrotDistance[ j ][ i ]==0.0 ) );
    }
  }
  
  save( Output2 );
  
  // Distance
  
  for( int i = 0 ; i < Width ; i++ )
  {
    for( int j = 0 ; j < Height ; j++ )
    {
      set( i , j , getColor( mandelbrotDistance2[ j ][ i ] , mandelbrotSobel[ j ][ i ] , mandelbrotDistance[ j ][ i ]==0.0 ) );
    }
  }
  
  save( Output3 );
  
  // Spirals
  
  for( int i = 0 ; i < Width ; i++ )
  {
    for( int j = 0 ; j < Height ; j++ )
    { 
      set( i , j , getColor( (mandelbrotDistance2[ j ][ i ] + mandelbrotAngle[ j ][ i ] * angleCoeff + angleShift) ,  mandelbrotSobel[ j ][ i ] , mandelbrotDistance[ j ][ i ]==0.0 ) );
    }
  }
  
  save( Output4 );
  
  draw();
}

void compute(){
  Complex z = new Complex();
  Complex dz = new Complex();
  color   col;
  float   bright;
  int n;
  int more;
  boolean continuer;
  int nMin = 0;
  int moreMin = 0;
  Complex zMin = new Complex();
  Complex dzMin = new Complex();
      
  Complex c = new Complex();
  float a;
  float b = 0.0;
  int i , j;
  
  loadPixels();
  
  mandelbrotDistance = new float[ Height ][ Width ];
  
  i = 0;
  while( i < Width ){
    
    j = 0;
    while( j < Height ){
      
      for( int p = 0 ; p < AntiAlias ; p++ ){
        for( int q = 0 ; q < AntiAlias ; q++ ){
              
          n = 0;
          z.set( getX( i + (float)(p)/AntiAlias ) , getY( j + (float)(q)/AntiAlias ) );
          c = mapping( z.copy() );

          z = new Complex( 0 , 0 );
          //dz = new Complex( 0 , 0 );
          
          //more = z.normSquared() > EscapeNormSquared ? 1 : 0;
          more = 0;
          
          while( (more == 0 && n < NbIterations) || (more > 0 && more < NbMoreIterations) ){
            
            dz = iterationDiff( z , dz , c , n + more );
            z = iteration( z , c , n + more );
            
            if( more > 0 || z.normSquared() > EscapeNormSquared )
            {
              more++;
            }
            else
            {
              n++;
            }
          }
          
          if( n == NbIterations ){
            b = 0.0;
          } else {
            b = n + 1 - log( log( (float)z.normSquared() )/2.0)/log(2.0);
          }
          
          if( ( p==0 && q==0 ) || n < nMin ){
            nMin = n;
            moreMin = more;
            zMin = z.copy();
            dzMin = dz.copy();
          }
          
        }
      }
      
      n = nMin;
      more = moreMin;
      z = zMin;
      dz = dzMin;
      
      if( more == 0 ){
        a = 0.0;
      } else {
        // distance to the set computation
        // thanks to 1/4 keobe theorem
        a = sqrt( (float)( z.normSquared()/dz.normSquared() ) )*0.5*log( (float)z.normSquared() );
      }
      
      /*
      if( z.normSquared() == Double.POSITIVE_INFINITY )
      {
        //a = (float)n;
        print( "z" + n + "\n" );
      }
      
      if( dz.normSquared() == Double.POSITIVE_INFINITY )
      {
        //a = (float)n;
        print( "dz " + n + "\n" );
      }
      
      
      if( a == Float.POSITIVE_INFINITY )
      {
        //a = (float)n;
        //print( "a " + more + "\n" );
      }
      */
      
      if( LogarithmicPolar )
      {
        // we need to tweak the distance...
      }
       
      mandelbrotDistance[ j ][ i ] = a;
      
      j++;
    }
    
    i++;
  }
  
}


color getColor( float x , float noir , boolean interieur )
{
  if( interieur )
  {
    return interiorColor;
  }
  
  x = x % 1.0;
  if( x < 0 )
  {
    x += 1.0;
  }
  
  float y = x*nbColors % 1.0;
  int n = (int)ceil(nbColors*x - y);
  int m = n+1;
  
  if( m >= nbColors )
  {
    m = 0;
  }
  
  y = (1.0 - cos(PI*y))/2.0;
  x = 1.0 - y;
  float r,g,b;
  
  r = colors[ n ][ 0 ]*x + colors[ m ][ 0 ]*y;
  g = colors[ n ][ 1 ]*x + colors[ m ][ 1 ]*y;
  b = colors[ n ][ 2 ]*x + colors[ m ][ 2 ]*y;
  
  if( interiorWhite )
  {
    return color( (int)(noir*(r-255.0)+255.0) , (int)(noir*(g-255.0)+255.0) , (int)(noir*(b-255.0)+255.0) );
  }
  else
  {
    return color( (int)(noir*r) , (int)(noir*g) , (int)(noir*b) );
  }
}
