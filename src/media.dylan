Module: video-club-impl

define abstract class <statement> (<object>)
  constant slot statement-customer :: <customer>,
    required-init-keyword: customer:;
end;

define class <text-statement> (<statement>) end;
define class <html-statement> (<statement>) end;

define generic print-statement
    (statement :: <statement>, stream :: <stream>) => ();

define method print-statement
    (statement :: <text-statement>, stream :: <stream>)
 => ()
  let customer = statement.statement-customer;
  format(stream, "Rental Record for %s\n", customer.customer-name);
  for (rental in customer.customer-rentals)
    let title  = rental.rental-movie.movie-title;
    let charge = rental.rental-charge;
    format(stream, "\t%20s\t%5d\n", title, charge);
  end;
  format(stream, "Amount owed is %d\n", customer.customer-charge);
  format(stream, "You earned %d frequent renter points", customer.renter-points); 
end;

define method print-statement
    (statement :: <html-statement>, stream :: <stream>)
 => ()
  let customer = statement.statement-customer;

  format(stream, """
  <html>
    <head> <title> Statement </title> </head>
  <body>
  <p> Rental Record for %s </p>\n
  """, customer.customer-name);
  
  format(stream, "<table>\n");
  for (rental in customer.customer-rentals)
    let title  = rental.rental-movie.movie-title;
    let charge = rental.rental-charge;
    format(stream, 
    """
    <hr>
      <td> %s </td>
      <td> %s </td>
    </hr>
    """, title, charge);
  end for;
  format(stream, "\n</table>");

  format(stream, """
  <p> Amount owed is %d </p>
  <p> You earned %d frequent renter points </p>
  </body>
  </html>
  """, customer.customer-charge, 
       customer.renter-points);
 end;