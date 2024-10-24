Module: video-club-app

define function main
    (name :: <string>, arguments :: <vector>)
  let v1 = make(<movie>, title: "Snowwhite", price-code: $childrens);
  let v2 = make(<movie>, title: "LOTR II", price-code: $regular);
  let v3 = make(<movie>, title: "Dune III", price-code: $new-release);

  let r1 = make(<rental>, movie: v1, days-rented: 1);
  let r2 = make(<rental>, movie: v2, days-rented: 1);
  let r3 = make(<rental>, movie: v3, days-rented: 1);

  let c1 = make(<customer>, name: "Juan");
  add-rental!(c1, r1);
  add-rental!(c1, r2);
  add-rental!(c1, r3);

  format-out("%s\n", c1.statement);
  exit-application(0);
end function;

main(application-name(), application-arguments());
