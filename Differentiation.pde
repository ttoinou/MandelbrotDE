/*
 *
 *   Differentiation use to derive (or sobel) image
 *
 *
 * version : 2 -- april 2015
 * created by sodorny in 2012
 *
 *
 */

float[][] sobel( float[][] cible , float[][] filtre )
{
  float[][] result = new float[ Height ][ Width ];
  float a;
  
  for( int i = 0 ; i < Width ; i++ )
  {
    for( int j = 0 ; j < Height ; j++ )
    {
      a = 0;
      
      if( i > 0 && i < Width - 1 && j > 0 && j < Height - 1 )
      {
        
        for( int x = 0 ; x < widthSobel ; x++ )
        { 
          for( int y = 0 ; y < widthSobel ; y++ )
          {
            
            a += filtre[ y ][ x ] * cible[ j - y + centerSobel ][ i - x + centerSobel ];
            
          }
        }
        
      } 
      
      result[ j ][ i ] = a;
    }
  }
  
  return result;
}

