/*
 *
 *   Complex static class
 *    for handling complex numbers
 *    in Processing / Java
 *    with complex trigonometric & hyperbolic functions
 *
 *
 * version : 2 -- april 2015
 * created by sodorny in 2012
 *
 *
 */


static class Complex {
  double x = 0 , y = 0;
  
  Complex (){
  }
  
  Complex ( double X , double Y ){
    this.x = X;
    this.y = Y;
  }
  
  /*
    ANOTHER WAY TO COPY
      new Complex( z ) <=> z.copy()
  */
  Complex ( Complex Z ){
    this.x = Z.x;
    this.y = Z.y;
  }
  
  /* COPY */
  Complex copy(){
    return new Complex( this.x , this.y );
  }
  
  /* SET X AND Y */
  Complex set( double X , double Y ){
    this.x = X;
    this.y = Y;
    
    return this;
  }
  
  /*
    SET X AND Y COMPLEX FROM ANOTHER COMPLEX
      z1.set( z2 ) <=> z1 = z2
  */
  Complex set( Complex z ){
    this.x = z.x;
    this.y = z.y;
    
    return this;
  }
  
  /*
    TRUE IF ZERO
      z.isZero()         <=> z == 0
      z.isZero() == true <=> z  = 0
  */
  
  boolean isZero(){
    return ( this.x == 0 && this.y == 0 );
  }
  
  static boolean isZero( double X , double Y ){
    return ( X == 0 && Y== 0 );
  }
  
  /* PRINT */
  Complex print(){
    println( "x : " + this.x + " , y : " + this.y );
    return this;
  }
 
  /* CONJUGATE */
  Complex conj(){
    this.y = - this.y;
    return this;
  }
  
  /* OPPOSITE */
  Complex opposite(){
    this.x = - this.x;
    this.y = - this.y;
    
    return this;
  }
  
  /* NORM / ABSOLUTE VALUE */
  float norm(){
    return sqrt( (float)( this.x * this.x + this.y * this.y ) );
  }
  
  /* ABSOLUTE VALUE SQUARED */
  double normSquared(){
    return ( this.x * this.x + this.y * this.y );
  }
  
  /*
    DISTANCE FROM
      compute distance from an other complex number
  */
  double distanceFrom( Complex z ){
    return this.sub( z ).norm();
  }
  
  /* ARGUMENT */
  float arg(){
    if( !this.isZero() ){
      return atan2( (float)this.y , (float)this.x );
    } else {
      println( "0 has no argument ! " + atan2( (float)this.y , (float)this.x ) );
      return 0.0;
    }
  }
  
  /*
    CREATE COMPLEX NUMBER AND SET X AND Y FROM POLAR COORDINATES ( NORM , ARG )
    z = Complex.fromPolar( z.norm() , z.arg() )
  */
  static Complex fromPolar( double norm , float arg ){
    return new Complex( norm*cos( arg ) , norm*sin( arg ) );
  }
  
  /* ADD */
  Complex add( double X ){
    this.x += X;
    
    return this;
  }
  
  Complex add( double X , double Y ){
    this.x += X;
    this.y += Y;
    
    return this;
  }
  
  Complex add( Complex z ){
    this.x += z.x;
    this.y += z.y;
    
    return this;
  }
  
  /* SUBTRACT */
  Complex sub( double X ){
    this.x -= X;
    
    return this;
  }
  
  Complex sub( double X , double Y ){
    this.x -= X;
    this.y -= Y;
    
    return this;
  }
  
  Complex sub( Complex z ){
    this.x -= z.x;
    this.y -= z.y;
    
    return this;
  }
  
  /* MULTIPLICATION BY A REAL NUMBER */
  Complex times( double X ){
    this.x *= X;
    this.y *= X;
    
    return this;
  }
  
  /* MULTIPLICATION BY THE IMAGINARY NUMBER */
  Complex i(){
    double old_x = this.x;
    
    this.x = -this.y;
    this.y = old_x;
    
    return this;
  }
  
  
  /* DIVIDE BY A REAL NUMBER */
  Complex div( double X ){
    if( X != 0 ){
      this.x /= X;
      this.y /= X;
      
      return this;
    } else {
      println( "Can't divide by 0 !" );
      this.x = this.y = 0;
      return this;
    }
  }
  
  /* MULTIPLY BY COMPLEX */
  Complex times( double X , double Y ){
    double old_x = this.x;
    
    this.x = old_x*X - this.y*Y;
    this.y = old_x*Y + this.y*X;
    
    return this;
  }
  
  Complex times( Complex z ){
    double _this_x = this.x;
    double _this_y = this.y;
    
    // Z.times( Z ) would not work otherwise
    double _z_x = z.x;
    double _z_y = z.y;
    
    this.x =  _this_x*_z_x - _this_y*_z_y;
    this.y =  _this_x*_z_y + _this_y*_z_x;
    
    return this;
  }
  
  /* INVERT */
  Complex invert(){
    if( !this.isZero() ){
      // no .copy() because z.normSquared() = z.conj().normSquared()
      return this.conj().div( this.normSquared() );
    } else {
      println( "Can't inverse 0 !" );
      this.x = this.y = 0;
      return this;
    }
  }
  
  /* DIVIDE */
  Complex div( double X , double Y ){
    if( !Complex.isZero( X , Y ) ){
      return this.times( X , -Y ).div( X*X + Y*Y );
    } else {
      println( "Can't divide by 0 !" );
      this.x = this.y = 0;
      return this;
    }
  }
  
  Complex div( Complex z ){
    if( !z.isZero() ){
      return this.times( z.copy().conj() ).div( z.normSquared() );
    } else {
      println( "Can't divide by 0 !" );
      z.x = z.y = 0;
      return this;
    }
  }
  
  /* SQUARED */
  Complex squared(){
    double old_x = this.x;
    
    this.x = old_x*old_x - this.y*this.y;
    this.y = 2*old_x*y;
    
    return this;
  }
  
  /*
    SIMILITUDES
  */
  
  // ROTATION FROM ORIGIN
  Complex rotate( float angle ){
    double cos_ = cos( angle );
    double sin_ = sin( angle );
    
    double x_ = this.x;
    this.x   = x_    *cos_ - this.y*sin_;
    this.y   = this.y*cos_ + x_    *sin_;
    
    return this;
  }
  
  // ROTATION AND EXPANSION FROM ORIGIN
  Complex rotateExpand( float angle , double factor ){
    return this.times( Complex.fromPolar( factor , angle ) );
  }
  
  // ROTATION FROM CENTER
  
  Complex rotateFrom( float angle , Complex a ){
    return this.sub( a ).rotate( angle ).add( a );
  }
  
  Complex rotateFrom( float angle , double x , double y ){
    return this.sub( x , y ).rotate( angle ).add( x , y );
  }
  
  // ROTATION AND EXPANSION FROM CENTER
  Complex rotateExpandFrom( float angle , double factor , Complex a ){
    return this.sub( a ).rotateExpand( angle , factor ).add( a );
  }
   
  Complex rotateExpandFrom( float angle , double factor , double x , double y ){
    return this.sub( x , y ).rotateExpand( angle , factor ).add( x , y );
  }
  
  /*
    NTH POWER
      compute z to the n, n being an integer
      uses times() and squared() :
      "squared exponentiation" => n=2q+r (r=0 or r=1), q=2k+r', etc...
  */
  Complex power( int n ){
    if( !this.isZero() ){
      if( n > 2 ){
        /* "heavy" computation :
        Complex old = new Complex( this );
        
        for( int i = 1 ; i < n ; i++ ){
          this.times( old );
        }*/
        
        // "smart" :
        
        Complex old = this.copy();
        
        // n = 2q + k
        int k = n % 2;
        
        // q = (n-k)/2
        this.power( ( n - k )/ 2 ).squared();
        
        if( k == 1 ){
          this.times( old );
        }
        
        // (z^q)^(2+k) = (z^q)^2 or z*(z^q)^2
        return this;
      } else if( n == 2 ){
        return this.squared();
      } else if( n == 1 ){
        return this;
      } else if( n < 0 ){
        return this.power( -n ).invert();
      }  else if( n == 0 ){
        return this.set( 1 , 0 );
      } else {
        return this;
      }
    } else {
      // return 0
      return this;
    }
  }
  
  /*
    XTH POWER
      compute z to the x, x being real
      uses norm(), arg() and fromPolar()
      norm to the x and argument by x :
      z^x = [r*e^(iA)]^x = (r^x)*e^(i[A*x])
  */
  Complex power( double x ){
    if( !this.isZero() ){
      return Complex.fromPolar(
          (double)( pow( this.norm() , (float)x ) )
        , (float)( this.arg() * x )
      );
    } else {
      return this;
    }
  }
  
  
  /*
    ZTH POWER
      compute the complex to the z, z being complex
  */
  Complex power( Complex z ){
    if( !this.isZero() ){
      float arg  = this.arg();
      float norm = this.norm();
      
      return Complex.fromPolar(
          (double)( pow( norm , (float)z.x ) / exp( (float)( arg * z.y ) ) )
        , (float)( arg*z.x + log( norm ) * z.y )
      );
    } else {
      return this;
    }
  }
  
  /*
    EVAL POLYNOMIAL
      compute P(z)=Sum{ C[i]*z^i }, for all i between 0 and (C.length - 1)
  */
  Complex evalPolynomial( double[][] coefficients ){
    Complex polynomial = new Complex();
    double[] coeff;
    
    int i = coefficients.length - 1;
    while( i >= 0 ){
      coeff = coefficients[ i ];
      
      polynomial.add( coeff[ 0 ] );
      
      if( coeff.length == 2 ){
        polynomial.add( 0 , coeff[ 1 ] );
      }
      
      if( i > 0 ){
        polynomial.times( this );
      }
      
      i--;
    }
    
    this.set( polynomial );
    return this;
  }
  
  /*
    EVAL POLYNOMIAL FROM ZEROS
      compute P(z)=Product{ z - C[i] }, for all i between 0 and (C.length - 1)
      P(z) = 0 <=> z = C[i] for all i between 0 and (C.length - 1)
  */
  Complex evalPolynomialFromZeros( double[][] coefficients ){
    Complex polynomial = new Complex( 1 , 0 );
    int     length;
    
    int i = 0;
    while( i < coefficients.length ){
      
      length = coefficients[ i ].length;
      
      if( length == 3 ){
        polynomial.times( this.copy().sub( coefficients[ i ][ 0 ] , coefficients[ i ][ 1 ] ).power( coefficients[ i ][ 2 ] ) );
      } else if( length == 2 ){
        polynomial.times( this.copy().sub( coefficients[ i ][ 0 ] , coefficients[ i ][ 1 ] ) );
      } else {
        polynomial.times( this.copy().sub( coefficients[ i ][ 0 ] ) );
      }
      
      
      i++;
    }
    
    //this.set( polynomial );
    //return this;
    return polynomial;
  }
  
  /*
    SQUARE ROOT
      complex's first square root
  */
  Complex Sqrt(){
    return Complex.fromPolar( sqrt( this.norm() ) , this.arg()/2.0 );
  }
  
  
  /* EXP */
  static Complex Exp( Complex z ){
    return Complex.fromPolar( exp( (float)z.x ) , (float)z.y );
  }
  
  /*
    LOG
      complex's log on the principal branch
  */
  static Complex Log( Complex z ){
    if( !z.isZero() ){
      return new Complex( log( z.norm() ) , z.arg() );
    } else {
      return new Complex( 0 , 0 );
    }
  }
  
  /*
    CICLE  / UNIT / NORMALIZE
      put the complex on the unit circle (keeping argument)
  */
  Complex circle(){
    if( !this.isZero() ){
      return this.div( this.norm() );
    } else {
      println( "Can't normalize 0 !" );
      this.x = this.y = 0;
      return this;
    }
  }
  
  /*
    MANDELBROT
      compute a polynomial from the complex and a finite number of iteration
      there's no escape (norm > 2 => we stop)
      the (original) mandelbrot set would be power = 2
  */
  Complex mandelbrot( int iteration , int power ){
    if( iteration > 0 ){
      
      int i = 0;
      Complex old_z = this.copy();
      
      while( i < iteration ){
        this.power( power ).add( old_z );
        i++;
      }
      
      return this;
    } else {
      return this;
    }
  }
  
  /*
    MANDELBROT SEED (JULIA)
      compute a polynomial from the complex and a finite number of iteration
      there's no escape (norm > 2 => we stop)
      the (original) julia set would be power = 2
  */
  Complex mandelbrot( int iteration , int power , Complex seed ){
    if( iteration > 0 ){
      
      int i = 0;
      while( i < iteration ){
        this.power( power ).add( seed );
        i++;
      }
      
      return this;
    } else {
      return this;
    }
  }
  
  /* COMPLEX TRIGONOMETRIC FUNCTIONS */
  
  /* COS */
  static Complex Cos( Complex z ){
    float a = exp( (float)z.y );
    float b = 1.0/a;
    
    a = a/2.0;
    b = b/2.0;
    
    return new Complex(
         cos( (float)z.x ) * ( a + b )
      , -sin( (float)z.x ) * ( a - b )
    );
    // slower
    /*return new Complex(
         cos( z.x ) * Complex.CosH( z.y )
      , -sin( z.x ) * Complex.SinH( z.y ) 
    );*/
  }
  
  /* SIN */
  static Complex Sin( Complex z ){
    float a = exp( (float)z.y );
    float b = 1.0/a;
    
    a = a/2.0;
    b = b/2.0;
    
    return new Complex(
        sin( (float)z.x ) * ( a + b )
      , cos( (float)z.x ) * ( a - b )
    );
    // slower
    /*return new Complex(
        sin( z.x ) * Complex.CosH( z.y )
      , cos( z.x ) * Complex.SinH( z.y ) 
    );*/
  }
  
  static Complex Tan( Complex z ){
    float a = tan( (float)z.x );
    float b = Complex.TanH( (float)z.y );
    
    return (new Complex( a , b )).div( 1 , -a * b );
    // slower
    //return Complex.Sin( z ).div( Complex.Cos( z ) );
  }
  
  
  /* REAL HYPERBOLIC TRIGONOMETRIC FUNCTIONS */
  static float CosH( float x ){
    return ( exp( x ) + exp( -x ) )/2.0;
  }
  
  static float SinH( float x ){
    return ( exp( x ) - exp( -x ) )/2.0;
  }
  
  static float TanH( float x ){
    return 1 - 2.0/( exp( 2*x ) + 1 );
    // or
    /*double a = exp( 2*x );
    return ( a - 1.0 ) / ( a + 1.0 );*/
  }
  
  /* REAL ARGUMENT HYPERBOLIC TRIGONOMETRIC FUNCTIONS */
  static float ArgCosH( float x ){
    return log( x + sqrt( x*x - 1 ) );
  }
  
  static float ArgSinH( float x ){
    return log( x + sqrt( x*x + 1 ) );
  }
  
  static float ArgTanH( float x ){
    return log( 2.0/( 1 - x ) - 1 )/2.0;
  }
  
  /* COMPLEX HYPERBOLIC TRIGONOMETRIC FUNCTIONS */
  static Complex CosH( Complex z ){
    return Complex.Cos( z.copy().i() );
  }
  
  static Complex SinH( Complex z ){
    return Complex.Sin( z.copy().i() ).i().opposite();
  }
  
  static Complex TanH( Complex z ){
    return Complex.Tan( z.copy().i() ).i().opposite();
  }
  
  /* COMPLEX ARGUMENT HYPERBOLIC TRIGONOMETRIC FUNCTIONS */
  static Complex ArgCosH( Complex z ){
    return Complex.Log( z.copy().add( z.copy().squared().sub( 1 ).Sqrt() ) );
  }
  
  static Complex ArgSinH( Complex z ){
    return Complex.Log( z.copy().add( z.copy().squared().add( 1 ).Sqrt() ) );
  }
  
  static Complex ArgTanH( Complex z ){
    return Complex.Log( z.copy().opposite().add( 1 ).invert().times( 2 ).sub( 1 ) ).div( 2 );
  }
  
  /* COMPLEX ARGUMENT TRIGONOMETRIC FUNCTIONS */
  static Complex ArgCos( Complex z ){
    return ArgCosH( z ).i().opposite();
  }
  
  static Complex ArgSin( Complex z ){
    return ArgSinH( z.copy().i() ).i().opposite();
  }
  
  static Complex ArgTan( Complex z ){
    return ArgTanH( z.copy().i() ).i().opposite();
  }
  
}
