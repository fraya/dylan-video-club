Module: video-club-test-suite

define test test-amount-for-children-rental ()
  
  let m1 = make(<movie>, title: "Snow white", price-code: $childrens);
  
  let r1 = make(<rental>, movie: m1, days-rented: 1);
  expect-equal(1.5, r1.rental-amount);

  let r2 = make(<rental>, movie: m1, days-rented: 3);
  expect-equal(1.5, r2.rental-amount);

  let r3 = make(<rental>, movie: m1, days-rented: 4);
  expect-equal(3.0, r3.rental-amount);
  
end test;

define test test-amount-for-regular-rental ()
  
  let m1 = make(<movie>, title: "LOTR II", price-code: $regular);
  
  let r1 = make(<rental>, movie: m1, days-rented: 1);
  expect-equal(2.0, r1.rental-amount);

  let r2 = make(<rental>, movie: m1, days-rented: 2);
  expect-equal(2.0, r2.rental-amount);

  let r3 = make(<rental>, movie: m1, days-rented: 3);
  expect-equal(3.5, r3.rental-amount);
  
end test;

define test test-amount-for-new-release-rental ()
  
  let m1 = make(<movie>, title: "Dune II", price-code: $new-release);
  
  let r1 = make(<rental>, movie: m1, days-rented: 1);
  expect-equal(3.0, r1.rental-amount);

  let r2 = make(<rental>, movie: m1, days-rented: 2);
  expect-equal(6.0, r2.rental-amount);
  
end test;

// Use `_build/bin/video-club-test-suite --help` to see options.
run-test-application()
