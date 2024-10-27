Module: video-club-impl

define abstract class <statement> (<object>)
  constant slot statement-customer :: <customer>,
    required-init-keyword: customer:;
end;

define class <text-statement> (<statement>) end;
define class <html-statement> (<statement>) end;

// header

define generic print-header
    (statement :: <statement>, stream :: <stream>) => ();

define method print-header
    (statement :: <statement>, stream :: <stream>) => ()
end;

define method print-header
    (statement :: <html-statement>, stream :: <stream>) => ()
  format(stream, """
    <html>
      <head> <title> Statement </title> </head>
    <body>
    """)
end;

define generic print-customer
    (statement :: <statement>, stream :: <stream>, customer :: <customer>) => ();

define method print-customer
    (statement :: <text-statement>, stream :: <stream>, customer :: <customer>) => ()
  format(stream, "Rental Record for %s\n", customer.customer-name)
end;

define method print-customer
    (statement :: <html-statement>, stream :: <stream>, customer :: <customer>) => ()
  format(stream, "<p> Rental Record for %s </p>\n", customer.customer-name)
end;

define generic print-rentals
    (statement :: <statement>, stream :: <stream>, rentals :: <rentals>) => ();

define method print-rentals
    (statement :: <statement>, stream :: <stream>, rentals :: <rentals>) => ()
  for (rental in rentals)
    let title = rental.rental-movie.movie-title;
    let amount = rental.charge;
    print-rental-line(statement, stream, title, amount)
  end
end;

define method print-rentals
    (statement :: <html-statement>, stream :: <stream>, rentals :: <rentals>) => ()
  format(stream, "<table>\n");
  next-method();
  format(stream, "</table>\n")
end;

define generic print-rental-line
    (statement :: <statement>, stream :: <stream>, title :: <string>, amount :: <money>) => ();

define method print-rental-line
    (statement :: <text-statement>, stream :: <stream>, title :: <string>, amount :: <money>) => ()
  format(stream, "\t%20s\t%5d\n", title, amount);
end;

define method print-rental-line
    (statement :: <html-statement>, stream :: <stream>, title :: <string>, amount :: <money>) => ()
  format(stream, "<hr> <td> %s </td> <td> %s </td> </hr>\n", title, amount)
end;

define generic print-amount
    (statement :: <statement>, stream :: <stream>, amount :: <money>) => ();

define method print-amount
    (statement :: <text-statement>, stream :: <stream>, amount :: <money>) => ()
  format(stream, "Amount owed is %d\n", amount)
end;

define method print-amount
    (statement :: <html-statement>, stream :: <stream>, amount :: <money>) => ()
  format(stream, "<p> Amount owed is %d </p>\n", amount)
end;

define generic print-renter-points
    (statement :: <statement>, stream :: <stream>, points :: <renter-points>) => ();

define method print-renter-points
    (statement :: <text-statement>, stream :: <stream>, points :: <renter-points>) => ()
  format(stream, "You earned %d frequent renter points\n", points)
end;

define method print-renter-points
    (statement :: <html-statement>, stream :: <stream>, points :: <renter-points>) => ()
  format(stream, "<p> You earned %d frequent renter points </p>\n", points)
end;

define generic print-footer
    (statement :: <statement>, stream :: <stream>) => ();

define method print-footer
    (statement :: <statement>, stream :: <stream>) => ()
end;

define method print-footer
    (statement :: <html-statement>, stream :: <stream>) => ()
  format(stream, "<body>\n<html>\n")
end;

define generic print-statement
    (statement :: <statement>, stream :: <stream>) => ();

define method print-statement
    (statement :: <statement>, stream :: <stream>) => ()
  let customer = statement.statement-customer;
  print-header(statement, stream);
  print-customer(statement, stream, customer);
  print-rentals(statement, stream, customer.customer-rentals);
  print-amount(statement, stream, customer.charge);
  print-renter-points(statement, stream, customer.renter-points);
  print-footer(statement, stream);
end print-statement;
