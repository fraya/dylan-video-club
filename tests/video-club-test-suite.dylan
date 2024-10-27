Module: video-club-test-suite

define test test-amount-for-children-rental ()
  
  let m1 = make(<movie>, title: "Snow white", category: #"childrens");
  
  let r1 = make(<rental>, movie: m1, rented: 1);
  expect-equal(1.5, r1.charge);

  let r2 = make(<rental>, movie: m1, rented: 3);
  expect-equal(1.5, r2.charge);

  let r3 = make(<rental>, movie: m1, rented: 4);
  expect-equal(3.0, r3.charge);
  
end test;

define test test-amount-for-regular-rental ()
  
  let m1 = make(<movie>, title: "LOTR II", category: #"regular");
  
  let r1 = make(<rental>, movie: m1, rented: 1);
  expect-equal(2.0, r1.charge);

  let r2 = make(<rental>, movie: m1, rented: 2);
  expect-equal(2.0, r2.charge);

  let r3 = make(<rental>, movie: m1, rented: 3);
  expect-equal(3.5, r3.charge);
  
end test;

define test test-amount-for-new-release-rental ()
  
  let m1 = make(<movie>, title: "Dune II", category: #"new-release");
  
  let r1 = make(<rental>, movie: m1, rented: 1);
  expect-equal(3.0, r1.charge);

  let r2 = make(<rental>, movie: m1, rented: 2);
  expect-equal(6.0, r2.charge);
  
end test;

define test test-frequent-rental-points ()
  let m1 = make(<movie>, title: "Dune II", category: #"new-release");
  
  let r1 = make(<rental>, movie: m1, rented: 1);
  expect-equal(1, r1.renter-points);
  
  let r2 = make(<rental>, movie: m1, rented: 2);
  expect-equal(2, r2.renter-points);
end test;

// Use `_build/bin/video-club-test-suite --help` to see options.
run-test-application()
