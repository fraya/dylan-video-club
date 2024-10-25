Module: video-club-impl

define constant <rented-days>
  = limited(<integer>, min: 1);

define class <rental> (<object>)
  constant slot rental-movie :: <movie>,
    required-init-keyword: movie:;
  constant slot rental-days-rented :: <rented-days> = 1,
    init-keyword: days-rented:;
end;

define constant <rentals> =
  limited(<vector>, of: <rental>);
