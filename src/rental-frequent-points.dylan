Module: video-club-impl

define constant <renter-points>
  = limited(<integer>, min: 0);

define generic renter-points-by-category-and-days
  (cat :: <category>, rented :: <days>) => (points :: <renter-points>);

define method renter-points-by-category-and-days
    (cat :: <category>, rented :: <days>) => (points :: <renter-points>)
  1
end;

define method renter-points-by-category-and-days
    (cat == #"new-release", rented :: <days>) => (points :: <renter-points>)
  if (rented > 1) 2 else 1 end
end;

define function renter-points-by-movie-and-days
    (movie :: <movie>, rented :: <days>) => (points :: <renter-points>)
  renter-points-by-category-and-days(movie.movie-category, rented)
end;

define generic renter-points
  (object :: <object>) => (points :: <renter-points>);

define method renter-points
    (rental :: <rental>) => (points :: <renter-points>)
  renter-points-by-movie-and-days(rental.rental-movie, rental.rental-rented)
end;

define method renter-points
    (customer :: <customer>) => (points :: <renter-points>)
  reduce(\+, 0, map-as(<vector>, renter-points, customer.customer-rentals))
end;
