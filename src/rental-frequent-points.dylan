Module: video-club-impl

define constant <renter-points>
  = limited(<integer>, min: 0);

define generic movie-renter-points
  (movie :: <movie>, days-rented :: <rented-days>) => (points :: <renter-points>);

define method movie-renter-points
    (movie :: <movie>, days-rented :: <rented-days>)
 => (points :: <renter-points>)
  1
end;

define method movie-renter-points
    (movie :: <new-release-movie>, days-rented :: <rented-days>)
 => (points :: <renter-points>)
  if (days-rented > 1) 2 else 1 end
end;

define generic renter-points
  (object :: <object>) => (points :: <renter-points>);

define method renter-points
    (rental :: <rental>)
 => (points :: <renter-points>)
  movie-renter-points(rental.rental-movie, rental.rental-days-rented)
end;

define method renter-points
    (customer :: <customer>)
 => (points :: <renter-points>)
  reduce(\+, 0, map-as(<vector>, renter-points, customer.customer-rentals))
end;
