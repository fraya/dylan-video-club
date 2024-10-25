Module: video-club-impl

define function statement
    (customer :: <customer>)
 => (result :: <string>)
  with-output-to-string (stream)
    format(stream, "Rental Record for %s\n", customer.customer-name);
    for (rental in customer.customer-rentals)
      let title  = rental.rental-movie.movie-title;
      let charge = rental.rental-charge;
      format(stream, "\t%20s\t%5d\n", title, charge);
    end for;

    // add footer lines
    let charge = customer.customer-charge;
    let points = customer.renter-points;
    format(stream, "Amount owed is %d\n", charge);
    format(stream, "You earned %d frequent renter points", points);
  end with-output-to-string;
end statement;
