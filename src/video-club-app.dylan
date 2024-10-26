Module: video-club-app

define function main
    (name :: <string>, arguments :: <vector>)
  let v1 = make(<movie>, title: "Snow white", category: #"childrens");
  let v2 = make(<movie>, title: "LOTR II", category: #"regular");
  let v3 = make(<movie>, title: "Dune III", category: #"new-release");

  let c1 = make(<customer>, name: "Juan");
  add-rental!(c1, make(<rental>, movie: v1));
  add-rental!(c1, make(<rental>, movie: v2));
  add-rental!(c1, make(<rental>, movie: v3));

  format-out("%s\n", c1.statement);
  exit-application(0);
end function;

main(application-name(), application-arguments());
